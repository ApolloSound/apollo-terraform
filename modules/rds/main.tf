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

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.database_name}-rds-subnet-group"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.database_name}-subnet-group"
  }
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
