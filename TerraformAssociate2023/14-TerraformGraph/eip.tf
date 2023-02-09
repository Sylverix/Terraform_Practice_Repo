resource "aws_eip" "lb-eip" {
  instance = aws_instance.ec2-filter-instance[0].id
  vpc = true
}