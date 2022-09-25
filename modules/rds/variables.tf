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

variable "allocated_storage" {
  default     = 10
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "database_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance."
}

variable "instance_class" {
  type        = string
  description = "The compute and memory capacity of the DB instance, for example, db.t2.micro"
  default     = "db.t2.micro"
}

variable "engine" {
  type        = string
  description = "The name of the database engine to be used for this DB instance"
  default     = "mysql"
}

variable "engine_version" {
  type        = string
  description = "The version number of the database engine to use"
  default     = "5.7"
}

variable "username" {
  type        = string
  description = "Username for the master DB user"
}

variable "password" {
  type        = string
  sensitive   = true
  description = "Password for the master DB user"
}

variable "database_identifier" {
  type        = string
  description = "The database name identifier"
}

variable "database_subnets" {
  type        = list(string)
  description = "Subnets for the database"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}
