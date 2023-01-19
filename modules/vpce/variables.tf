variable "stage" {
  type        = string
  description = "Deployment stage, e.g. dev, test, prod"
  default     = "dev"
}


variable "ipv4_primary_cidr_block" {
  type        = string
  description = "IPV4 primary cidr block"
  default     = "10.0.0.0/16"
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


variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
  default     = []
}


variable "private_route_table_ids" {
  type        = list(string)
  description = "List of route tables associated with private subnets"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC Id"
}

variable "ecs_sg_id" {
  type        = string
  description = "Security Group ID of ECS service"

}

