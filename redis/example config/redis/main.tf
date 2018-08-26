provider "aws" {
  region = "${data.terraform_remote_state.vpc.region}"
}

terraform {
  backend "s3" {}
}


module "redis" {
  source         = "../../modules/redis"
  env            = "${data.terraform_remote_state.vpc.environment_level}"
  name           = "redis"
  redis_clusters = "2"
  redis_failover = "true"
  subnets        = ["${data.terraform_remote_state.vpc.elasticache_subnets}"]
  vpc_id         = "${data.terraform_remote_state.vpc.vpc_id}"
  allowed_cidr   = ["${data.terraform_remote_state.vpc.cidr}"]
}