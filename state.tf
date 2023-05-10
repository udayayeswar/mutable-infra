terraform {
  backend "s3" {
    bucket = "udaya-terraform-state"
    key    = "state/dev/mutable-infra/terraform.tfstate"
    region = "us-east-1"

  }
}