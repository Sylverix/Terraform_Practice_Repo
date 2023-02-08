resource "aws_instance" "ec2-filter-instance" {
  ami           = data.aws_ami.amzn-linux2.id
  instance_type = "t2.micro"

  count = var.no_of_instances

  tags = merge(
    {
      Name ="TaintDemo-${count.index}"
    },
    local.ec2_tags
  )
}