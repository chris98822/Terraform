#place holder
provider "aws" {
  region = "us-west-2"
}

module "ec2" {
  source = "../../../../modules/single_ec2/"

################
# Set Perameters
################
  name                        = "example"
  associate_public_ip_address = "false"
  instance_type               = "t2.micro"
  
  root_block_device = [
    {
      volume_size             = "15"
      volume_type             = "gp2"
    },
  ]
  
  ebs_block_device = [
    {
      device_name             = "/dev/xvdz"
      volume_size             = "15"
      volume_type             = "gp2"
      delete_on_termination   = true
    },
  ]


####################################
# Variables set in Variables.tf File
####################################
  ami                         = "ami-07eb707f" #Amazon Linux 2
  subnet_id                   = "${module.vpc.public_subnets[0]}" #pick 0-2 for subnet azs
  vpc_security_group_ids      = ["${module.security_groups.private_sg}"]

  ########
  # Tags
  ########
  tags = {
    owner           = "${module.vpc.owner}"
    account         = "${module.vpc.aws_account_name}"
    product         = "${module.vpc.product_brand}"
    environment     = "${module.vpc.environment_level}"
    creator         = "terraform"
    resource        = "single_ec2"
  }

}