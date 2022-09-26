variable "application" {
  type        = string
  description = "Application name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "ecs_subnets_cidr_block" {
  type        = list(string)
  description = "ECS subnet CIDR block"
}

variable "rds_subnets_cidr_block" {
  type        = list(string)
  description = "RDS subnet CIDR block"
}
