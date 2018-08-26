# Alarms

variable "hostname"                     { }
variable "environment"                  { }
variable "high_cpu_threshold"           { default = "80" }
variable "high_cpu_period"              { default = "120" }
variable "high_cpu_evaluation_periods"  { default = "5" }
variable "high_disk_threshold"          { default = "85" }
variable "high_disk_period"             { default = "60" }
variable "high_disk_evaluation_periods" { default = "15" }
variable "sns_alarm_topic_arn"          { }
variable "sns_ok_topic_arn"             { }