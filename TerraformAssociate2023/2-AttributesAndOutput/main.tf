provider "aws" {
  region = var.region-1
  access_key = var.access-key
  secret_key = var.secret-key
}

resource "aws_eip" "elastic-ip" {
  vpc = true

  tags = {
    "Name" = "Terraform-EIP"
  }
}

resource "aws_s3_bucket" "terraform-s3" {
  bucket = "terraform-s3-demo-2023-certdemo-udemy"
}

output "eip" {
  value = aws_eip.elastic-ip.public_ip
}

output "s3-bucket" {
  value = aws_s3_bucket.terraform-s3.bucket_domain_name
}