# tf-sample-module
moduleを使って複数の環境を作成するテンプレート
/environment/{dev|stg|prd}/terraform.tfvarsに環境ごとの値を入れる
# Features
## aws
* VPC
* EC2

# Requirement
* Terraform v1.0.6

# Installation

## git clone

```zsh
$ git clone https://github.com/hito-kotaro/tf-sample-ansible.git

```

## create terraform.tfvars
```zsh
$ cd tf-sample-module/environment/{dev|stg|prd}
$ touch terraform.tfvars
$ vim terraform.tfvars
```

### terraform.tfvars
```
# terraform.tfvars
system       = <YOUR SYSTEM NAME>
env          = <YOUR ENVIRONMENT NAME>
myip         = <YOUR IP. USE SECURITY GROUP ACCESS>
instance_cnt = <NUM OF INSTANCE>
ami          = <AMI ID>
type         = <INSTANCE TYPE>
key_name     = <EC2 INSTANCE KEY PAIR>
vpc_cidr     = <VPC CIDR BLOCK>
cidr_public  = <SUBNET CIDR BLOCK(list)>

```

### terraform.tfvars Sample
```
# terraform.tfvars
system       = "mysystem"
env          = "dev"
myip         = 1.1.1.1
instance_cnt = 2
ami          = "ami-0701e21c502689c31"
type         = "t2.micro"
key_name     = "secretkey"
vpc_cidr     = "10.0.0.0/16"
cidr_public  = ["10.0.1.0/24", "10.0.2.0/24"]
```

## ecexute terraform 
```zsh
$ terraform init 
$ terraform apply
```
