provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {}
}

module "cloudtrail" {
  source                        = "terraform-aws-cloudtrail/"
  namespace                     = "cp"
  stage                         = "dev"
  name                          = "cluster"
  enable_log_file_validation    = "true"
  include_global_service_events = "true"
  is_multi_region_trail         = "false"
  enable_logging                = "true"
  s3_bucket_name                = "${module.cloudtrail_s3_bucket.bucket_id}"
}

module "cloudtrail_s3_bucket" {
  source    = "terraform-aws-cloudtrail-s3-bucket/"
  namespace = "cp"
  stage     = "dev"
  name      = "cluster"
  region    = "us-east-1"
  force_destroy = "true"
}