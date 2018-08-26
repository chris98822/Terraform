
resource "aws_route53_zone" "remax_com" {
  name    = "${var.name}"
  comment = "${var.comment} - Managed by Terraform"
  vpc_id  = "${module.vpc.vpc_id}"
  tags {
    BusinessUnit          = "${var.account}"
    Environment           = "${var.environment}"
    Terraform             = "${var.terraform}"
    Owner                 = "${var.owner}"
  }
}

##### MX records

resource "aws_route53_record" "mx" {
  zone_id = "${aws_route53_zone.remax_com.zone_id}"
  name = "${var.name}"
  type = "MX"
  ttl = "${var.ttl}"
  records = ["smtp-inbound-1.example.com", "smtp-inbound-2.example.com"]
}

##### TXT records



##### A records

resource "aws_route53_record" "root" {
  zone_id = "${aws_route53_zone.remax_com.zone_id}"
  name = "${var.name}"
  type = "A"
  ttl = "${var.ttl}"
  records = ["172.0.0.1"]
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.remax_com.zone_id}"
  name = "www"
  type = "A"
  ttl = "${var.ttl}"
  records = ["172.0.0.1"]
}

resource "aws_route53_record" "example" {
  zone_id = "${aws_route53_zone.remax_com.zone_id}"
  name = "example"
  type = "A"
  ttl = "${var.ttl}"
  records = ["10.100.100.100"]
}

##### CNAME records

resource "aws_route53_record" "examplecname" {
  zone_id = "${aws_route53_zone.remax_com.zone_id}"
  name = "examplecname"
  type = "CNAME"
  ttl = "${var.ttl}"
  records = ["examplecname.example.com."]
}