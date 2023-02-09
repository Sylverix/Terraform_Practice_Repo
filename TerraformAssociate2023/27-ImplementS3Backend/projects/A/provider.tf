provider "aws" {
  region                  = local.region
  shared_credentials_file = "~/.aws/credentials"
}