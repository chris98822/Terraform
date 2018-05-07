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
variable "public_sg"        { default = "${module.security_groups.private_id}"}
variable "public_subnets"   { default = ["${module.vpc.public_subnets}"] }
