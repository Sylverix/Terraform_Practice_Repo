variable "ingress_ports" {
  type = map
  default = {
    HTTPS = "443",
    HTTP = "80",
    SSH = "22"
  }
}

resource "aws_security_group" "terraform-sg" {
  name        = "Terraform SG"
  description = "Terraform-made. Allow HTTPS, HTTP, SSH inbound traffic."

  dynamic ingress {
    for_each = var.ingress_ports
    iterator = port
    content {
        description      = "Allow ${port.key} Protocol"
        from_port        = port.value
        to_port          = port.value
        protocol         = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform SG"
  }
}