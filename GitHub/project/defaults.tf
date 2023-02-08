locals {
  token      = "[ACCESS TOKEN HERE]"
  visibility = "public"
}

provider "github" {
  token = local.token
}
