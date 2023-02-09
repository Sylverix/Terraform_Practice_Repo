provider "aws" {
  region = var.region-1
  access_key = var.keys["access"]
  secret_key = var.keys["secret"]
}

resource "aws_instance" "dev-ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = var.instance-types[0]

  count = var.istest == true ? 3:0

  tags = {
    "Name" = "Dev EC2 - ${count.index}"
  }
}

resource "aws_instance" "prod-ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = var.instance-types[1]

  count = var.istest == false ? 1:0

  tags = {
    "Name" = "Prod EC2"
  }
}