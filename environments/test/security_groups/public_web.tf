
resource "aws_security_group" "public_sg" {
  vpc_id                = "${module.vpc.vpc_id}"


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
    cidr_blocks         = ["${module.vpc.cidr}"]
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


