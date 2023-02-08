data "aws_ami" "latest-linux-ec2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}

resource "aws_instance" "module_ec2_demo" {
  ami = data.aws_ami.latest-linux-ec2.id
  instance_type = var.instance-type
  security_groups = [aws_security_group.ec2_sg.name]
}