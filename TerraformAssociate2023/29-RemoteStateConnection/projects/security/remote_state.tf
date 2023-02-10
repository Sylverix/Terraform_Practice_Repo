data "terraform_remote_state" "eip" {
  backend = "s3"

  config = {
    bucket = "kplabs-demo-tfstate-bucket-2023"
    key = "network/eip.tfstate"
    region = "us-east-1"
    }
}