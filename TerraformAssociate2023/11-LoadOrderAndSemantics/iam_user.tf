resource "aws_iam_user" "semantics-demo" {
  count = 3

  name = "${var.iam-user-demo}-${count.index}"
}