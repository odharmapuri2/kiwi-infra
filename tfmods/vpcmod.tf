module "primevpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "primevpc"
  cidr = "10.0.0.0/16"

  #azs             = ["ap-south-1"]
  #private_subnets = ["10.0.1.0/24"]
  #public_subnets  = ["10.0.2.0/24"]

  #enable_nat_gateway = true
  #enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}