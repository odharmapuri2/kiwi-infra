module "aws_vpc" {
  name = "${var.project}-vpc"
  cidr = "10.0.0.0/16"
  tags = {
    Terraform = "true"
    Environment = "${var.env}"
  }
}