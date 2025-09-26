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

  # Internet Gateway
resource "aws_internet_gateway" "igw" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id
  tags   = merge(var.tags, { Name = "${var.vpc_name}-igw" })
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id

  tags = merge(var.tags, { Name = "${var.vpc_name}-public_rt" })
}

# Route for Internet access in Public Route Table
resource "aws_route" "public_internet_access" {
  count                  = var.create_vpc ? 1 : 0
  route_table_id         = aws_route_table.public_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}

# Associate Public Subnet 1 with Public Route Table
resource "aws_route_table_association" "public_1_assoc" {
  count          = var.create_vpc ? 1 : 0
  subnet_id      = aws_subnet.public_1[0].id
  route_table_id = aws_route_table.public_rt[0].id
}

# Associate Public Subnet 2 with Public Route Table
resource "aws_route_table_association" "public_2_assoc" {
  count          = var.create_vpc ? 1 : 0
  subnet_id      = aws_subnet.public_2[0].id
  route_table_id = aws_route_table.public_rt[0].id
}

# Null Resource Trigger
resource "null_resource" "vpc_changes_trigger" {
  triggers = {
    vpc_id           = aws_vpc.my_vpc[0].id
    public_subnet_1  = aws_subnet.public_1[0].id
    public_subnet_2  = aws_subnet.public_2[0].id
  }

  provisioner "local-exec" {
    command = "${path.module}/../../trigger.sh ${self.triggers.vpc_id} ${self.triggers.public_subnet_id}"
  }
}

# In Terraform, the keyword `self` is used within resource blocks,
# particularly in dynamic blocks or provisioners, 
# to refer to the current resource instance. 
# It acts as a reference to the resource being defined,
# allowing you to access its attributes and properties directly.

# The use of `self` helps keep your Terraform code modular and 
# avoids hardcoding resource attributes.

# Example Usage: 
# If you have a resource like `aws_instance`, 
# you could use `self.private_ip` inside a provisioner to get 
# the instance's private IP address.
# This makes your code more flexible and maintainable.