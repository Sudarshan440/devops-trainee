bucket         = "my-terraform-xyz123-pumpkin007"
key            = "dev/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-locks"
encrypt        = false # true recommended for production
