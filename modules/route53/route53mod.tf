resource "aws_route53_zone" "route" {
  name = "kiwi.com"

  vpc {
    vpc_id = "${var.vpc-id}"
  }
}

resource "aws_route53_record" "record" {
  count   = "${length(var.app)}"
  name    = "${element(var.app,count.index)}"
  records = ["${element(var.ec2ip,count.index)}"]
  zone_id = "${aws_route53_zone.route.id}"
  type    = "A"
  ttl     = "300"
}