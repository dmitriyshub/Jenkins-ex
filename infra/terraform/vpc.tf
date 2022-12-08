resource "aws_vpc" "main_vpc" {
 cidr_block = var.vpc_cidr
 enable_dns_support = true
 enable_dns_hostnames = true
 instance_tenancy = var.vpc_tenancy
 tags = {
   Name = "bot-vpc"
 }
}
resource "aws_subnet" "public_subnet" {
 cidr_block = var.public_subnet_cidr
 vpc_id     = aws_vpc.main_vpc.id
 availability_zone = var.availability_zone
 map_public_ip_on_launch = true
 tags = {
   Name = "bot-public-subnet"
 }
}

# Internet Gateway for VPC
resource "aws_internet_gateway" "vpc_internet_gateway" { # terraform id&name
  vpc_id = aws_vpc.main_vpc.id # attach to vpc
  tags = {
      Name = "bot-internet-gateway"

  }
}

# Route Table for VPC PUBLIC
resource "aws_route_table" "vpc_route_table_public" {
  vpc_id = aws_vpc.main_vpc.id # attach to vpc

  route {
    cidr_block = var.egress_cidr # ip range for this route
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id # attach to internet gateway
  }

  tags = {
      Name = "bot-public-route-table"

  }
}

# Route Table Association PUBLIC
resource "aws_route_table_association" "subnet_public_assosiacion1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.vpc_route_table_public.id
}

resource "aws_eip" "lb" {
  instance = aws_instance.jenkinsInstance.id
  vpc      = true
}