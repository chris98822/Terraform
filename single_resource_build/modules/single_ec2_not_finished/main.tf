resource "template_file" "user_data" {
  template = <<EOF
#!/bin/bash
yum update
yum upgrade
yum -y install perl-DateTime perl-Sys-Syslog openssl openssl-devel cpan unzip wget nano

${user_data}
  EOF

  vars {
    hostname        = "${var.hostname}"
    fqdn            = "${var.hostname}.${var.domain}"
    user_data       = "${var.user_data}"
    account         = "${var.account}"
    environment     = "${var.environment}"
  }
}

resource "aws_instance" "single" {
  ami                                  = "${var.ami}"
  availability_zone                    = "${var.availability_zone}"
  placement_group                      = "${var.placement_group}"
  tenancy                              = "${var.tenancy}"
  ebs_optimized                        = "${var.ebs_optimized}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  instance_type                        = "${var.instance_type}"
  key_name                             = "${var.key_name}"
  monitoring                           = "${var.monitoring}"
  vpc_security_group_ids               = ["${split(",", var.vpc_security_group_ids)}"]
  ## subnet_id pulled from get_val_from_key module above
  subnet_id                            = "${module.subnet_id.value}"
  associate_public_ip_address          = "${var.associate_public_ip_address}"
  private_ip                           = "${var.private_ip}"
  source_dest_check                    = "${var.source_dest_check}"
  user_data                            = "${template_file.user_data.rendered}"
  iam_instance_profile                 = "${var.iam_instance_profile}"

  root_block_device {
    volume_type           = "${var.rbd_volume_type}"
    volume_size           = "${var.rbd_volume_size}"
    iops                  = "${var.rbd_iops}"
    delete_on_termination = "${var.rbd_delete_on_termination}"
  }

  tags {
    Name         = "${var.hostname}.${var.environment}"
    BusinessUnit = "${var.account}"
    Environment  = "${var.environment}"
    Layer        = "${var.tag_Layer}"
    Terraform    = "${var.tag_Terraform}"
    Owner        = "${var.tag_Owner}"
  }

}

resource "aws_route53_record" "single" {
  zone_id = "${module.zone_id.value}"
  name = "${var.hostname}"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.single.private_ip}"]
}


resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "${var.hostname}.${var.environment}-high-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  namespace           = "AWS/EC2"
  threshold           = "${var.high_cpu_threshold}"
  period              = "${var.high_cpu_period}"
  evaluation_periods  = "${var.high_cpu_evaluation_periods}"
  alarm_description   = "Alarm for high cpu utilization"
  alarm_actions       = ["${split(",", var.sns_alarm_topic_arn)}"]
  ok_actions          = ["${split(",", var.sns_ok_topic_arn)}"]
  dimensions {
    InstanceId        = "${aws_instance.single.id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "high_disk_alarm" {
  alarm_name          = "${var.hostname}.${var.environment}-high-disk-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "DiskSpaceUtilization"
  statistic           = "Average"
  namespace           = "System/Linux"
  threshold           = "${var.high_disk_threshold}"
  period              = "${var.high_disk_period}"
  evaluation_periods  = "${var.high_disk_evaluation_periods}"
  alarm_description   = "Alarm for high disk utilization"
  alarm_actions       = ["${split(",", var.sns_alarm_topic_arn)}"]
  ok_actions          = ["${split(",", var.sns_ok_topic_arn)}"]
  dimensions {
    InstanceId        = "${aws_instance.single.id}"
    MountPath         = "/"
    Filesystem        = "/dev/xvda1"
  }
}

