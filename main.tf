terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  application = "apollo"
  environment = "production"

  availability_zones = ["eu-west-1a", "eu-west-1b"]

  networking = {
    cidr_block       = "10.0.0.0/16"
    database_subnets = [
      "10.0.10.0/24",
      "10.0.11.0/24"
    ]
    ecs_subnets = [
      "10.0.20.0/24",
      "10.0.30.0/24"
    ]
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "apollo"
  default_tags {
    tags = {
      application = local.application
      environment = local.environment
    }
  }
}

module "networking" {
  source                 = "./modules/networking"
  application            = local.application
  environment            = local.environment
  vpc_cidr_block         = local.networking.cidr_block
  availability_zones     = local.availability_zones
  ecs_subnets_cidr_block = local.networking.ecs_subnets
  rds_subnets_cidr_block = local.networking.database_subnets
}

module "ecr" {
  source              = "./modules/ecr"
  ecr_repository_name = local.application
}

module "ecs" {
  source          = "./modules/ecs"
  application     = local.application
  environment     = local.environment
  image_url       = module.ecr.ecr_repository_url
  vpc_id          = module.networking.vpc_id
  ecs_subnets_ids = module.networking.ecs_subnets_ids
}

module "alb" {
  source      = "./modules/alb"
  application = local.application
  environment = local.environment
  vpc_id      = module.networking.vpc_id
  alb_subnets = module.networking.ecs_subnets_ids
}


module "rds" {
  source              = "./modules/rds"
  database_identifier = "${local.application}-${local.environment}-db"
  database_name       = local.application
  password            = "password"
  username            = "username"
  application         = local.application
  environment         = local.environment
  vpc_id              = module.networking.vpc_id
  rds_subnet_ids      = module.networking.rds_subnets_ids
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}
