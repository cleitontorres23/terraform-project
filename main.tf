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

# This output resource get the public ip in the end of terraform command
output "ip-web" {
  value = "${aws_instance.webservice.*.public_ip}"
 }