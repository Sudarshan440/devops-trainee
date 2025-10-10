provider "aws" {
  region = var.region
}

# IAM Role
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_image_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = { Service = "lambda.amazonaws.com" },
      Effect = "Allow"
    }]
  })
}

# IAM Policy
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_image_policy"
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:*",
          "dynamodb:PutItem",
          "sns:Publish"
        ],
        Resource = "*"
      }
    ]
  })
}

# DynamoDB Table
resource "aws_dynamodb_table" "image_table" {
  name           = "ImageMetadata"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "filename"
  attribute {
    name = "filename"
    type = "S"
  }
}

# SNS Topic
resource "aws_sns_topic" "image_topic" {
  name = "image-upload-topic"
}

# S3 Bucket
resource "aws_s3_bucket" "image_bucket" {
  bucket = "lambda-image-upload-bucket-007"
}

# Lambda Function
resource "aws_lambda_function" "image_lambda" {
  function_name = "imageUploadHandler"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  filename      = "lambda.zip"

  environment {
    variables = {
      TABLE_NAME     = aws_dynamodb_table.image_table.name
      SNS_TOPIC_ARN  = aws_sns_topic.image_topic.arn
    }
  }
}

# S3 Event Notification → Lambda
resource "aws_s3_bucket_notification" "s3_to_lambda" {
  bucket = aws_s3_bucket.image_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.image_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_function.image_lambda]
}

# Allow S3 to invoke Lambda
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.image_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.image_bucket.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.image_bucket.bucket
}
