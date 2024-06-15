terraform {
  required_version = "1.8.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket9871234"

  tags = {
    Name        = "My bucket2 "
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Noah Tse"
    UpdateAt    = "2024-06-14"
  }
}

resource "aws_s3_bucket_acl" "my-test-bucket-acl" {
  bucket = aws_s3_bucket.my-test-bucket.id
  acl    = "private"
}
