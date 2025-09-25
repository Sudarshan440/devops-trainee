variable "instance_count" {
  type    = number
  default = 3
}
variable "comma_separated_values" {
  type    = string
  default = "one,two,three"
}
locals {
  count_string = tostring(var.instance_count)   # number → string
  list_values  = tolist(split(",", var.comma_separated_values)) # string → list
}
output "type_conversion_functions" {
  description = "Type conversion function results"
  value = {
    instance_count = local.count_string
    list_values  = local.list_values
  } 
}