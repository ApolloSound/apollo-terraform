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

variable "ecs_subnets_ids" {
  type        = list(string)
  description = "The subnets ids for the ECS cluster"
}
