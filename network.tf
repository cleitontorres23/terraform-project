# The VPC Virtual Private Cloud 
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_main"
  }
}

# Creating a subnet A and make association with vpc_main
resource "aws_subnet" "subnet_A" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "10.10.100.0/24"

  tags = {
    Name = "subnet_A"
  }
}

# Creating a subnet B and make association with vpc_main
resource "aws_subnet" "subnet_B" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "10.10.200.0/24"

  tags = {
    Name = "subnet_B"
  }
}