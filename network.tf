# The VPC Virtual Private Cloud 
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_main"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gateway.id
  }

  #route {
  #  ipv6_cidr_block        = "::/0"
  #  egress_only_gateway_id = aws_egress_only_internet_gateway.gateway.id
  #}

  tags = {
    Name = "route_table"
  }
}

# Creating a subnet and make association with vpc_main
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc_main.id
  count      = length(var.subnet_cidr)
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  
  tags = {
    Name = "subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet.*.id
  route_table_id = aws_route_table.route_table.*.id
}

resource "aws_route_table_association" "b" {
  gateway_id     = aws_internet_gateway.gateway.*.id
  route_table_id = aws_route_table.route_table.*.id
}