provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {}
}

module "vpc" {
  source = "../../../modules/vpc"

  #feature options
  create_database_subnet_group = true
  enable_nat_gateway           = true
  enable_vpn_gateway           = false
  enable_s3_endpoint           = false
  enable_dynamodb_endpoint     = false
  enable_dhcp_options          = true
  map_public_ip_on_launch      = true

  #Variables set in variables.tf file
  name            = "${var.aws_account_name}-${var.product_brand}-${var.environment_level}-vpc"
  cidr            = "${var.vpc_cidr}"
  azs             = "${var.availability_zones}"
  private_subnets = "${var.private_subnet_list}"            #Reference subnet via: "${module.vpc.private_subnets[0]}" 0, 1, 2 to select list number
  public_subnets  = "${var.public_subnet_list}"             #Reference subnet via: "${module.vpc.public_subnets[0]}" 0, 1, 2 to select list number

  /*database_subnets                  = "${var.database_subnet_list}"
    elasticache_subnets               = "${var.elasticache_subnet_list}"
    redshift_subnets                  = "${var.redshift_subnet_list}"*/
  dhcp_options_domain_name = "${var.dhcp_options_domain_name}"

  dhcp_options_domain_name_servers = "${var.dhcp_options_domain_name_servers}"

  #Tags are set in variables.tf file. Edit "additional_tags" to add more
  tags = {
    owner       = "${var.owner}"
    account     = "${var.aws_account_name}"
    product     = "${var.product_brand}"
    environment = "${var.environment_level}"
    creator     = "terraform"
    resource    = "VPC"
  }
}
