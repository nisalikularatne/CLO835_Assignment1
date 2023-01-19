output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "ecr_repository_id" {
  description = "The ID of the ecr repository"
  value       = module.ecr.ecr_repo_id
}
output "private_subnet_ids" {
  description = "List of private subnet ids"
  value       = module.vpc.private_subnet_ids
}
output "ecs_id" {
  description = "The ID of ECS cluster"
  value       = module.ecs.ecs_id
}
output "ecs_service_sg_id" {
  description = "ECS Service SG"
  value       = module.ecs.ecs_sg_id
}


output "role"{
  description = "The executional role"
  value       = module.ecs_task_execution_role.arn
}
output "alb_target_group_arn" {
  description = "ALB Target group ARN"
  value       = module.alb.alb_target_group_arn
}
