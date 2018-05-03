resource "aws_security_group" "vpn_sg" {
  name = "vpn_sg"
  description = "Security Group Only for VPN Gateway"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "terraform_vpn_sg"
      tier = "private"
  }
}
output "vpn_sg_id" {
  value = "${aws_security_group.vpn_sg.id}"
}