terraform {
  backend "s3" {
    bucket         = "kplabs-demo-tfstate-bucket-2023"
    key            = "network/eip.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kplabs-demo-terraform-state-lock-s3"
  }
}