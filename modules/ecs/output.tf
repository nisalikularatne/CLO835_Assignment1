output "ecs_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}

