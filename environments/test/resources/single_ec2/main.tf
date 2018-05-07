#place holder
provider "aws" {
  region = "us-west-2"
}

module "ec2" {
  source = "../../../modules/single_ec2/"

################
# Set Perameters
################
  count                       = "1"
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
  ami                         = "${var.ami}"
  subnet_id                   = "${var.private_subnets[0]}" #pick 0-2 for subnet azs
  vpc_security_group_ids      = "${var.private_sg}"
  tags                        = "${merge(var.primary_tags, var.additional_tags)}"

}