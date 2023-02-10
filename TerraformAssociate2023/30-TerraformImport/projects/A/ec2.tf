resource "aws_instance" "import-ec2" {
  ami                    = "ami-0aa7d40eeae50c9a9"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-08984dd448fd25f09"]
  key_name               = "import-test"

  tags = {
    "Name" = "Import-Test-EC2-Success"
  }
}