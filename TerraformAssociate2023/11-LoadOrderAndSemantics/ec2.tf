resource "aws_instance" "ec2-filter-instance" {
  ami           = data.aws_ami.amzn-linux2.id
  instance_type = "t2.micro"

  count = 3

  tags = merge(
    local.common_tags,
    {
      Name = "SemanticsEC2Demo-${count.index}"
    }
    )
}