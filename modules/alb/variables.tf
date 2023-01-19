variable "stage" {
  type        = string
  description = "Deployment stage, e.g. dev, test, prod"
  default     = "dev"
}
variable "namespace" {
  type        = string
  description = "Project name"
  default     = "week4"
}

variable "name" {
  type        = string
  description = "No idea what name is for"
  default     = "todo-app"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
  default     = []
}


variable "vpc_id" {
  type        = string
  description = "VPC Id"
}

