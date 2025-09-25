provider "aws" {
  region = var.region
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.bucket_name}-${var.environment}" #bucket names must be globally unique
  acl    = "private"        # ------> Depricated
#   versioning {               ------> Depricated    
#     enabled = var.versioning   
#   } 
  tags = var.tags
} 
resource "aws_s3_bucket_versioning" "my-bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
}
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = var.environment == "prod" ? true : false
  block_public_policy     = var.environment == "prod" ? true : false
  ignore_public_acls      = var.environment == "prod" ? true : false
  restrict_public_buckets = var.environment == "prod" ? true : false
}