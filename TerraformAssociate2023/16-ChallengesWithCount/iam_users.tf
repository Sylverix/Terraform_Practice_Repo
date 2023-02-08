/* 
There are challenges that come with using the Count Meta-Argument:
  1. Should be used with identical resources values.
  2. Shouldn't be used with things that require distinctive/unique values.
  3. For unique values, use for_each function.
*/

variable "iam_names" {
  type = list
  default = [
    "user-00",
    "user-01",
    "user-02",
    "user-03"
  ]
}

resource "aws_iam_user" "iam" {
  name = var.iam_names[count.index]
  count = 4
}