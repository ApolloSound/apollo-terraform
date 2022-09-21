variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "application" {
  type        = string
  description = "Application name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "database_subnets" {
  type        = list(string)
  description = "Subnets for the database"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}
