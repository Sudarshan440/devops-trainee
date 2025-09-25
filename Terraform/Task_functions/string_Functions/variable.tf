variable "region_name" {
  type    = string
  default = "ap-south-1"
}

variable "environment" {
  type    = string
  default = "Production-Env"
}
variable "app_name" {
  type    = string
  default = "My Awesome App"
}
variable "resource_type" {
  type    = string
  default = "Instance"
}

#########################################################

locals {
  resource_name = "${var.region_name}-${lower(replace(var.app_name, " ", "-"))}-${lower(var.environment)}-${upper(var.resource_type)}"
}
locals {
  lower_env   = lower(var.environment)
  upper_env   = upper(var.environment)
  short_env   = substr(var.environment, 0, 4) # First 4 letters
  replaced    = replace(var.environment, "-", "_")  # while calling replace(str, substr, replace)
  joined_name = join("-", [var.region_name, local.lower_env])
}

########################################################################


output "resource_name" {
  description = "Custom resource name"
  value       = local.resource_name
}   
output "lower_env" {
  description = "Environment name in lowercase"
  value       = local.lower_env
}
output "upper_env" {
    description = "Environment name in uppercase"
    value       = local.upper_env
}   
output "short_env" {
    description = "Shortened environment name"
    value       = local.short_env
}
output "replaced" {
    description = "Environment name with replaced characters"
    value       = local.replaced
}
output "joined_name" {
    description = "Joined resource name"
    value       = local.joined_name
}