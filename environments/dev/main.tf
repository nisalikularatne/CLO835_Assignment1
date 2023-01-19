# VPC
module "vpc" {

  source                  = "../../modules/vpc"
  stage                   = var.stage
  name                    = var.name
  ipv4_primary_cidr_block = var.ipv4_primary_cidr_block
}

# ECR
module "ecr" {

  source = "../../modules/ecr"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}

module "td" {

  source = "../../modules/td"

  name           = var.name
  namespace      = var.namespace
  stage          = var.stage
  container_port = var.container_port
  role = module.ecs_task_execution_role.arn
}
module "ecs_service" {

  source = "../../modules/ecs_service"

  name                  = var.name
  namespace             = var.namespace
  stage                 = var.stage
  container_port        = var.container_port
  td_application_arn                = module.td.td_application_arn
  td_database_arn                = module.td.td_database_arn
  service_desired_count = var.service_desired_count
}
module "ecs" {

  source = "../../modules/ecs"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
  vpc_id    = module.vpc.vpc_id

}
module "ecs_task_execution_role" {
  source = "dod-iac/ecs-task-execution-role/aws"

  allow_create_log_groups    = true
  allow_ecr = true
  cloudwatch_log_group_names = ["*"]
  name = "ecs-execution-role"

  tags  = {
    Automation  = "Terraform"
  }
}
# ALB to front ECS service
module "alb" {

  source = "../../modules/alb"

  name              = var.name
  namespace         = var.namespace
  stage             = var.stage
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
}
#module "vpce" {
#
#  source = "../../modules/vpce"
#
#  name                    = var.name
#  namespace               = var.namespace
#  stage                   = var.stage
#  private_subnet_ids      = module.vpc.private_subnet_ids
#  private_route_table_ids = module.vpc.private_route_table_ids
#  vpc_id                  = module.vpc.vpc_id
#  ecs_sg_id               = module.ecs.ecs_sg_id
#}
