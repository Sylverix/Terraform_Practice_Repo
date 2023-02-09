data "aws_ami" "latest-linux-ec2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}

resource "aws_instance" "nginx-provisioner-demo" {
  ami = data.aws_ami.latest-linux-ec2.id

  instance_type = var.instance-type
  key_name = aws_key_pair.tf-key-pair.key_name

  security_groups = [aws_security_group.terraform-sg.name]

  tags = {
    "Name" = "Demo-${var.instance-type}"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = tls_private_key.rsa.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl start nginx"
    ]
  }
}
