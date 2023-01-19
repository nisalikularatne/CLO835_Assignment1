output "td_application_arn" {
  description = "Task definition ARN"
  value       = aws_ecs_task_definition.application.arn
}
output "td_database_arn" {
  description = "Task definition ARN"
  value       = aws_ecs_task_definition.database.arn
}
