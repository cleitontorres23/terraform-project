# Terraform - AWS - PROJECT
![TERRAFORM](https://user-images.githubusercontent.com/23055661/110207384-f73f9980-7e61-11eb-8f33-94324bcc1822.png)

## PROVISIONING AWS RESOURCES USING TERRAFORM
This project has as goal to deploy 2 or more ec2 using terraform in the aws environment, in this trip I will let you know some tips and tricks to get the end of the project successfully.

## Technology 
 
Here are the technologies used in this project:
  
* terraform_0.14.7
* awscli 1.18.69
* Python PIP 
* Python 2.x and 3.x

## Services Used
 
* Github
* Travis.ci
* Aws Console

## Getting started
 
At first, we need to configure the aws access and download terraform file.

* To install awscli:
``` ruby
>    $ sudo apt install awscli
```

Amazon Web Service Command Line Interface (awscli) is a command line tool (in Python module ;-)for managing and administering your Amazon Web Services.

If you do not have python, and it command before have showed to you some error about it.

* To install python:
``` ruby
>    $ sudo apt-get install python3-pip
```

## How to use

Let'go to put apart some components just to help us to understand how the drew is and make the code clear. I hope so!

You are goingo to create this files below:

* main.tf
* variable.tf
* userdata.tf
* target_group.tf
* security_group.tf
* network.tf
* terraform_deploy.sh (* not mandatory, just if you want to make you life easier)


# Make these files christal clear

* main.tf: Normally, you use this file to tell to terraform what do you need it does for you, (i.e: provider, resource)

``` ruby
>    # Creating a provider aws as default
provider "aws" {
  region  = var.aws_region
}

# Creating a new instance of the latest Ubuntu 14.04 on an
resource "aws_instance" "webservice" {
  ami           = lookup(var.ami_web, var.aws_region)
  instance_type = "t2.micro"
  count         = var.aws_count_instante
  user_data     =  file("cloudconfig.yaml")

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
```


* variable.tf: Thinking about a big organization, all the codes is getting bigger and bigger, and it is not necessary to mix the
main code with variables, once, all variables together, is easier to get some informations about it.

* userdata.tf: The place where you need to place your ssh authorized keys, it's better you keep this file in secret


* network.tf: All the inbound and outbound traffic comes throght the VPC, stands for Amazon (Virtual Private Cloud), so is good for your health be keep in control all the traffic.




## Links  :books:

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install

https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/

https://cloudinit.readthedocs.io/en/latest/topics/examples.html

https://www.terraform.io/docs/language/functions
