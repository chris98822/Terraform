provider "aws" {
  region = "${module.vpc.region}"
}
