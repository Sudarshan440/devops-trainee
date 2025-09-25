terraform {
 required_version = ">=1.5.0"

required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.20" # "~> is called the “pessimistic constraint operator”
    #Everything after the last number in the constraint is flexible.
  }
}
} 