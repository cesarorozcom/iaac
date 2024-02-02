terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

# Create a bucket
resource "aws_s3_bucket" "policy-storage" {
  bucket_prefix = "orozcoc-"
  force_destroy = true
  tags = {
    "application": "basic"
  }
}

# Create bucket ownership control
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html
resource "aws_s3_bucket_ownership_controls" "public" {
  bucket = aws_s3_bucket.policy-storage.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Enable public access
resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.policy-storage.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "public" {
  depends_on = [
    aws_s3_bucket_ownership_controls.public,
    aws_s3_bucket_public_access_block.public
  ]
  bucket = aws_s3_bucket.policy-storage.id
  acl = "public-read"
}

# JSON to Terraform :Link https://flosell.github.io/iam-policy-json-to-terraform/
# AWS Policy Generator Tool: https://awspolicygen.s3.amazonaws.com/policygen.html
# Allow read objects in a bucket
data "aws_iam_policy_document" "public-read" {
  statement {
    effect    = "Allow"
    resources = ["${aws_s3_bucket.policy-storage.arn}/*"]
    actions   = ["s3:GetObject"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "public-read" {
  bucket = aws_s3_bucket.policy-storage.id
  policy = data.aws_iam_policy_document.public-read.json
}