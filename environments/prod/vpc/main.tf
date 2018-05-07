provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "../../modules/vpc"

  name = "REMAX-SANDBOX"

  cidr = "10.20.0.0/16"

  azs                 = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets     = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  public_subnets      = ["10.20.11.0/24", "10.20.12.0/24", "10.20.13.0/24"]
  
  /*database_subnets    = ["10.20.21.0/24", "10.20.22.0/24", "10.20.23.0/24"]
  elasticache_subnets = ["10.20.31.0/24", "10.20.32.0/24", "10.20.33.0/24"]
  redshift_subnets    = ["10.20.41.0/24", "10.20.42.0/24", "10.20.43.0/24"]*/

  create_database_subnet_group = false

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_s3_endpoint       = false
  enable_dynamodb_endpoint = false

  enable_dhcp_options              = false
  dhcp_options_domain_name         = "service.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.20.0.2"]

  tags = {
    Owner       = "REMAX"
    Environment = "Sandbox"
    Name        = "REMAX"
  }
}
