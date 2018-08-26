terraform {
  backend "s3" {}
}

resource "aws_security_group" "private_sg" {
  
  vpc_id                = "${data.terraform_remote_state.vpc.vpc_id}"


##############
#Add Name Here
##############
  name                  = "private_sg"


###################
# Rules Here
###################
  ingress {
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    cidr_blocks   = ["${data.terraform_remote_state.vpc.cidr}"]
  }
  egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }


  tags = {
    owner           = "${data.terraform_remote_state.vpc.owner}"
    account         = "${data.terraform_remote_state.vpc.aws_account_name}"
    product         = "${data.terraform_remote_state.vpc.product_brand}"
    environment     = "${data.terraform_remote_state.vpc.environment_level}"
    creator         = "terraform"
    resource        = "security_group"
  }
}

