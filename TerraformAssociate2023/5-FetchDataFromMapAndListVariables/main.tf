provider "aws" {
  region = var.region-1
  access_key = var.access-key
  secret_key = var.secret-key
}

resource "aws_instance" "ec2-var-map-demo" {
  ami = "ami-0b5eea76982371e91"
  instance_type = var.types-map["us-east-1"]

  tags = {
    "Name" = "MapEC2"
  }
}

resource "aws_instance" "ec2-var-list-demo" {
  ami = "ami-0b5eea76982371e91"
  instance_type = var.types-list[0]

  tags = {
    "Name" = "ListEC2"
  }
}