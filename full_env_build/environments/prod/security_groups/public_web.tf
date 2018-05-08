
resource "aws_security_group" "public_web" {
  name = "public_web_sg"
  description = "Allow HTTP/S from Anywhere. Allow SSH internally"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.ip_range}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "terraform_demo_webapp_http_inbound"
      tier = "public"
  }
}
output "public_web_sg_id" {
  value = "${aws_security_group.public_web.id}"
}