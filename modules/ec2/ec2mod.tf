resource "aws_instance" "kiwi-app" {
  ami                    = "${var.app-server}"
  instance_type          = "t2.micro"
  subnet_id              = var.pri-sn
  key_name               = "${var.key-pair}"
  vpc_security_group_ids = [var.app-sg]
  #user_data              = "web.sh"
  tags = {
    Name = "${var.project}-app"
  }
  /*
  user_data = <<EOF
		#!/bin/bash
		yum update -y
		yum install -y httpd.x86_64
		systemctl start httpd.service
		systemctl enable httpd.service
		echo ?Hello World from $(hostname -f)? > /var/www/html/index.html
	EOF
  */
}
/*
resource "aws_instance" "kiwi-sql" {
  ami                    = "${var.centos}"
  instance_type          = "t2.micro"
  subnet_id              = var.pri-sn
  key_name               = "${var.key-pair}"
  vpc_security_group_ids = [var.backend-sg]
  tags = {
    Name = "${var.project}-sql"
  }
}
resource "aws_instance" "kiwi-cache" {
  ami                    = "${var.centos}"
  instance_type          = "t2.micro"
  subnet_id              = var.pri-sn
  key_name               = "${var.key-pair}"
  vpc_security_group_ids = [var.backend-sg]
  tags = {
    Name = "${var.project}-cache"
  }
}
resource "aws_instance" "kiwi-mq" {
  ami                    = "${var.centos}"
  instance_type          = "t2.micro"
  subnet_id              = var.pri-sn
  key_name               = "${var.key-pair}"
  vpc_security_group_ids = [var.backend-sg]
  tags = {
    Name = "${var.project}-mq"
  }
}
*/