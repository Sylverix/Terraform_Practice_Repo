data "aws_ami" "latest-linux-ec2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "instance-type" {
  type = map
  default = {
    nano = "t2.nano",
    micro = "t2.micro",
    small = "t2.small"
  }
}

resource "aws_instance" "provisioner-demo" {
  ami = data.aws_ami.latest-linux-ec2.id

  instance_type = var.instance-type["micro"]
  key_name = aws_key_pair.terraform-key.key_name

  tags = {
    "Name" = "Demo-${var.instance-type["micro"]}"
  }

  /*
  Cannot remote invoke command using provisioner
  as it needs to have SG allow Port 22 for SSH.

  However, when creating the EC2 Instance, Terraform
  will try to finish creating the EC2 instance first before
  it will apply the SG to the Primary Network Interface of
  the instance.

  The best workaround is to utilize the 'user_data' command
  instead of provisioner if trying to run scripts on creation.

  Lastly, it seems that provisioner only works during the startup/creation
  phase. If you want the provisioner to execute on creation of EC2 Instance, 
  create and download the key_pair first and store it in the
  local directory where you are working with Terraform, then call it in
  'private_key' using the 'file()' function.
  */

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo syustemctl start nginx"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = tls_private_key.private-key.private_key_pem
    }
  }

}
