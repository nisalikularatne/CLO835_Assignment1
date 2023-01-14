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
