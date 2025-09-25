variable "key_region" {
  default = "east1"
}

locals {
  region_name = lookup(var.region, var.key_region, "west")
  # region_id   = "${var.region}"["id"]
}

variable "region" {
  description = "AWS region for output block"
  type        = map(string)
    default     = {
      east = "us-east-1"
      west = "us-west-1"
      south = "us-south-1"
      north = "us-north-1"
      central = "us-central-1"
      id = "001"
}
}
output "region_id" {
    description = "AWS region id" 
    value       = local.region_name
}