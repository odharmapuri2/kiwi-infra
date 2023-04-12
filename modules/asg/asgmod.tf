resource "aws_launch_configuration" "launch-conf" {
  image_id        = "ami-002070d43b0a4f171"
  instance_type   = "t2.micro"
  security_groups = [var.app-sg]
  user_data       = "./ec2/tomcat.sh"
  /*user_data = <<-EOF
              #!/bin/bash
              yum -y install httpd
              echo "Hello, from Terraform" > /var/www/html/index.html
              service httpd start
              chkconfig httpd on
              EOF
              */
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = "${aws_launch_configuration.launch-conf.name}"
  vpc_zone_identifier  = ["${var.sn1}","${var.sn2 }"]
  #target_group_arns     = "${var.tg}"
  health_check_type    = "ELB"

  min_size = 2
  max_size = 4

  tag {
    key                 = "name"
    value               = "${var.project}-dev-asg"
    propagate_at_launch = true
  }
}