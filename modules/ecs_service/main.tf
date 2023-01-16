data "aws_region" "current" {}

locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
  region = data.aws_region.current.name
}

data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    bucket = "dev-clo835-assignment"
    key    = "infrastructure/terraform.tfstate"
    region = local.region
  }
}

resource "aws_ecs_service" "application" {
  name                               = "${local.prefix}-service"
  cluster                            = data.terraform_remote_state.this.outputs.ecs_id
  task_definition                    = var.td_application_arn
  desired_count                      = var.service_desired_count
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    subnets          = [data.terraform_remote_state.this.outputs.subnet_id]
    assign_public_ip = true
  }

}
