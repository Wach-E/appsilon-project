variable "vpc_id" {
  description = "The ID of the VPC to deploy into"
  type        = string
  default     = null
}

variable "subnet_cidr_block" {
  description = "CIDR range of subnet"
  type        = string
  default     = null
}

variable "az" {
  description = "Availability zone to deploy into"
  type        = string
  default     = "us-east-1a"
}

variable "env_prefix" {
  description = "Availability zone to deploy into"
  type        = string
  default     = "dev"
}

variable "default_route_table_id" {
  description = "ID of default route table"
  type        = string
  default     = null
}
