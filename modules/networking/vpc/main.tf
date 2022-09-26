resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags       = {
    Name = "${var.application}-${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.application}-${var.environment}-igw"
  }
}
