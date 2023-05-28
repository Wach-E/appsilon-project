variable "env_prefix" {
  description = "environment prefix"
  type        = string
}
variable "public_key_location" {
  description = "location of public key"
  type        = string
  default     = "null"
}
variable "instance_type" {
  description = "type of instance to be provision"
  type        = string
  default     = "null"
}
variable "subnet_id" {
  description = "ID of subnet"
  type        = string
  default     = null
}
variable "vpc_id" {
  description = "The ID of the VPC to deploy into"
  type        = string
  default     = null
}
variable "az" {}
variable "ip_address_range" {}

variable "ami" {
  type = string
}
