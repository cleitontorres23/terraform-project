# Terraform - AWS - PROJECT
![TERRAFORM](https://user-images.githubusercontent.com/23055661/110207384-f73f9980-7e61-11eb-8f33-94324bcc1822.png)

## PROVISIONING AWS RESOURCES USING TERRAFORM
This project has as goal to deploy 2 or more ec2 using terraform in the aws environment, in this trip I will let you know some tips to get the end of the project successfully.

## Technology 
 
Here are the technologies used in this project:
  
* terraform_0.14.7
* awscli 1.18.69
* Python PIP 
* Python 2.x and 3.x

## Services Used
 
* Github
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

You are going to create this files below :

Your directory structure will look similar to the one below.

``` ruby
├── main.tf
├── cloudconfig.tf
├── network.tf
├── variables.tf
├── outputs.tf
├── target_group.tf
├── security_group.tf
├── terraform_deploy.sh (* not mandatory, just if you want to make you life easier)
```


# Understanding these files 

* main.tf: It is a best practice use this file to tell to terraform what do you need it does for you, each resource block describes one or more infrastructure objects, such as virtual networks, compute instances, or higher-level components such as DNS records.

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
  value = aws_instance.webservice.*.public_ip
 }
```

* cloudconfig.tf: 

``` ruby
#cloud-config
ssh_authorized_keys:
  - "ssh-rsa id_rsa.pub key"

runcmd:
  - sudo -i
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  - sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - sudo apt update -y
  - sudo apt install docker-ce docker-ce-cli containerd.io -y
  - sudo systemctl start docker
  - sudo systemctl enable docker
  - sudo docker run --name docker-nginx -d --net host nginx 

write_files:
  - path: /lib/systemd/system/nginx.service
    permission: '0644'
    content:  |
        [Unit]
        Description=The Nginx Service
        After=docker.service syslog.target network-online.target remote-fs.target nss-lookup.target 
        Wants=network-online.target
        Requires=docker.service
        
        [Service]
        Type=forking
        PIDFile=/run/nginx.pid   
        ExecStart=/usr/bin/docker run --name docker-nginx -d --net host -v /etc/nginx/nginx.conf:/etc/nginx/nginx.conf  nginx
        
        [Install]
        WantedBy=multi-user.target
    
```






* variable.tf: Thinking about a big organization, all the codes is getting bigger and bigger, and it is not necessary to mix the
main code with variables, once, all variables together, is easier to get some informations about it.

* network.tf: defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.




## References Links  :books:

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install

https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/

https://cloudinit.readthedocs.io/en/latest/topics/examples.html

https://www.terraform.io/docs/language/functions

https://www.commandlinux.com/man-page/man5/systemd.service.5.html
