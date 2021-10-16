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



module "vpc" {
  source      = "../../module_aws/vpc"
  system      = var.system
  env         = var.env
  cidr_vpc    = var.vpc_cidr
  cidr_public = var.cidr_public

}


module "ec2" {
  source       = "../../module_aws/ec2"
  system       = var.system
  env          = var.env
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.subnets
  myip         = var.myip
  instance_cnt = var.instance_cnt
  ami          = var.ami
  type         = var.type
  key_name     = var.key_name
}


module "alb" {
  source        = "../../module_aws/elb"
  system        = var.system
  env           = var.env
  subnets       = module.vpc.subnets
  sg-elb        = module.ec2.sg-elb
  vpc_id        = module.vpc.vpc_id
  pub_instances = module.ec2.pub_instances
}