module "public_sg" {
  source = "../../../modules/security_group/"

  account_name          = "${var.account}"
  account_long          = "${var.product}"
  environment           = "${var.environment}"
  vpc_id                = "${var.env_vpc_id}"


##############
#Add Name and Description Here
##############
  sg_name               = "public"
  Description           = "Allow HTTP/S from Anywhere. Allow SSH internally"

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


  tags                  = "${merge(var.primary_tags, var.additional_tags)}"
}

output "${module.public_sg.sg_name}_id" {
  value = "${aws_security_group.public_sg.id}"
}
