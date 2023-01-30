resource "aws_s3_bucket" "Terraform-state" {
  bucket = "terraform-state-139"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enable-versioning" {
  bucket = aws_s3_bucket.Terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}


terraform {
  backend "s3" {
    bucket = "terraform-state-139"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}



