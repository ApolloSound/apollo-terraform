locals {
  default_mysql_port     = 3306
  default_mysql_protocol = "tcp"
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
