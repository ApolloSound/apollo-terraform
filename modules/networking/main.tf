module "vpc" {
  source     = "./vpc"
  cidr_block = var.cidr_block
  name       = "${var.application}-${var.environment}-vpc"
}

module "security_groups" {
  source      = "./sg"
  vpc_id      = module.vpc.vpc_id
  application = var.application
  environment = var.environment
}

module "subnets" {
  source             = "./subnets"
  application        = var.application
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  database_subnets   = var.database_subnets
}
