locals {
  default_mysql_port     = 3306
  default_mysql_protocol = "tcp"
}

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

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_security_group" "rds_sg" {
  name   = "${var.database_name}-rds-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port = local.default_mysql_port
    protocol  = local.default_mysql_protocol
    to_port   = local.default_mysql_port
  }
  egress {
    from_port = local.default_mysql_port
    protocol  = local.default_mysql_protocol
    to_port   = local.default_mysql_port
  }
}
