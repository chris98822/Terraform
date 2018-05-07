##################
# Static Variables
##################
#Load Environment VPC
module "vpc" {
    source = "../vpc/"
}
#Load Security Groups
module "sec_group" {
    source = "../security_groups/"
}
#change this for a different AMI
variable "ami"              { default = "${module.vpc.default_ami}"}
#Security Groups
variable "public_sg"        { default = "${module.security_groups.public_id}"}
variable "private_sg"        { default = "${module.security_groups.private_id}"}
variable "public_subnets"   { default = ["${module.vpc.public_subnets}"] }
variable "private_subnets"  { default = ["${module.vpc.private_subnets}"] }

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
        resource        = "single_ec2"
    }

    #Add more tags to VPC here.
    variable "additional_tags" { 
        default = { 
            tag1        = "test1"
            tag2        = "test2"
        }
    }