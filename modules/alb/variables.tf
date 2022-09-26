variable "application" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The environment of the application"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "alb_subnets" {
  type        = list(string)
  description = "The subnets of the ECS cluster"
}
