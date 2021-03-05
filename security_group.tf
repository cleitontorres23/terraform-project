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

# Security Group for ssh
resource "aws_network_interface_sg_attachment" "sg_ssh" {
  security_group_id         = aws_security_group.allow_ssh.id
  network_interface_id      = element(aws_instance.web.*.primary_network_interface_id, count.index)
  count = var.aws_count_instante
  }

# Security Group for ping command
resource "aws_network_interface_sg_attachment" "sg_ping" {
  security_group_id         = aws_security_group.allow_ping.id
  network_interface_id      = element(aws_instance.web.*.primary_network_interface_id, count.index)
  count = var.aws_count_instante
  }