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
variable "owner"                            { default = "REMAX" }
variable "aws_account_name"                 { default = "devops" }
variable "product_brand"                    { default = "testing" }
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
variable "dhcp_options_domain_name"         { defualt = "devops.testing" }
variable "dhcp_options_domain_name_servers" { defualt = ["127.0.0.1", "10.22.0.2"] }

###################################
# Default AMI Image (Amazon Linux 2)
###################################
variable "default_ami"                      { default = "${data.aws_ami.amazon_linux2}" }    #Set a different ami for specific resource under that resource's config

###########
# Tags
###########
    #Default Tags - Typically, don't change this.
    variable "primary_tags" {
        owner           = "${var.owner}"
        account         = "${var.aws_account_name}"
        product         = "${var.product_brand}"
        environment     = "${var.environment_level}"
        creator         = "terraform"
        resource        = "VPC"
    }

    #Add more tags to VPC here.
    variable "additional_tags" { 
        default = { 
            tag1        = "test1"
            tag2        = "test2"
        }
    }