# The VPC Virtual Private Cloud 
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_main"
  }
}

resource "aws_subnet" "subnet_main_100" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "10.10.100.0/24"

  tags = {
    Name = "subnet_main_100"
  }
}

resource "aws_internet_gateway" "internet_gatway" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "internet_gatway"
  }
}


resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "10.10.0.0/16"
    gateway_id = aws_internet_gateway.vpc_main.id
  }

  #route {
  #  ipv6_cidr_block        = "::/0"
  #  egress_only_gateway_id = aws_egress_only_internet_gateway.foo.id
  #}

  tags = {
    Name = "main"
  }
}