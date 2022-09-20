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
    cidr_block = "10.0.0.0/16"
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

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}
