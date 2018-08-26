resource "aws_db_instance" "instance01" {
  identifier                 = "${var.identifier}"
  final_snapshot_identifier  = "${var.identifier}-final-snapshot"
  skip_final_snapshot        = false

  apply_immediately          = "${var.apply_immediately}"

  backup_retention_period    = "${var.backup_retention_period}"
  backup_window              = "${var.backup_window}"
  maintenance_window         = "${var.maintenance_window}"

  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"

  allocated_storage          = "${var.allocated_storage}"
  storage_type               = "${var.storage_type}"

  multi_az                   = "${var.multi_az}"

  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"

  instance_class             = "${var.instance_class}"

  #credentials of default user and default db name
  name                       = "${var.name}"
  username                   = "${var.username}"
  password                   = "${var.password}"

  parameter_group_name       = "${var.parameter_group_name}"
  option_group_name          = "${var.option_group_name}"

  storage_encrypted          = "${var.storage_encrypted}"

  db_subnet_group_name       = "${var.db_subnet_group_name}"
  vpc_security_group_ids     = ["${var.vpc_security_group_ids}"]
}

resource "aws_db_event_subscription" "sub01" {
  count            = "${var.enable_event_notifications}"
  name             = "${aws_db_instance.instance01.id}-notifications"
  source_ids       = ["${aws_db_instance.instance01.id}"]

  sns_topic        = "${var.topic_arn}"

  source_type      = "db-instance"
  event_categories = [
    "availability",
    "configuration change",
    "failover",
    "failure",
    "maintenance",
    "read replica",
    "recovery",
    "low storage"
  ]
}
