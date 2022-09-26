output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecs_subnets_ids" {
  value = [module.ecs_subnet.subnet_a_id, module.ecs_subnet.subnet_b_id]
}
