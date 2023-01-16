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
variable "ipv4_primary_cidr_block" {
  type        = string
  description = "IPV4 cidr block for VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  type        = string
  description = "IPV4 cidr block for public subnet"
  default     = "10.0.0.0/24"
}
variable "container_port" {
  type        = number
  description = "The port the application listens on"
  default     = 3000
}
variable "host_port" {
  type        = number
  description = "The port the application listens on"
  default     = 3000
}
variable "service_desired_count" {
  type        = number
  description = "The desired number of tasks per service"
  default     = 2
}
