terraform {
  backend "s3" {}
}

resource "aws_security_group" "public_sg" {
  vpc_id                = "${data.terraform_remote_state.vpc.vpc_id}"


##############
#Add Name and Description Here
##############
  name               = "public"

###################
# Rules Here
###################
  ingress {
    from_port           = 80
    to_port             = 80
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }
  ingress {
    from_port           = 443
    to_port             = 443
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }
  ingress {
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    cidr_blocks         = ["${data.terraform_remote_state.vpc.cidr}"]
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


