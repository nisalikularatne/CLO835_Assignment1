data "aws_region" "current" {}

locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
  region = data.aws_region.current.name
}
resource "aws_ecs_cluster" "this" {
  name = "${local.prefix}-cluster"

  tags = {
    Name = "${local.prefix}-fargate-cluster"
  }
}
module "ecs_service_sg" {
  source     = "cloudposse/security-group/aws"
  version    = "2.0.0-rc1"
  attributes = ["ecs-primary"]

  # Allow unlimited egress
  allow_all_egress = true

  rule_matrix = [
    # Allow y of these security groups
    {
      self                      = null
      rules = [
        {
          key         = "OTHERS"
          type        = "ingress"
          from_port   = 31000
          to_port     = 61000
          protocol    = "tcp"
          description = "Allow non privileged ports"
        },
        {
          key         = "HTTPALB"
          type        = "ingress"
          from_port   = 8080
          to_port     = 8080
          protocol    = "tcp"
          description = "Allow HTTP from ALB"
        }
      ]
    }
  ]

  vpc_id = var.vpc_id
}


