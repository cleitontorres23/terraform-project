# Terraform - AWS - PROJECT

## INFRA STRUCTURE AS A CODE
This project has as goal to work with terraform and aws environment, in this trip I will let you know some tips and tricks to get the end of the project successfully.

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

* variable.tf: Thinking about a big organization, all the codes is getting bigger and bigger, and it is not necessary to mix the
main code with variables, once, all variables together, is easier to get some informations about it.

* userdata.tf: The place where you need to place your ssh authorized keys, it's better you keep this file in secret







## Links  :books:

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install

https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/

https://cloudinit.readthedocs.io/en/latest/topics/examples.html
