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

resource "aws_security_group" "rds_sg" {
  name   = "${var.application}-${var.environment}-rds-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "mysql_inbound_traffic" {
  from_port         = local.default_mysql_port
  protocol          = local.default_mysql_protocol
  security_group_id = aws_security_group.rds_sg.id
  to_port           = local.default_mysql_port
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "mysql_outbound_traffic" {
  from_port         = local.default_mysql_port
  protocol          = local.default_mysql_protocol
  security_group_id = aws_security_group.rds_sg.id
  to_port           = local.default_mysql_port
  type              = "egress"
  cidr_blocks       = ["10.0.0.0/16"]
}

resource "aws_subnet" "rds_subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.database_subnets[0]
  availability_zone = var.availability_zones[0]
  tags              = {
    Name        = "${var.application}-${var.environment}-rds_subnet_a"
    Description = "RDS subnet A"
  }
}

resource "aws_subnet" "rds_subnet_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.database_subnets[1]
  availability_zone = var.availability_zones[1]
  tags              = {
    Name        = "${var.application}-${var.environment}-rds_subnet_b"
    Description = "RDS subnet B"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.application}-${var.environment}-rds-subnet-group"
  subnet_ids = [aws_subnet.rds_subnet_a.id, aws_subnet.rds_subnet_b.id]

  tags = {
    Name = "${var.application}-${var.environment}-subnet-group"
  }
}
