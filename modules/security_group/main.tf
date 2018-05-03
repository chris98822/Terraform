resource "aws_security_group" "sg" {
  name        = "${var.account_long}-${var.environment}-${var.sg_name}-sg"
  description = "${var.account_long} ${var.environment} ${var.sg_name} Security Group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name         = "${var.account_long}-${var.environment}-${var.sg_name}-sg"
    BusinessUnit = "${var.account_long}"
    Environment  = "${var.environment}"
  }
}
