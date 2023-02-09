data "aws_ami" "latest-linux-ec2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "key-id" {
  type = list
  default = [
    "key1",
    "key2",
    "key3"
  ]
}

variable "instance-type" {
  type = list
  default = [
    "t2.nano",
    "t2.micro",
    "t2.small"
  ]
}

resource "aws_instance" "foreach-demo" {
  ami = data.aws_ami.latest-linux-ec2.id
  for_each = zipmap(var.key-id, var.instance-type)

  instance_type = each.value
  key_name = each.key

  tags = {
    "Name" = "Demo-${each.value}"
  }
}