variable "environment" {
  description = "The environment for the S3 bucket (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"     
}
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-unique-bucket-name-samosa123" # Change to a globally unique name"
}
variable "versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}
variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {
    Owner       = "Sudarshan"
    Environment = "dev"
  }
}   
# variable "lifecycle_rules" {
#   description = "Lifecycle rules for the S3 bucket"
#   type = list(object({
#     id      = string
#     enabled = bool
#     prefix  = string
#     transitions = list(object({
#       days          = number
#       storage_class = string
#     }))
#     expiration = object({
#       days = number
#     })
#   }))
#   default = [
#     {
#       id      = "log"
#       enabled = true
#       prefix  = "log/"
#       transitions = [
#         {
#           days          = 30
#           storage_class = "STANDARD_IA"
#         },
#         {
#           days          = 60
#           storage_class = "GLACIER"
#         }
#       ]
#       expiration = {
#         days = 365
#       }
#     }
#   ]
# }

