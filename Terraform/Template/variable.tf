variable "region" {
  type    = string
  default = "us-west-2"     
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "default-vpc"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "prod"
    Project     = "vpc-project-007"
  }
}