
resource "aws_security_group" "private" {
  name = "private_sg"
  description = "Restrict inbound traffic"
    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = "${aws_security_group.private.id}"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "terraform_private_sg"
      tier = "private"
  }
}
output "private_sg_id" {
  value = "${aws_security_group.private.id}"
}