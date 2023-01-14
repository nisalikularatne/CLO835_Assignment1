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
  description = "ECR Name"
  default     = "containers"
}
variable "namespace" {
  type        = string
  description = "Project namespace"
  default     = "docker"
}
