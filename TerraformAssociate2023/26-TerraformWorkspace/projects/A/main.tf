data "aws_ami" "latest-linux-ec2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "instance_type" {
  type = map(any)
  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prod    = "t2.large"
  }
}

resource "aws_instance" "ec2_workspace" {
  ami           = data.aws_ami.latest-linux-ec2.id
  instance_type = lookup(var.instance_type, terraform.workspace)

  tags = {
    "Name" = "EC2-${terraform.workspace}"
  }
}