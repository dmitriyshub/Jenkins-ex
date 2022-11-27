resource "aws_vpc" "main_vpc" {
 cidr_block = "10.1.0.0/16"
 enable_dns_support = true
 enable_dns_hostnames = true
 instance_tenancy = "default"
 tags = {
   Name = "myVpc"
 }
}
resource "aws_subnet" "public_subnet" {
 cidr_block = "10.1.1.0/24"
 vpc_id     = aws_vpc.main_vpc.id
 availability_zone = "us-west-2a"
 map_public_ip_on_launch = true
 tags = {
   Name = "myPublicSubnet"
 }
}

# Internet Gateway for VPC
resource "aws_internet_gateway" "vpc_internet_gateway" { # terraform id&name
  vpc_id = aws_vpc.main_vpc.id # attach to vpc
  tags = {
      Name = "internetGateway"

  }
}

# Route Table for VPC PUBLIC
resource "aws_route_table" "vpc_route_table_public" {
  vpc_id = aws_vpc.main_vpc.id # attach to vpc

  route {
    cidr_block = "0.0.0.0/0" # ip range for this route
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id # attach to internet gateway
  }

  tags = {
      Name = "publicRouteTable"

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