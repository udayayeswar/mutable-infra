module "vpc" {
  source = "./module"
  vpc_cidr = var.vpc_cidr
}