resource "aws_subnet" "ecs_subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_subnets_blocks[0]
  availability_zone = var.availability_zones[0]
  tags              = {
    Name        = "${var.application}-${var.environment}-ecs_subnet_a"
    Description = "ECS subnet A"
  }
}

resource "aws_subnet" "ecs_subnet_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_subnets_blocks[1]
  availability_zone = var.availability_zones[1]
  tags              = {
    Name        = "${var.application}-${var.environment}-ecs_subnet_b"
    Description = "ECS subnet B"
  }
}
