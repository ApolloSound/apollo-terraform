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
  source             = "./modules/networking"
  application        = local.application
  environment        = local.environment
  availability_zones = local.availability_zones
  cidr_block         = local.networking.cidr_block
  database_subnets   = local.networking.database_subnets
}

module "ecr" {
  source              = "./modules/ecr"
  ecr_repository_name = local.application
}

module "ecs" {
  source      = "./modules/ecs"
  application = local.application
  environment = local.environment
}

module "rds" {
  source                     = "./modules/rds"
  database_identifier        = "${local.application}-${local.environment}-db"
  database_name              = local.application
  password                   = "password"
  username                   = "username"
  subnet_group_name          = module.networking.database_subnet_group_name
  database_security_group_id = module.networking.database_security_group_id
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}
