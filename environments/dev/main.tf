#Launch all resources in under dev

module "crm_app_asg_dev" {
  source = "crm_app_asg_dev/"
}

module "crm_elb_dev" {
  source = "crm_elb_dev/"
}

module "crm_batch_asg_dev" {
  source = "crm_batch_asg_dev/"
}
