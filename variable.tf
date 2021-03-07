# Variable to create a ec2 in N.Virginia
variable "aws_region"{
  default = "us-east-1" 
}

# Variable to get Ubuntu Image free tier
variable "ami_web" {
  type = map
  default = {
    "us-east-1" = "ami-0ac80df6eff0e70b5"
  }
}

# How many instances is going up
variable "aws_count_instante"{
  default = 2
}

variable "subnet_cidr"{
  default = ["10.10.200.0/24", "10.10.100.0/24"]
}

variable "azs"{
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}