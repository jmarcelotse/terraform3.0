terraform {
  required_version = "1.8.5"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
