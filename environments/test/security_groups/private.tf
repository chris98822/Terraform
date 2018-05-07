module "private_sg" {
  source = "../../../modules/security_group/"

  account_name          = "${var.account}"
  account_long          = "${var.product}"
  environment           = "${var.environment}"
  vpc_id                = "${var.env_vpc_id}"


##############
#Add Name Here
##############
  sg_name               = "private"


###################
# Rules Here
###################
  ingress {
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    security_group_id   = "${output.private_sg_id.id}"
  }
  egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }


  tags                  = "${merge(var.primary_tags, var.additional_tags)}"
}

output "${module.private_sg.sg_name}_id" {
  value = "${aws_security_group.private_sg.id}"
}