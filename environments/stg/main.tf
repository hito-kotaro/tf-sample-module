terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.24.1"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source   = "../../module_aws/vpc"
  system   = "Isis"
  env      = "stg"
  cidr_vpc = "10.110.0.0/16"
  cidr_public = [
    "10.110.10.0/24",
    "10.110.11.0/24",
    "10.110.12.0/24"
  ]

  cidr_private = [
    "10.110.20.0/24",
    "10.110.21.0/24",
    "10.110.22.0/24"
  ]
}

