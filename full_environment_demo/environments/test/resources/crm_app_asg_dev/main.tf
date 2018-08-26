terraform {
  backend "s3" {}
}

######
# Launch configuration and autoscaling group
######
module "example_asg" {
  source                        = "../../../../modules/asg/"

  name                          = "example-with-elb"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" Use the existing launch configuration
  # create_lc = false  disables creation of launch configuration


  lc_name                       = "example-lc"
  image_id                      = "ami-07eb707f"
  instance_type                 = "t2.micro"
  security_groups               = ["${data.terraform_remote_state.sg.public_sg}"]
  load_balancers                = ["${module.elb.this_elb_id}"]
  associate_public_ip_address   = false
  user_data                     = "${file("userdata.sh")}"
  key_name                      = "devops-test"

  ebs_block_device = [
    {
      device_name               = "/dev/xvdz"
      volume_type               = "gp2"
      volume_size               = "15"
      delete_on_termination     = true
    },
  ]

  root_block_device = [
    {
      volume_size               = "15"
      volume_type               = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                      = "example-asg"
  vpc_zone_identifier           = "${data.terraform_remote_state.vpc.public_subnets}"
  health_check_type             = "EC2"
  min_size                      = 1
  max_size                      = 3
  desired_capacity              = 2
  wait_for_capacity_timeout     = 0

  tags = {
  owner                         = "${data.terraform_remote_state.vpc.owner}"
  account                       = "${data.terraform_remote_state.vpc.aws_account_name}"
  product                       = "${data.terraform_remote_state.vpc.product_brand}"
  environment                   = "${data.terraform_remote_state.vpc.environment_level}"
  creator                       = "terraform"
  resource                      = "auto_scaling_group"
  }
}

######
# ELB
######
module "elb" {
  source                        = "../../../../modules/elb/"

  name                          = "elb-example"

  subnets                       = "${data.terraform_remote_state.vpc.public_subnets}"
  security_groups               = ["${data.terraform_remote_state.sg.public_sg}"]
  internal                      = false

  listener = [
    {
      instance_port             = "80"
      instance_protocol         = "HTTP"
      lb_port                   = "80"
      lb_protocol               = "HTTP"
    },
  ]

  health_check = [
    {
      target                    = "HTTP:80/"
      interval                  = 30
      healthy_threshold         = 2
      unhealthy_threshold       = 2
      timeout                   = 5
    },
  ]

access_logs = [
  {
    bucket        = "test_elb_log"
    interval      = 60
    enabled       = true
  }
]

 tags = {
  owner                         = "${data.terraform_remote_state.vpc.owner}"
  account                       = "${data.terraform_remote_state.vpc.aws_account_name}"
  product                       = "${data.terraform_remote_state.vpc.product_brand}"
  environment                   = "${data.terraform_remote_state.vpc.environment_level}"
  creator                       = "terraform"
  resource                      = "load_balancer"
 }
}