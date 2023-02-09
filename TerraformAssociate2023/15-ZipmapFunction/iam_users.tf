resource "aws_iam_user" "zipmap-users" {
  count = 3
  name = "zipmap_test-${count.index}"
}

output "zipmap-demo" {
  value = zipmap(aws_iam_user.zipmap-users[*].id, aws_iam_user.zipmap-users[*].arn)
}