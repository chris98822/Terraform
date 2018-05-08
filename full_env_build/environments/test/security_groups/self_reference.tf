resource "aws_security_group" "self_reference" {
  vpc_id                = "${module.vpc.vpc_id}"


##############
#Add Name Here
##############
  name                  = "self_reference"

    tags = {
        owner           = "${module.vpc.owner}"
        account         = "${module.vpc.aws_account_name}"
        product         = "${module.vpc.product_brand}"
        environment     = "${module.vpc.environment_level}"
        creator         = "terraform"
        resource        = "security_group"
    }
}

resource "aws_security_group_rule" "self_reference_rule" {
###################
# Rules Here
###################
    type                = "ingress"
    from_port           = "22"
    to_port             = "22"
    protocol            = "tcp"
    security_group_id   = "${aws_security_group.self_reference.id}"

    type                = "egress"
    from_port           = "0"
    to_port             = "0"
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]

}
