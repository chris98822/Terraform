provider "aws" {
  region = "${module.vpc.region}"
}

#Load Environment VPC
module "vpc" {
    source = "../../vpc/"
}
#Load Security Groups
module "security_groups" {
    source = "../../security_groups/"
}
