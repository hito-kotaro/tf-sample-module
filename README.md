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
$ cd tf-sample-module
```

## create terraform.tfvars
```zsh
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

## ecexute terraform 
```zsh
$ terraform init 
$ terraform apply
```
