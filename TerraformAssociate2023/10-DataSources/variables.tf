variable "default-region" {
  type    = string
  default = "us-east-1"
}

variable "keys" {
  type = map(any)
  default = {
    access = "[ACCESS KEY HERE]",
    secret = "[SECRET KEY HERE]"
  }
}

data "aws_ami" "amzn-linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

locals {
  common_tags = {
    Name    = "Data Source Demo"
    Owner   = "Amazon"
    Service = "Backend"
  }
}