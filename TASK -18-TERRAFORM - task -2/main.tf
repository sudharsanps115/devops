#provider
provider "aws" {
  alias  = "apsouth"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "useast"
  region = "us-east-1"
}
#security group

resource "aws_security_group" "sg_apsouth" {
  provider = aws.apsouth
  name     = "nginx-sg-apsouth"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_useast" {
  provider = aws.useast
  name     = "nginx-sg-useast"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#ec2 instance 

resource "aws_instance" "apsouth_instance" {
  provider                    = aws.apsouth
  ami                         = "ami-02b8269d5e85954ef"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.sg_apsouth.id]
  associate_public_ip_address = true

  user_data = <<-EOF
 #! /bin/bash
 sudo apt update -y
 sudo apt install -y nginx
 sudo systemctl start nginx
 sudo systemctl enable nginx
 EOF

  tags = {
    name = "nginx-server-region1"
  }
}

resource "aws_instance" "useast_instance" {
  provider                    = aws.useast
  ami                         = "ami-0ecb62995f68bb549"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.sg_useast.id]
  associate_public_ip_address = true

  user_data = <<-EOF
 #! /bin/bash
 sudo apt update -y
 sudo apt install -y nginx
 sudo systemctl start nginx
 sudo systemctl enable nginx
 EOF

  tags = {
    name = "nginx-server-region-2"
  }
}
  