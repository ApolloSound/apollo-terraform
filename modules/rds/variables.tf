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

variable "subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group to use for the DB instance"
}

variable "database_security_group_id" {
  type        = string
  description = "The id of the DB security group to associate with"
}
