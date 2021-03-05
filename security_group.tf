#Creating security group to allow ssh access

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

#Create security group to ping access
resource "aws_security_group" "allow_ping" {
  name        = "allow_ping"
  description = "Allow ping to test purpose"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ping"
  }
}

#Create security group to nginx access
resource "aws_security_group" "allow_nginx" {
  name        = "allow_nginx"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_nginx"
  }
}

#Create security group to allow load balancer access
resource "aws_security_group" "allow_alb" {
  name        = "allow_alb"
  description = "Allow ALB inbound traffic"
  
  #vpc_id      = aws_vpc.vpc_main.id
  #security_groups = 

  ingress {
    description = "Access to ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_alb"
  }
}

# Associate Security Group for ssh to resource webservice
resource "aws_network_interface_sg_attachment" "sg_ssh" {
  security_group_id         = aws_security_group.allow_ssh.id
  network_interface_id      = element(aws_instance.webservice.*.primary_network_interface_id, count.index)
  count = var.aws_count_instante
  }

# Associate security Group for ping command to resource webservice
resource "aws_network_interface_sg_attachment" "sg_ping" {
  security_group_id         = aws_security_group.allow_ping.id
  network_interface_id      = element(aws_instance.webservice.*.primary_network_interface_id, count.index)
  count = var.aws_count_instante
  }

# Associate security Group for nginx to resource webservice
resource "aws_network_interface_sg_attachment" "sg_nginx" {
  security_group_id         = aws_security_group.allow_nginx.id
  network_interface_id      = element(aws_instance.webservice.*.primary_network_interface_id, count.index)
  count = var.aws_count_instante
  }

resource "aws_network_interface_sg_attachment" "sg_alb" {
security_group_id         = aws_security_group.allow_alb.id
network_interface_id      = element(aws_instance.webservice.*.primary_network_interface_id, count.index)
count = var.aws_count_instante
}