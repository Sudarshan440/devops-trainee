variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "terraform-functions"
  }
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_count" {
  type    = number
  default = 2
}
variable "region_name" {
  type    = string
  default = "ap-south-1"
}
locals {
    az_count            = length(var.availability_zones) # Count of availability zones
    my_ap_south_1c      = contains(var.availability_zones, "ap-south-1c") # Check if "ap-south-1c" is in the list
    project_tag         = lookup(var.tags, "Project", "default_project") # Lookup the "Project" tag, default if not found
    instance_per_az     = var.instance_count / local.az_count # Instances per availability zone
    instance_type_upper = upper(var.instance_type) # Instance type in uppercase
}
output "collection_functions" {
  description = "Collection function results"
  value = {
    az_count            = local.az_count
    my_ap_south_1c    = local.my_ap_south_1c
    project_tag        = local.project_tag
    instance_per_az    = local.instance_per_az
    instance_type_upper = local.instance_type_upper
  } 
}