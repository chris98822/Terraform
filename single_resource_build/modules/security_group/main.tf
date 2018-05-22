resource "aws_security_group" "sg" {
  name        = "${var.account_long}-${var.environment}-${var.sg_name}-sg"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

}
