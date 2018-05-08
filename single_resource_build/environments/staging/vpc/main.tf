provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "../../../modules/vpc"

  name = "devops_staging"

  cidr = "10.21.0.0/16"

#Reference subnet via: "${module.vpc.private_subnets[0]}" 0, 1, 2 to select list number
  azs                 = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets     = ["10.21.1.0/24", "10.21.2.0/24", "10.21.3.0/24"]
  public_subnets      = ["10.21.11.0/24", "10.21.12.0/24", "10.21.13.0/24"]
  
  /*database_subnets    = ["10.21.21.0/24", "10.21.22.0/24", "10.21.23.0/24"]
  elasticache_subnets = ["10.21.31.0/24", "10.21.32.0/24", "10.21.33.0/24"]
  redshift_subnets    = ["10.21.41.0/24", "10.21.42.0/24", "10.21.43.0/24"]*/

  create_database_subnet_group = false

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_s3_endpoint       = false
  enable_dynamodb_endpoint = false

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "devops.test"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.21.0.2"]

  tags = "${merge(var.primary_tags, var.additional_tags)}"
}
