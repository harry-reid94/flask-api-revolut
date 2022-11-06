provider "aws" {
  version = "~> 3.7.0"
  region = "eu-west-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-revolut"
     
  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock-revolut"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}