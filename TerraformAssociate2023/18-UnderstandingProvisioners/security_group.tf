variable "ingress_ports" {
  type = list
  default = [
    "443",
    "80",
    "22"
  ]
}

resource "aws_security_group" "terraform-sg" {
  name        = "Terraform SG"
  description = "Allow HTTPS, HTTP, SSH inbound traffic"

  dynamic ingress {
    for_each = var.ingress_ports
    iterator = port
    content {
        description = "Allow port ${port.value} inbound traffic"
        from_port        = port.value
        to_port          = port.value
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
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

/*
Found a better workaround to resolve the provisioner issue
I had with this section of the course. In the next course section,
I discovered that you can attach the security group directly
to the EC2 Instance by declaring "security_groups = [aws_sg.sg_example.name]"
inside the "aws_instance" resource, which will apply the security group
to allow port 22, and then the provisioner can connect to the instance.

Avoid using the below code and follow the above comment if you want the
provisioner to connect successfully to the instance and apply everything.
*/

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.terraform-sg.id
  network_interface_id = aws_instance.provisioner-demo.primary_network_interface_id
}