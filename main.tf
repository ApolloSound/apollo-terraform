terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  tags = {
    application = "apollo"
    environment = "production"
  }
}

provider "aws" {
  region = "eu-west-1"
  profile = "apollo"
  default_tags {
    tags = local.tags
  }
}

module "vpc" {
  source = "./modules/networking/vpc"
  tags = local.tags
}
