# Creating a provider aws as default
provider "aws" {
  region  = var.aws_region
}

# Creating a new instance of the latest Ubuntu 14.04 on an
resource "aws_instance" "webservice" {
  ami           = lookup(var.ami_web, var.aws_region)
  instance_type = "t2.micro"
  count         = var.aws_count_instante
  user_data     =  file("userdata.yaml")

  tags = {

    Name = "webservice-${count.index + 1}"
  }

}

## Create a application load balancer 
resource "aws_elb" "alb_webservice" {
  name                      = "load-balancer-web"
  internal                  = false
  security_groups           = [aws_security_group.allow_alb.id]
  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]
  instances                 = aws_instance.webservice.*.id
  

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

# This output resource get the public ip in the end of terraform command
output "ip-web" {
  value = "${aws_instance.webservice.*.public_ip}"
 }