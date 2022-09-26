variable "application" {
  type        = string
  description = "Application name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "cidr_subnets_blocks" {
  type        = list(string)
  description = "CIDR subnets blocks"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}
