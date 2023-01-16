output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
output "public_subnet" {
  description = "The ID of the public subnet"
  value       = module.public_subnet.subnet_id
}

output "ecr_repository_id" {
  description = "The ID of the ecr repository"
  value       = module.ecr.ecr_repo_id
}

output "ecs_id" {
  description = "The ID of ECS cluster"
  value       = module.ecs.ecs_id
}
