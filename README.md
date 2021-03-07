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


* cloudconfig.tf: 

* network.tf: defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.* network.tf:


* variable.tf: Thinking about a big organization, all the codes is getting bigger and bigger, and it is not necessary to mix the
main code with variables, once, all variables together, is easier to get some informations about it.

* outputs.tf: 

* target_group.tf:

* security_group.tf




## References Links  :books:

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install

https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/

https://cloudinit.readthedocs.io/en/latest/topics/examples.html

https://www.terraform.io/docs/language/functions

https://www.commandlinux.com/man-page/man5/systemd.service.5.html

https://www.nginx.com/resources/wiki/start/topics/examples/systemd/
