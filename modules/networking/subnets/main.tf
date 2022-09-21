resource "aws_subnet" "rds_subnet_a" {
  vpc_id     = var.vpc_id
  cidr_block = var.database_subnets[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "${var.application}-${var.environment}-rds_subnet_a"
    Description = "RDS subnet A"
  }
}

resource "aws_subnet" "rds_subnet_b" {
  vpc_id     = var.vpc_id
  cidr_block = var.database_subnets[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "${var.application}-${var.environment}-rds_subnet_b"
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
