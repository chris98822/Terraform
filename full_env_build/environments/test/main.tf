provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {}
}

#place holder
module "vpc" {
    source = "vpc/"
}

module "security_groups" {
    source = "security_groups/"
}

module "single_ec2" {
    source = "resources/single_ec2/"
}

module "crm_app_asg_dev" {
    source = "resources/crm_app_asg_dev/"
}