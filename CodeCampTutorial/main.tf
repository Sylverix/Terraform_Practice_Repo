# Configure a Provider
provider "aws" {
  region = "us-east-1"
  access = "[ACCESS KEY HERE]"
  secret = "[SECRET KEY HERE]"
}

# Create VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform VPC"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "terraform-gateway" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "Terraform Gateway"
  }
}

# Create Custom Route Table
resource "aws_route_table" "terraform-route_table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-gateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.terraform-gateway.id
  }

  tags = {
    Name = "Terraform Route Table"
  }
}

# Create Subnet
resource "aws_subnet" "terraform-subnet" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform Subnet"
  }
}

# Associate subnet with Route Table
resource "aws_route_table_association" "terraform-rt_association" {
  subnet_id      = aws_subnet.terraform-subnet.id
  route_table_id = aws_route_table.terraform-route_table.id
}

# Create Security Group / Allow ports 22, 80, 443
resource "aws_security_group" "terraform-security_group" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    description      = "HTTPS to/from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress {
    description      = "HTTP to/from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress {
    description      = "SSH to/from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform Security Group - Allow Web"
  }
}

# Create a Network Interface with an IP in the Subnet that was created above
resource "aws_network_interface" "terraform-network_interface" {
  subnet_id       = aws_subnet.terraform-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.terraform-security_group.id]
}

# Assign an Elastic IP to the Network Interface
resource "aws_eip" "terraform-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.terraform-network_interface.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    aws_internet_gateway.terraform-gateway
  ]
}

# Create an Ubuntu Server and install/update apache2
resource "aws_instance" "terraform-ubuntu-web-server" {
  ami           = "ami-06878d265978313ca"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "Terraform Key Pair"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.terraform-network_interface.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c "echo Hello World! My first Terraform Web Server! > /var/www/html/index.html"
              EOF

  tags = {
    Name = "Terraform Ubuntu Web Server"
  }
}