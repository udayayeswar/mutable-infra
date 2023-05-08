module "vpc" {
  source = "./tf-module-vpc"
  vpc_cidr = var.vpc_cidr
}