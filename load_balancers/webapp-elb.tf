
data "aws_subnet_ids" "public" {
	vpc_id = "${var.vpc_id}"
	tags {
		tier = "public"
	}
}
resource "aws_elb" "webapp_elb" {
  name = "demo-webapp-elb"
  subnets = ["${data.aws_subnet_ids.public.ids}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 1
    timeout = 3
    target = "HTTP:80/"
    interval = 10
  }
  security_groups = ["${var.webapp_http_inbound_sg_id}"]
  tags {
      Name = "terraform_elb"
  }
}
output "webapp_elb_name" {
  value = "${aws_elb.webapp_elb.name}"
}
