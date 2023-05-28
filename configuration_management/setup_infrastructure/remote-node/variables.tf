variable "vpc_cidr_block" {
  description = "IPv4 CIDR range of VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
  description = "IPv4 CIDR range of Subnet"
  type        = string
  default     = "10.0.0.0/28"
}
variable "az" {
  description = "availablity zone of subnet"
  type        = string
}
variable "ami" {
  description = "Amazon Machine Image of Linux machine"
  type        = string
}
variable "env_prefix" {
  description = "environment name for infra components"
  type        = string
}
variable "ip_address_range" {
  description = "IP Subnet range allowed to access remote node on port 22"
  type        = string
  # E.g your computer/work network IPv4  range
}
variable "instance_type" {
  description = "instance type for machine"
  type        = string
}
variable "public_key_location" {
  description = "/path/to/remote/public/key"
  type        = string
}
variable "region" {
  description = "region for infra deployment"
  type        = string
}

variable "ssh_key_private" {
  description = "ssh private key used by remote node during ansible configuration"
  type        = string
}