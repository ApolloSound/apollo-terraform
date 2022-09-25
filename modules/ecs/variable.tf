variable "application" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The environment of the application"
}

variable "image_url" {
  type        = string
  description = "The URL of the ECR repository"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "ecs_subnets" {
  type        = list(string)
  description = "The subnets for the ecs cluster"
}
variable "availability_zones" {
  type        = list(string)
  description = "The availability zones for the ecs cluster"
}
