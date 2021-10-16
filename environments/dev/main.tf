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
  env      = "dev"
  cidr_vpc = "10.100.0.0/16"
  cidr_public = [
    "10.100.10.0/24",
    "10.100.11.0/24",
    "10.100.12.0/24"
  ]

  cidr_private = [
    "10.100.20.0/24",
    "10.100.21.0/24",
    "10.100.22.0/24"
  ]
}


module "ec2" {
  source       = "../../module_aws/ec2"
  system       = "Isis"
  env          = "dev"
  vpc_id       = module.network.vpc_id
  subnets      = module.network.subnets
  myip         = var.myip
  instance_cnt = var.instance_cnt
  ami          = var.ami
  type         = var.type
  key_name     = var.key_name
}