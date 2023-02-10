resource "aws_eip" "eip-lb" {
  vpc = true
  tags = {
    "Name" = "Remote-State-EIP"
  }
}

output "eip_addr" {
  value = aws_eip.eip-lb.public_ip
}