provider "aws" {
  region = var.region 
}
variable "vpc_name" {
  description = " vpc name"
  default = "my-vpc-007"
}
variable "region" {
  default = "us-east-1"
}
variable "tags" {
  type = map(string)
  default = {
    Environment = "prod"
    Project     = "vpc-project-007"
  }
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws" 
  version = "6.2.0"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]

#   tags = var.tags

#    tags = {
#     Environment = "production-env"
#     Project     = "hardcoded-project"
#     Owner       = "Sudarshan"
#   }

  tags = merge(
  {
    Owner = "Sudarshan"   # hardcoded (always applied)
  },
  var.tags                 # overridable values
)
}
