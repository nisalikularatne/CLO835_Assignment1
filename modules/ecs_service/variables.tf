variable "stage" {
  type        = string
  description = "Deployment stage, e.g. dev, test, prod"
  default     = "dev"
}

variable "name" {
  type        = string
  description = "VPC Name"
  default     = "containers"
}
variable "namespace" {
  type        = string
  description = "Project namespace"
  default     = "docker"
}
variable "service_desired_count" {
  type        = number
  description = "The desired number of tasks per service"
  default     = 2
}

variable "container_port" {
  type        = number
  description = "The port the application listens on"
}

variable "td_application_arn" {
  type        = string
  description = "Task definition ARN"
}
variable "td_database_arn" {
  type        = string
  description = "Task definition ARN"
}
