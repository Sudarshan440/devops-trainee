output "vpc_id" {
  description = "VPC ID"
  value       = module.my_vpc.vpc_id
}
output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.my_vpc.public_subnet_ids
}
output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.my_vpc.private_subnet_ids
}