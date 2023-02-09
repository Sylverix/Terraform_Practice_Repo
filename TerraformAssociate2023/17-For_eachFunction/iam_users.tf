/*
variable "iam_names" {
  type = list
  default = [
    "user-00",
    "user-01",
    "user-02",
    "user-03",
    "user-04"
  ]
}

resource "aws_iam_user" "iam" {
  for_each = toset(var.iam_names)
  name = each.key
}
*/