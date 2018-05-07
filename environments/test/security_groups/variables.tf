#Load environment VPC module to get vars
module "vpc" {
    source = "../vpc/"
}

#
variable "env_vpc_id"        { default = "${module.vpc.vpc_id}" }


########
# Tags
########
    #Default Tags - Typically, don't change this.
    variable "primary_tags" {
        owner           = "${module.vpc.owner}"
        account         = "${module.vpc.aws_account_name}"
        product         = "${module.vpc.product_brand}"
        environment     = "${module.vpc.environment_level}"
        creator         = "terraform"
        resource        = "security_group"
    }

    #Add more tags to VPC here.
    variable "additional_tags" { 
        default = { 
            tag1        = "test1"
            tag2        = "test2"
        }
    }