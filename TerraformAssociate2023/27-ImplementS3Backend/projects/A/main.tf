resource "aws_eip" "eip-lb-s3" {
  vpc = true
  tags = {
    "Name" = "Backend-EIP-Test"
  }
}