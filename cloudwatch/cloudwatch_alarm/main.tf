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