

resource "aws_security_group" "private_sg" {
  vpc_id                = "${module.vpc.vpc_id}"


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
    cidr_blocks   = ["${module.vpc.cidr}"]
  }
  egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }


  tags = {
    owner           = "${module.vpc.owner}"
    account         = "${module.vpc.aws_account_name}"
    product         = "${module.vpc.product_brand}"
    environment     = "${module.vpc.environment_level}"
    creator         = "terraform"
    resource        = "security_group"
  }
}

