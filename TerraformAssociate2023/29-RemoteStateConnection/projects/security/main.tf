resource "aws_security_group" "allow_https" {
  name = "Security SG"
  description = "Whitelist IP Addresses"

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.eip.outputs.eip_addr}/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "Remote State SG"
  }
}