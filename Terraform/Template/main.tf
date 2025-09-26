provider "aws" {
  region = var.region
}
module "my_vpc" {
  source = "../modules/vpc"
  
  tags   = var.tags
}
