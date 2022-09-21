resource "aws_db_instance" "rds" {
  identifier        = var.database_identifier
  allocated_storage = var.allocated_storage
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  db_name           = var.database_name
  username          = var.username
  password          = var.password

  skip_final_snapshot = true

  db_subnet_group_name = var.subnet_group_name

  vpc_security_group_ids = [var.database_security_group_id]
}
