provider "aws" {
  region = var.region-1
  access_key = var.keys["access"]
  secret_key = var.keys["secret"]
}

resource "aws_instance" "local-values-test" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"

  tags = local.common_tags
}
