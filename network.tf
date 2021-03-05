# The VPC Virtual Private Cloud 
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_main"
  }
}