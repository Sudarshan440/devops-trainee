variable "numbers" {
  description = "A list of numbers for numeric functions"
  type        = list(number)
  default     = [-5, 10, 25, -15, 0]
}
variable "num1" {
  type    = number
  default = 20
}
variable "num2" {
  type    = number
  default = 3
}
locals {
    # max_value       = max(var.numbers) # maximum value from the list
    # min_value       = min(var.numbers) # minimum value from the list
    abs_value       = abs(var.numbers[0]) # absolute of first number (-5 → 5)
    abs_values      = [for num in var.numbers : abs(num)] # Absolute values of the list
    ceil_num1       = ceil(var.num1/var.num2)          # Ceiling value of num1/num2
    floor_num1      = floor(var.num1/var.num2)         # Floor value of num1/num2
    max_value       = max([for n in var.numbers : n]...) # Maximum value from the list
    min_value       = min([for n in var.numbers : n]...) # Minimum value from the list
    sum_values      = sum(var.numbers)                   # Sum of all values in the list
    pow_num1_num2   = pow(var.num1,var.num2)            # num1 raised to the power of num2
} 

output "numeric_functions" {
  description = "Numeric function results"
  value = {
    abs_values    = local.abs_values
    abs_value     = local.abs_value
    ceil_num1     = local.ceil_num1
    floor_num1    = local.floor_num1
    max_value     = local.max_value
    min_value     = local.min_value
    sum_values    = local.sum_values
    pow_num1_num2 = local.pow_num1_num2
  } 
}