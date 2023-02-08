provider "aws" {
  region     = var.default-region
  access_key = var.keys["access"]
  secret_key = var.keys["secret"]
}

resource "aws_instance" "terraform-functions" {
  ami           = data.aws_ami.amzn-linux2.id
  instance_type = "t2.micro"

  tags = local.common_tags
}