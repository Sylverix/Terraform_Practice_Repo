resource "aws_dynamodb_table" "import-table" {
  name = "kplabs-demo-terraform-state-lock-s3"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}