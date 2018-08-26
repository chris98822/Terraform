########################################################################
#   Notes:
#       This variables file is used to configure perameters for the
#       VPC in a specific environment which should be reflected by
#       the file structure it resides in.
#       Set perameters based on this environment (dev, test, UAT, prod)
########################################################################

####################
# General Information
####################
variable "region"                           { default = "us-west-2" }
variable "owner"                            { default = "company_name" }
variable "aws_account_name"                 { default = "devops" }
variable "product_brand"                    { default = "demo" }
variable "environment_level"                { default = "test" }
variable "availability_zones"               { default = ["us-west-2a", "us-west-2b", "us-west-2c"] }

########################
# Network Configuration
########################
    # Notes:
    #   IP range at /24 should reflect the AZ
    #     10.20.x1.0 = 2a
    #     10.20.x2.0 = 2b
    #     10.20.x3.0 = 2c
    #   The base 10 reflects the resource (as seen below)
    #
    #   IP cidr block (/16) should reflect environment
    #     10.20.x.x = PROD
    #     10.21.x.x = QA/UAT
    #     10.22.x.x = TEST
    #     10.23.x.x = DEV(?)

variable "vpc_cidr"                         { default = "10.22.0.0/16" }
variable "private_subnet_list"              { default = ["10.22.1.0/24", "10.22.2.0/24", "10.22.3.0/24"] }
variable "public_subnet_list"               { default = ["10.22.11.0/24", "10.22.12.0/24", "10.22.13.0/24"] }
variable "database_subnet_list"             { default = ["10.22.21.0/24", "10.22.22.0/24", "10.22.23.0/24"] }
variable "elasticache_subnet_list"          { default = ["10.22.31.0/24", "10.22.32.0/24", "10.22.33.0/24"] }
variable "redshift_subnet_list"             { default = ["10.22.41.0/24", "10.22.42.0/24", "10.22.43.0/24"] }
variable "dhcp_options_domain_name"         { default = "devops.testing" }
variable "dhcp_options_domain_name_servers" { default = ["AmazonProvidedDNS", "10.22.0.2"] }

###################################
# Default AMI Image (Amazon Linux 2)
###################################

