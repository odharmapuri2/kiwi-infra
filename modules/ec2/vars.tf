variable AMIS {
  type = map
  default = {
    us-east-2 = "ami-03657b56516ab7912"
    us-east-1 = "ami-0947d2ba12ee1ff75"
  }
}
variable app-server {
  default = "ami-007855ac798b5175e"
}
variable centos {
  default = "ami-002070d43b0a4f171"
}
variable key-pair {
  default = "kiwigate"
}
variable project {
  default = "kiwi"
}
variable "pri-sn" {}
variable "pub-sn" {}
variable "app-sg" {}
variable "elb-sg" {}
variable "backend-sg" {}