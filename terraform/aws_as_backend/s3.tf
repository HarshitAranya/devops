terraform {
  backend "s3" {
    bucket         = "your-backend-bucket-name"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "your-unique-bucket-name"
  acl    = "private"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}