provider "aws" {
    region = var.region-1
    access_key = var.access-key
    secret_key = var.secret-key
}

# Create a VPC

# Create a Subnet

# Create a EC2 Instance
resource "aws_instance" "UdemyEC2" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"

  tags = {
    Name = "UdemyEC2"
  }
}