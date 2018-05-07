###
#Create Auto Scaling Group with Amazon Linux 2 behind an ELB
###

provider "aws" {
  region = "us-west-2"

  /*# Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
<<<<<<< HEAD:environments/prod/resources/crm_app_asg_dev/main.tf
  skip_requesting_account_id  = true
*/
=======
  skip_requesting_account_id  = true*/
>>>>>>> 85b8e943e1112b9d730f015b8b31031e87d0fb1d:environments/test/crm_app_asg_dev/main.tf
}

##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_security_group" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
  name   = "default"
}

#find Amazon Linux 2 LTS
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

######
# Launch configuration and autoscaling group
######
module "example_asg" {
  source = "../../../modules/asg/"

  name = "example-with-elb"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name = "example-lc"

  image_id        = "${data.aws_ami.amazon_linux.id}"
  instance_type   = "t2.micro"
  security_groups = ["${data.aws_security_group.default.id}"]
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
  vpc_zone_identifier       = ["${data.aws_subnet_ids.all.ids}"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]
}

######
# ELB
######
module "elb" {
  source = "../../../modules/elb/"

  name = "elb-example"

  subnets         = ["${data.aws_subnet_ids.all.ids}"]
  security_groups = ["${data.aws_security_group.default.id}"]
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

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
