# These are all pass through variables to the aws_instance resource.  See the
# hashicorp documentation for their meanings.  Note that anything without a
# default is required.

variable "ami"                                  { }
variable "availability_zone"                    { default = "" }
variable "placement_group"                      { default = "" }
variable "tenancy"                              { default = "" }
variable "ebs_optimized"                        { default = "" }
variable "disable_api_termination"              { default = "" }
variable "instance_initiated_shutdown_behavior" { default = "" }
variable "instance_type"                        { }
variable "key_name"                             { default = "" }
variable "monitoring"                           { default = true }
variable "vpc_security_group_ids"               { default = "" }
variable "associate_public_ip_address"          { default = "" }
variable "private_ip"                           { default = "" }
variable "source_dest_check"                    { default = "" }
variable "iam_instance_profile"                 { default = "" }
variable "user_data"                            { default = "" }
variable "tags"                                 { default = "" }

# Variables from make
variable "account"                              { }
variable "environment"                          { }

# block devices.
# we'll only setup the root device.  Other devices should be attached outside
# of this module.
variable "rbd_volume_type"                      { default = "gp2" }
variable "rbd_volume_size"                      { default = 20 }
variable "rbd_iops"                             { default = 0 }
variable "rbd_delete_on_termination"            { default = true }

## these are ordered indexes of the subnet tags and ids, so one can look up
## the id based on the tag.  Eliminates hard coding the ids.
variable "subnet_tag_name" { }
variable "subnet_tag_list" { }
variable "subnet_id_list"  { }
module "subnet_id" {
  source = "../get_val_from_key"
  key_list = "${var.subnet_tag_list}"
  val_list = "${var.subnet_id_list}"
  keys     = "${var.subnet_tag_name}"
}

# tags (all are required)
variable "tag_Layer"                 { }
variable "tag_Terraform"             { }
variable "tag_Owner"                 { }

variable "hostname" {
  description = "used in setting up the dns"
}
variable "domain" {
  description = "used to set hostname on machine via user-data (see below)"
}

## Route53 Zones - these are ordered indexes of the Route53 zones tags and ids,
## so one can look up the id based on the tag.  Eliminates hard coding the ids.
variable "zone_tag_name" { }
variable "zone_tag_list" { }
variable "zone_id_list"  { }
module "zone_id" {
  source = "../get_val_from_key"
  key_list = "${var.zone_tag_list}"
  val_list = "${var.zone_id_list}"
  keys     = "${var.zone_tag_name}"
}


# Alarms

variable "high_cpu_threshold"           { default = "80" }
variable "high_cpu_period"              { default = "120" }
variable "high_cpu_evaluation_periods"  { default = "5" }
variable "high_disk_threshold"          { default = "85" }
variable "high_disk_period"             { default = "60" }
variable "high_disk_evaluation_periods" { default = "15" }

variable "sns_alarm_topic_arn"          { }
variable "sns_ok_topic_arn"             { }

