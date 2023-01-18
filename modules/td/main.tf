//
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_iam_role" "labrole" {
  name = "AWSServiceRoleForECS"
}

data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    bucket = "dev-clo835-assignment1"
    key    = "infrastructure/terraform.tfstate"
    region = local.region
  }
}

locals {
  prefix       = "${var.namespace}-${var.stage}-${var.name}"
  region       = data.aws_region.current.name
  ecr_repo     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-repo"
  log_group    = aws_cloudwatch_log_group.this.name
  lab_role_arn = data.aws_iam_role.labrole.arn
}

resource "aws_ecs_task_definition" "application" {
  family                   = "${local.prefix}-application-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = local.lab_role_arn
#  task_role_arn            = local.lab_role_arn
  container_definitions = jsonencode([{
    name      = "${local.prefix}-container"
    image     = local.ecr_repo
    essential = true
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
      hostPort      = var.host_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = local.log_group
        awslogs-stream-prefix = "/aws/ecs"
        awslogs-region        = local.region
      }
    }
  }])

  tags = {
    Name        = "${local.prefix}-task"
    Environment = var.stage
  }
}
resource "aws_ecs_task_definition" "database" {
  family                   = "${local.prefix}-database-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = local.lab_role_arn
#  task_role_arn            = local.lab_role_arn
  container_definitions = jsonencode([{
    name      = "${local.prefix}-database-container"
    image     = local.ecr_repo
    essential = true
    portMappings = [{
      protocol      = "tcp"
      containerPort = 8080
      hostPort      = 8080
    }]
    environment = [
      { "name" : "MYSQL_ROOT_PASSWORD", "value" : "pw" }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = local.log_group
        awslogs-stream-prefix = "/aws/ecs"
        awslogs-region        = local.region
      }
    }
  }])

  tags = {
    Name        = "${local.prefix}-task"
    Environment = var.stage
  }
}
resource "aws_cloudwatch_log_group" "this" {
  name = "${local.prefix}-cloudwatch-log-group"

  tags = {
    Name        = "${local.prefix}-cloudwatch-log-group"
    Environment = var.stage
  }
}

resource "aws_cloudwatch_log_stream" "todo_container_cloudwatch_logstream" {
  name           = "${local.prefix}-cloudwatch-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}
