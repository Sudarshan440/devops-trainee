variable "create_vpc" {
  type    = bool
  default = true
}
variable "vpc_name" {
  type    = string
  default = "my-vpc"
} 
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"] 
}
variable "tags" {
  type    = map(string)
  default = {
    Environment = "dev"
    Project     = "vpc-terraform-practice"
  }
}
variable "region" {
  type    = string
  default = "us-east-1"     
}

# locals {
#   public_subnet_cidrs  = var.public_subnet_cidrs
#   private_subnet_cidrs = var.private_subnet_cidrs
#   selected_region    = var.region != "" ? var.region : "us-east-1"
# }
locals {
  public_subnet_names  = [for i, cidr in var.public_subnet_cidrs  : "${var.vpc_name}-public-${i+1}"]
  private_subnet_names = [for i, cidr in var.private_subnet_cidrs : "${var.vpc_name}-private-${i+1}"]
}
