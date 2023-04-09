#VPC Creation
resource "aws_vpc" "kiwi-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name    = "${var.project}-vpc"
    Project = "${var.project}"
  }
}
#Internet Gateway 
resource "aws_internet_gateway" "kiwi-igw" {
  vpc_id = aws_vpc.kiwi-vpc.id
  tags = {
    Name = "${var.project}-igw"
  }
}
#Elastic IP 
resource "aws_eip" "kiwi-eip" {
  vpc = true
  tags = {
    Name = "${var.project}-eip"
  }
}
#Subnet 1
resource "aws_subnet" "pri-sn" {
  availability_zone = var.zone
  vpc_id            = aws_vpc.kiwi-vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.project}-pri-sn"
  }
}
#Subnet 2
resource "aws_subnet" "pub-sn" {
  availability_zone       = var.zone
  vpc_id                  = aws_vpc.kiwi-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.project}-pub-sn"
  }
}
#security group for elb
resource "aws_security_group" "elb-sg" {
  name        = "elb-sg"
  description = "Allow elb inbound traffic"
  vpc_id      = aws_vpc.kiwi-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project}-elb-sg"
  }
}
#security group for app
resource "aws_security_group" "app-sg" {
  #name        = "app-sg"
  description = "Allow app traffic from elb"
  vpc_id      = aws_vpc.kiwi-vpc.id

  ingress {
    description     = "TLS from elb"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    #cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description     = "SSH open"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    #cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project}-app-sg"
  }
}
#security group for app
resource "aws_security_group" "backend-sg" {
  name        = "backend-sg"
  description = "Allow backend traffic from app"
  vpc_id      = aws_vpc.kiwi-vpc.id

  ingress {
    description     = "TLS from app"
    from_port       = 5672
    to_port         = 5672
    protocol        = "tcp"
    security_groups = ["${aws_security_group.app-sg.id}"]
    #cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description     = "TLS from app"
    from_port       = 11211
    to_port         = 11211
    protocol        = "tcp"
    security_groups = ["${aws_security_group.app-sg.id}"]
    #cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description     = "TLS from app"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.app-sg.id}"]
    #cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description = "TLS from app"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    self        = true
    #security_groups = ["${aws_security_group.backend-sg.id}"]
    #cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project}-backend-sg"
  }
}
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.kiwi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kiwi-igw.id
  }

  tags = {
    Name = "${var.project}-public_route"
  }
}
#Route table Association
resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.pub-sn.id
  route_table_id = aws_route_table.public_route.id
}
#Route table Association
resource "aws_route_table_association" "pri" {
  subnet_id      = aws_subnet.pri-sn.id
  route_table_id = aws_route_table.public_route.id
}
