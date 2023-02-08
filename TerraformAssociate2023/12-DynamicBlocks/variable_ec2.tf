data "aws_ami" "amzn-linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "no_of_instances" {
  type    = number
  default = 10
}