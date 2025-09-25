#VPC Creation
# resource "aws_vpc" "my_vpc" {
#   count             = var.create_vpc ? 1 : 0
#   cidr_block       = var.vpc_cidr
#   enable_dns_hostnames = true
#   tags             = merge(var.tags, { Name = "my_vpc" })
# }
# resource "aws_subnet" "my_subnet" {
#   count             = var.create_vpc ? length(var.availability_zones) * 2 : 0
#   vpc_id            = aws_vpc.my_vpc[0].id
#   cidr_block        = element(concat(local.public_subnet_cidrs, local.private_subnet_cidrs), count.index)
#   availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
#   map_public_ip_on_launch = count.index < length(var.availability_zones) ? true : false
#   tags                    = merge(var.tags, { Name = "my_subnet_${count.index + 1}" })
# }

# VPC
resource "aws_vpc" "my_vpc" {
  count              = var.create_vpc ? 1 : 0
  cidr_block         = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "my-terraform-vpc"}) #var.tags["Project"] != null ? "${var.tags["Project"]}-vpc" : "my-vpc"
}

# Public Subnet 1
resource "aws_subnet" "public_1" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.my_vpc[0].id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags              = merge(var.tags, { Name = local.public_subnet_names[0] })
}

# Public Subnet 2
resource "aws_subnet" "public_2" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.my_vpc[0].id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags              = merge(var.tags, { Name = local.public_subnet_names[1] })
}

# Private Subnet 1
resource "aws_subnet" "private_1" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.my_vpc[0].id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags              = merge(var.tags, { Name = local.private_subnet_names[0] })
}

# Private Subnet 2
resource "aws_subnet" "private_2" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.my_vpc[0].id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags              = merge(var.tags, { Name = local.private_subnet_names[1] })
}


