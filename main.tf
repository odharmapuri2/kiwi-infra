provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  #shared_credentials_files = ["/Users/rwagh/.aws/credentials"]
}
#Modules
module "vpc" {
  source    = "./modules/vpc"
}
module "ec2" {
  source = "./modules/ec2"
  pri-sn = "${module.vpc.pri-sn}"
  pub-sn = "${module.vpc.pub-sn}"
  app-sg = "${module.vpc.app-sg}"
  elb-sg = "${module.vpc.elb-sg}"
  backend-sg = "${module.vpc.backend-sg}"
}