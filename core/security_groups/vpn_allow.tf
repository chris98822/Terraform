resource "aws_security_group" "vpn_allow" {
  name = "vpn_allow"
  description = "Allow Traffic In From VPN"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.vpn_sg.id}"
  }
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "terraform_vpn_allow"
      tier = "private"
  }
}
output "vpn_sg_id" {
  value = "${aws_security_group.vpn_allow.id}"
}