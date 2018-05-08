#### Base variables ######

variable "identifier"                 {}

variable "backup_retention_period"    { default = 0 }
variable "backup_window"              { default = "03:00-06:00" }
variable "maintenance_window"         { default = "sat:06:00-sat:14:00" }

variable "apply_immediately"          { default = false }

variable "auto_minor_version_upgrade" { default = false }

variable "allocated_storage"          {}
variable "storage_type"               { default = "gp2" }

variable "multi_az"                   { default = false }

variable "engine"                     {}
variable "engine_version"             {}

variable "instance_class"             {}

variable "name"                       { default = "" }
variable "username"                   {}
variable "password"                   {}

variable "parameter_group_name"       { default = "" }
variable "option_group_name"          { default = "" }

variable "storage_encrypted"          { default = true }

variable "db_subnet_group_name"       {}
variable "vpc_security_group_ids"     {}

variable "enable_event_notifications" { default = 0 }
variable "topic_arn"                  { default = "" }
