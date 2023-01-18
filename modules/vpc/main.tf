module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.0.0"
  stage                   = var.stage
  name                    = var.name
  namespace               = var.namespace
  dns_hostnames_enabled   = true
  dns_support_enabled     = true
  ipv4_primary_cidr_block = var.ipv4_primary_cidr_block
}
module "dynamic_subnets" {
  source                  = "cloudposse/dynamic-subnets/aws"
  version                 = "2.0.4"
  namespace               = var.namespace
  stage                   = var.stage
  name                    = var.name
  availability_zones      = ["us-east-1a", "us-east-1b"]
  private_subnets_enabled = true
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = [module.vpc.igw_id]
  ipv4_cidr_block         = [module.vpc.vpc_cidr_block]
}
