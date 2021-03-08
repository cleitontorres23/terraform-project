# Terraform - AWS
![TERRAFORM](https://user-images.githubusercontent.com/23055661/110207384-f73f9980-7e61-11eb-8f33-94324bcc1822.png)

## PROVISIONING AWS RESOURCES USING TERRAFORM
This project has as goal to deploy 2 or more ec2 using terraform in the aws environment, in this trip I will let you know some tips to get the end of the project successfully.

## Technology 
 
Here are the technologies used in this project:
  
* terraform_0.14.7
* awscli 1.18.69 --> **another way to authenticate? keep going and have fun**
* Python PIP 
* Python 2.x and 3.x
* hashicorp/aws v3.31.0

## Services Used
 
* Github
* Aws Console

## Getting started with what we plan to do

![DAP-aws](https://user-images.githubusercontent.com/23055661/110247623-e3706200-7f4b-11eb-8f46-e0b2f858c63e.jpg)
 
I have used awscli to authenticate on aws site, if you desire to use another way, feel free :-), I am happy to hear you trying other one. 

If you want to keep in this article, let's get the ball rolling and configure the aws access.

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

Let'go to put apart some components to help us to understand how the drew is and make the code clear. I hope so!

You are going to create this files below :

Your directory structure will look like similar to the one below.

``` ruby
├── main.tf
├── cloudconfig.tpl
├── network.tf
├── variables.tf
├── outputs.tf
├── target_group.tf
├── security_group.tf
├── terraform_deploy.sh (* not mandatory, just if you want to make you life easier)
```


# Understanding these files 

* main.tf: It is a best practice use this file to tell to terraform what you need it does for you, each resource block describes one or more infrastructure objects, such as virtual networks, compute instances, or higher-level components such as DNS records.


* cloudconfig.tf: I have separated some important things for our webserver works in this file, the first one is image nginx Docker(in my opnion is the more lightweight way to give live to web application *with no headaches*, another one is systemd customization environment 

* network.tf: defines a Virtual Private Cloud (VPC), which will provide networking services (i.e.: subnets, route tables) for the rest of your infrastructure.

* variable.tf: Thinking about a big corporation, all the codes is getting bigger and bigger, so, do not mess it up and get the control, once all variables together, is easier to get some informations about it and avoid mistakes.

* outputs.tf:  All the times you get to know some values you may use it to return in Terraform, ok, formal way : - is used to extract the value of an output variable from the state file

* target_group.tf: A target group tells a load balancer where to direct traffic, when you are creating a load balancer, you make one or more listeners and configure listener rules to direct the traffic to one target group

* security_group.tf: A security group acts as a virtual firewall for your instance controlling inbound and outbound traffic.




## References Links  :books:

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install

https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/

https://cloudinit.readthedocs.io/en/latest/topics/examples.html

https://www.terraform.io/docs/language/functions

https://www.commandlinux.com/man-page/man5/systemd.service.5.html

https://www.nginx.com/resources/wiki/start/topics/examples/systemd/
