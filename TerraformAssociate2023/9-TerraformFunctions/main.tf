provider "aws" {
  region = var.default-region
  access_key = var.keys["access"]
  secret_key = var.keys["secret"]
}

resource "aws_instance" "terraform-functions" {
  ami = lookup(var.ami, var.default-region, "No Matches")
  instance_type = "t2.micro"

  count = 2

  tags = {
    Name = element(var.tags,count.index),
    TimeCreated = local.time_created
  }
}