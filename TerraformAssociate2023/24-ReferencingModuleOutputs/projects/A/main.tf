module "sg_module" {
  source = "../../modules/sg"
}

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

resource "aws_instance" "output_sg_ec2" {
  ami = data.aws_ami.latest-linux-ec2.id
  instance_type = var.instance-type
  vpc_security_group_ids = [module.sg_module.sg_id]
}