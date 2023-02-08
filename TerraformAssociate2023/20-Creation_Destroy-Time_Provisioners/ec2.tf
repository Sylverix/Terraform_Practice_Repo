data "aws_ami" "latest-linux-ec2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}

resource "aws_instance" "nano-provisioner-demo" {
  ami = data.aws_ami.latest-linux-ec2.id

  instance_type = var.instance-type
  key_name      = aws_key_pair.tf-key-pair.key_name

  security_groups = [aws_security_group.terraform-sg.name]

  tags = {
    "Name" = "Demo-${var.instance-type}"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = tls_private_key.rsa.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nano"
    ]
  }

  /*
  Cannot run destroy provisioners when calling private key from a variable.

  """
  Error: Invalid reference from destroy provisioner
    on ec2.tf line 32, in resource "aws_instance" "nano-provisioner-demo":
    32:     private_key = tls_private_key.rsa.private_key_pem
  
  Destroy-time provisioners and their connection configurations may only reference attributes of the related resource, via 'self', 'count.index', or 'each.key'.

  References to other resources during the destroy phase can cause dependency cycles and interact poorly with create_before_destroy.
  """

  Pem key needs to be manually downloaded and placed in CWD of TF Project.
  Connection needs to call Pem file using 'file()' function in order for
  destroy provisioner to work properly.
  */

  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo yum -y remove nano"
    ]
  }
}
