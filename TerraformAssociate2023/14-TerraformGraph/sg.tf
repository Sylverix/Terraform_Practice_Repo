resource "aws_security_group" "dynamic-block-sg" {
  name        = "Graph SG"
  description = "Allow HTTPS, HTTP, SSH inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["${aws_eip.lb-eip.private_ip}/32"]
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
    Name = "Graph SG"
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id = aws_security_group.dynamic-block-sg.id
  network_interface_id = aws_instance.ec2-filter-instance[0].primary_network_interface_id

}