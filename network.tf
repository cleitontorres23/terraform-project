# The VPC Virtual Private Cloud 
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_main"
  }
}

#Create internet gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc_main.id
  

  tags = {
    Name = "gateway"
  }
}

# Creating a subnet and make association with vpc_main and availability zones
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc_main.id
  count      = length(var.subnet_cidr)
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = "true"

  depends_on = [aws_internet_gateway.gateway]

  tags = {
    Name = "subnet-${count.index}"
    
  }
}

#Setting of routes, that are used to determine where network traffic from your subnet or gateway is directed
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "route_table"
  }
}

#Create association among route table, gateway and subnets
resource "aws_route_table_association" "route_table_association_subnet" {
  count = length(var.subnet_cidr)
  subnet_id  = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = aws_route_table.route_table.id
}