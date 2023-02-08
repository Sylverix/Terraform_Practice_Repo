data "aws_ami" "latest-linux-ec2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance-registry-demo"

  ami                    = data.aws_ami.latest-linux-ec2.id
  instance_type          = "t2.micro"
  subnet_id              = "subnet-005e4fdca373015b2"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}