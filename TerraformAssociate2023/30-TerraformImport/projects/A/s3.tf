variable "folders" {
  type = list
  default = [
    "network",
    "security"
  ]
}

resource "aws_s3_bucket" "import-s3" {
  bucket = "kplabs-demo-tfstate-bucket-2023"
}

resource "aws_s3_bucket_acl" "bucket-acl"{
    bucket = aws_s3_bucket.import-s3.id
    acl = "private"
}

resource "aws_s3_object" "network-folder" {
  bucket = aws_s3_bucket.import-s3.id
  key = "${var.folders[0]}/"
}

resource "aws_s3_object" "security-folder" {
  bucket = aws_s3_bucket.import-s3.id
  key = "${var.folders[1]}/"
}