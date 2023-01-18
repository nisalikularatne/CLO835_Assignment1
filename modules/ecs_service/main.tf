data "aws_region" "current" {}

locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
  region = data.aws_region.current.name
}

data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    bucket = "dev-clo835-assignment1"
    key    = "infrastructure/terraform.tfstate"
    region = local.region
  }
}

resource "aws_ecs_service" "application" {
  name                               = "${local.prefix}-application-service"
  cluster                            = data.terraform_remote_state.this.outputs.ecs_id
  task_definition                    = var.td_application_arn
  desired_count                      = var.service_desired_count
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [data.terraform_remote_state.this.outputs.ecs_service_sg_id]
    subnets          = data.terraform_remote_state.this.outputs.private_subnet_ids
    assign_public_ip = true
  }

}
resource "aws_ecs_service" "database" {
  name                               = "${local.prefix}-database-service"
  cluster                            = data.terraform_remote_state.this.outputs.ecs_id
  task_definition                    = var.td_database_arn
  desired_count                      = var.service_desired_count
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [data.terraform_remote_state.this.outputs.ecs_service_sg_id]
    subnets          = data.terraform_remote_state.this.outputs.private_subnet_ids
    assign_public_ip = true
  }

}
