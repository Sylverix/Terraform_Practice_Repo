provider "aws" {
  region = var.region-1
  access_key = var.access-key
  secret_key = var.secret-key
}

resource "aws_eip" "udemy-eip" {
  vpc = true

  tags = {
    "Name" = "UdemyEIP"
  }
}

resource "aws_instance" "terraform-udemy-ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"

  tags = {
    "Name" = "UdemyEC2"
  }
}

resource "aws_eip_association" "eip-assoc-ec2" {
  instance_id = aws_instance.terraform-udemy-ec2.id
  allocation_id = aws_eip.udemy-eip.id
}

resource "aws_security_group" "allow_tls" {
  name        = "Terraform-Udemy-SG"
  description = "Allow HTTPS, HTTP, SSH traffic"

  ingress {
    description      = "HTTPS from VPC"
    from_port        = var.https
    to_port          = var.https
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.udemy-eip.public_ip}/32"]
  }
    ingress {
    description      = "HTTP from VPC"
    from_port        = var.http
    to_port          = var.http
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.udemy-eip.public_ip}/32"]
  }
    ingress {
    description      = "SSH from VPC"
    from_port        = var.ssh
    to_port          = var.ssh
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.udemy-eip.public_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform-Udemy-SG"
  }
}