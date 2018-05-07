provider "aws" {
  region = "us-west-2"

  /*# Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
*/
}


######
# Launch configuration and autoscaling group
######
module "example_asg" {
  source = "../../../modules/asg/"

  name = "example-with-elb"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" Use the existing launch configuration
  # create_lc = false  disables creation of launch configuration

  lc_name = "example-lc"

  image_id        = "${var.ami}"
  instance_type   = "t2.micro"
  security_groups = "${var.public_sg}"
  load_balancers  = ["${module.elb.this_elb_id}"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "15"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "15"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "example-asg"
  vpc_zone_identifier       = "${var.public_subnets}"
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags                        = "${merge(var.asg_primary_tags, var.asg_additional_tags)}"
}

######
# ELB
######
module "elb" {
  source = "../../../modules/elb/"

  name = "elb-example"

  subnets         = "${var.public_subnets}"
  security_groups = "${var.public_sg}"
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = [
    {
      target              = "HTTP:80/"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]

 tags                        = "${merge(var.elb_primary_tags, var.elb_additional_tags)}"
}