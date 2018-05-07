provider "aws" {
  region = "${module.vpc.region}"
}
module "vpc" {
    source = "../vpc/"
}