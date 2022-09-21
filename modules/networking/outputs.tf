output "vpc_id" {
  value = module.vpc.vpc_id
}

output "database_subnet_group_name" {
  value = module.subnets.database_subnet_group_name
}

output "database_security_group_id" {
  value = module.security_groups.rds_sg_id
}
