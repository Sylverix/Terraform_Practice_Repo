locals {
  token      = "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"
  visibility = "public"
}

provider "github" {
  token = local.token
}