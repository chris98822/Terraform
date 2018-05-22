terraform {
  backend "s3" {}
}
resource "aws_security_group" "self_reference" {
  vpc_id                = "${data.terraform_remote_state.vpc.vpc_id}"


##############
#Add Name Here
##############
  name                  = "self_reference"

    tags = {
        owner           = "${data.terraform_remote_state.vpc.owner}"
        account         = "${data.terraform_remote_state.vpc.aws_account_name}"
        product         = "${data.terraform_remote_state.vpc.product_brand}"
        environment     = "${data.terraform_remote_state.vpc.environment_level}"
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
