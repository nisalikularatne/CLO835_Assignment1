locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
}

# Define ECR repo to store application images
resource "aws_ecr_repository" "application" {
  name         = "${local.prefix}-application-repo"
  force_delete = true

  tags = {
    Name = "${local.prefix}-application-repo"
  }
}
resource "aws_ecr_repository" "database" {
  name         = "${local.prefix}-database-repo"
  force_delete = true

  tags = {
    Name = "${local.prefix}-database-repo"
  }
}
