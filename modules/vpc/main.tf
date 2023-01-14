module "vpc" {
  source                           = "cloudposse/vpc/aws"
  version                          = "2.0.0"
  stage                            = var.stage
  dns_hostnames_enabled            = true
  dns_support_enabled              = true
  ipv4_primary_cidr_block          = var.ipv4_primary_cidr_block
}
