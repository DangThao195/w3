provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "docs_bucket" {
  bucket = "bedrock-docs-thao-001"
}

resource "aws_dynamodb_table" "summary_table" {
  name         = "pdf-summary"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "file_name"

  attribute {
    name = "file_name"
    type = "S"
  }
}