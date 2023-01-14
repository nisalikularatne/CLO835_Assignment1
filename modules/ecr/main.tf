locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
}

# Define ECR repo to store application images
resource "aws_ecr_repository" "this" {
  name         = "${local.prefix}-repo"
  force_delete = true

  tags = {
    Name = "${local.prefix}-repo"
  }
}
