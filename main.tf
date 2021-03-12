# Terraform configuration

# versioning control
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0, <= 3.31.0"
    }
  }
}

# Creating a provider aws as default
provider "aws" {
  region  = var.aws_region
}

# Creating a new instance of the latest Ubuntu 14.04 on an
resource "aws_instance" "webservice" {
  ami           = lookup(var.ami_web, var.aws_region)
  instance_type = "t2.micro"
  count         = var.aws_count_instante
  user_data     = data.template_file.init[count.index].rendered
  subnet_id     = aws_subnet.subnet[count.index].id
  
  tags = {

    Name = "webservice-${count.index + 1}"
  }
}

## Create a application load balancer 
resource "aws_elb" "alb_webservice" {
  name                   = "load-balancer-web"
  internal               = false
  security_groups        = [aws_security_group.allow_alb.id]
  instances              = aws_instance.webservice.*.id
  subnets                = aws_subnet.subnet.*.id
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags = {
    Environment = "production"
  }
}

#Creating a template file to deploy different index.html
data "template_file" "init" {
  template = file("${path.module}/cloudconfig.tpl")
  count         = var.aws_count_instante
  vars = {
    index = count.index + 1
  }
}