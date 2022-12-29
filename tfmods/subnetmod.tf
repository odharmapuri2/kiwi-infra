module "primesubnet" {
    source = "terraform-aws-modules/subnet/aws"

    name        = "primesubnet"
    description = "public subnet for lab env"
    vpc_id      = "aws_vpc.primevpc.id"
    cidr_block  = "10.0.1.0/24"

    tags = {
      Terraform = "true"
      Environment = "dev"
    }
}