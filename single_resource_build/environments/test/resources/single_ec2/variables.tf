#Load Environment VPC
module "vpc" {
    source = "../../vpc/"
}

module "security_groups" {
    source = "../../security_groups/"
}