output "vpc_id" {
  description = "VPC ID"
#   value       = aws_vpc.this.id
    value       = var.create_vpc ? aws_vpc.my_vpc[0].id : null
}
output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value = [
    aws_subnet.private_1[0].id,
    aws_subnet.private_2[0].id
  ]
}
output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value = [
    aws_subnet.public_1[0].id,
    aws_subnet.public_2[0].id
  ]
}

output "aws_internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw[0].id
}
output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public_rt[0].id
}