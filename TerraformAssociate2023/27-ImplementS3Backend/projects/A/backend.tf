terraform {
  backend "s3" {
    bucket = "kplabs-demo-tfstate-bucket-2023"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}