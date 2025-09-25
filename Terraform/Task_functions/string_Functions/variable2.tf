# variable "key_region" {
#   default = "east"
# }

# locals {
#   region_name = "${var.key_region}-${lower(replace("My-Awesome-Resource", " ", "-"))}"
#   # region_id   = "${var.region}"["id"]
# }
# variable "region" {
#   description = "AWS region for output block"
#   type        = map(string)
#     default     = {
#       east = "us-east-1"
#       west = "us-west-1"
#       id = "001"
# }
# }
# output "region_id" {
#     description = "AWS region id" 
#     value       = local.region_name
# }