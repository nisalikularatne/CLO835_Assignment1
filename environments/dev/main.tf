# VPC
module "vpc" {

  source                  = "../../modules/vpc"
  stage                   = var.stage
  name                    = var.name
  ipv4_primary_cidr_block = var.ipv4_primary_cidr_block
}
module "public_subnet" {
  source             = "../../modules/subnet"
  public_subnet_cidr = var.public_subnet_cidr
  vpc_id             = module.vpc.vpc_id
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

}
