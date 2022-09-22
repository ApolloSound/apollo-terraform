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
