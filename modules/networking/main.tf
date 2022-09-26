module "vpc" {
  source      = "./vpc"
  application = var.application
  environment = var.environment
  cidr_block  = var.vpc_cidr_block
}

module "ecs_subnet" {
  source              = "./subnets"
  application         = var.application
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  cidr_subnets_blocks = var.ecs_subnets_cidr_block
  availability_zones  = var.availability_zones
}

module "rds_subnet" {
  source              = "./subnets"
  application         = var.application
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  cidr_subnets_blocks = var.rds_subnets_cidr_block
  availability_zones  = var.availability_zones
}
