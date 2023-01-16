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
