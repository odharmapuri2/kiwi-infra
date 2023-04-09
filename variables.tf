variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}
variable "zone" {
  default = "us-east-1a"
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