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

  networking = {
    cidr_block       = "10.0.0.0/16"
    database_subnets = [
      "10.0.4.0/24",
      "10.0.5.0/24",
      "10.0.6.0/24"
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

module "vpc" {
  source     = "./modules/networking/vpc"
  cidr_block = local.networking.cidr_block
  name       = "${local.application}-${local.environment}-vpc"
}

module "ecr" {
  source              = "./modules/ecr"
  ecr_repository_name = local.application
}

module "rds" {
  source              = "./modules/rds"
  database_identifier = "${local.application}-${local.environment}-db"
  database_name       = local.application
  password            = "password"
  username            = "username"
  subnets             = local.networking.database_subnets
  vpc_id              = module.vpc.vpc_id
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}
