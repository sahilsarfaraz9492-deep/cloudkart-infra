terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ec2" {
  source        = "./modules/ec2"
  name          = "cloudkart-server"
  instance_type = var.instance_type
}

resource "aws_ecr_repository" "repos" {
  for_each = toset(["cloudkart-backend", "cloudkart-frontend"])
  name     = each.key
}
