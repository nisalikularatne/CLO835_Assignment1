output "td_application_arn" {
  description = "Task definition ARN"
  value       = aws_ecs_task_definition.application.arn
}
