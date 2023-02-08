provider "aws" {
  region = var.region-1
  access_key = var.access-key
  secret_key = var.secret-key
}

resource "aws_instance" "count-demo" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"

  count = 5

  tags = {
    "Name" = "CountDemo-${count.index}"
  }
}

resource "aws_iam_user" "elb-user-names" {
  name = var.elb-names[count.index]
  count = 3
}