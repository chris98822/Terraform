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


    #Default Tags for ELB
    variable "elb_tags" {
        owner           = "${module.vpc.owner}"
        account         = "${module.vpc.aws_account_name}"
        product         = "${module.vpc.product_brand}"
        environment     = "${module.vpc.environment_level}"
        creator         = "terraform"
        resource        = "Load_Balancer"
    }

    #Add more tags here.
    variable "elb_additional_tags" { 
        default = { 
            tag1        = "test1"
            tag2        = "test2"
        }
    }

    #Default Tags for ASG
    variable "asg_tags" {
        owner           = "${module.vpc.owner}"
        account         = "${module.vpc.aws_account_name}"
        product         = "${module.vpc.product_brand}"
        environment     = "${module.vpc.environment_level}"
        creator         = "terraform"
        resource        = "Auto_Scaling_Group"
    }

    #Add more tags here.
    variable "asg_additional_tags" { 
        default = { 
            tag1        = "test1"
            tag2        = "test2"
        }
    }

    #Default Tags for LC
    variable "lc_tags" {
        owner           = "${module.vpc.owner}"
        account         = "${module.vpc.aws_account_name}"
        product         = "${module.vpc.product_brand}"
        environment     = "${module.vpc.environment_level}"
        creator         = "terraform"
        resource        = "Auto_Scaling_Group"
    }

    #Add more tags here.
    variable "lc_additional_tags" { 
        default = { 
            tag1        = "test1"
            tag2        = "test2"
        }
    }