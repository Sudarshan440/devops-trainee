variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

locals {
  env_regions = {
    dev     = ""
    prod    = "us-west-2"
    staging = "us-central-1"
  }

  # Use lookup to get region for env, fallback to default if env not found or empty
  selected_region = coalesce(
    lookup(local.env_regions, var.env, null),"us-east-1")
}

output "aws_region" {
  value = local.selected_region
}
output "environment" {
  value = var.env != "" ? var.env : "default" # Show "default" if env is empty
}
