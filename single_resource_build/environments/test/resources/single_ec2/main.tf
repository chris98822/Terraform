#place holder
terraform {
  backend "s3" {}
}

module "ec2" {
  source = "../../../../modules/single_ec2/"

################
# Set Perameters
################
  name                        = "single_ec2_instance"
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
  subnet_id                   = "${data.terraform_remote_state.vpc.public_subnets[0]}" #pick 0-2 for subnet azs
  vpc_security_group_ids      = ["${data.terraform_remote_state.sg.private_sg}"]

  ########
  # Tags
  ########
  tags = {
    owner           = "${data.terraform_remote_state.vpc.owner}"
    account         = "${data.terraform_remote_state.vpc.aws_account_name}"
    product         = "${data.terraform_remote_state.vpc.product_brand}"
    environment     = "${data.terraform_remote_state.vpc.environment_level}"
    creator         = "terraform"
    resource        = "single_ec2"
  }

}