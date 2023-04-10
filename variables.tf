variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "project" {
  default = "kiwi"
}
variable "zone1a" {
  default = "us-east-1a"
}
variable "zone1b" {
  default = "us-east-1b"
}
