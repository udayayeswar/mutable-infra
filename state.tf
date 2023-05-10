terraform {
  backend "s3" {
    bucket = "udaya-terraform-state"
    key    = "mutable-infra/terraform.tfstate"
    region = "us-east-1"

  }
}