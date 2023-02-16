terraform {
  cloud {
    organization = "MB-Org"

    workspaces {
      name = "terraform-cloud-remote-operation"
    }
  }
}

resource "aws_iam_user" "lb" {
  name = "remote-cloud-user"
}