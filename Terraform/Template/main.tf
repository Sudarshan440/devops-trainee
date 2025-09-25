provider "aws" {
    region = "us-east-1"
}
module "my_vpc" {
  source = "../modules/vpc"
}