provider "aws" {
  region = var.region
}
module "my_vpc" {
  source = "../modules/vpc"
  region = var.region
}
