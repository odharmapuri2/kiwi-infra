resource "aws_lb_target_group" "kiwi-dev-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
  #instance = [var.app01, var.app02] #"${element(aws_instance.myinstance.*.id, count.index)}"

  name        = "${var.project}-dev-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${var.vpc-id}"
}
resource "aws_lb_target_group_attachment" "kiwi-dev-tg-a1" {
  target_group_arn = "${aws_lb_target_group.kiwi-dev-tg.arn}"
  target_id        = "${var.app01}" 
  port             = 80
}
resource "aws_lb_target_group_attachment" "kiwi-dev-tg-a2" {
  target_group_arn = "${aws_lb_target_group.kiwi-dev-tg.arn}"
  target_id        = "${var.app02}"
  port             = 80
}
resource "aws_lb" "kiwi-dev-alb" {
  name     = "${var.project}-dev-alb"
  internal = false

  security_groups = [
    "${var.alb-sg}",
  ]

  subnets = [
    "${var.sn1}",
    "${var.sn2}",
  ]

  tags = {
    Name = "${var.project}-dev-alb"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "kiwi-dev-alb-listner" {
  load_balancer_arn = "${aws_lb.kiwi-dev-alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.kiwi-dev-tg.arn}"
  }
}