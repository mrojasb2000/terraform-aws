provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "CREDENTIALS FILE PATH"
}

resource "aws_s3_butcket" "org-example-state" {
  bucket = "org-example-state"
  versioning {
      enabled = true
  }
  lifecycle {
      prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "org-example-state-lock" {
  name = "org-example-state-lock"
  read_capacity = 5
  write_capacity = 5
  hash_key = "LockID"

  attribute {
      name = "LockID"
      type = "S"
  }
  lifecycle {
      prevent_destroy = false
  }
  tags {
      name = "org-example-state-lock"
  }

}

