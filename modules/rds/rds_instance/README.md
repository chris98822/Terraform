This module allows easy creation of an RDS instance with sane defaults.  This can not be used for an aurora cluster.

---

**REQUIRED VARIABLES:**

| variable               | description                                                                                    |
| ---                    | ---                                                                                            |
| identifier             | This is the name which will be used for the RDS instance                                       |
| instance_class         | The instance type to use                                                                       |
| allocated storage      | Storage to be allocated (GB)                                                                   |
| engine                 | The database engine to use                                                                     |
| engine_version         | The version of the database engine to use                                                      |
| username               | The username for the "master" user created by RDS (Your app probably should not use this user) |
| password               | The password for the above user                                                                |
| db_subnet_group_name   | RDS subnet group to place this instance in                                                     |
| vpc_security_group_ids | List of security groups to apply to this instance                                              |

**OPTIONAL VARIABLES:**

| variable                   | description                                                           | default               |
| ---                        | ---                                                                   | ---                   |
| backup_retention_period    | Number of days to keep automatic backups (0 disables)                 | 0                     |
| backup_window              | Time automatic backups are created                                    | 03:00 - 06:00         |
| maintenance_window         | Time automatic or forced updates are applied                          | sat:06:00 - sat:14:00 |
| apply_immediately          | If updates are applied immediately or wait for the maintenance window | false                 |
| auto_minor_version_upgrade | If upgrades are applied automatically at the next maintenance window  | false                 |
| storage type               | Type of storage to use                                                | gp2                   |
| multi_az                   | Create a replicated instance in another AZ                            | false                 |
| name                       | Create a default database with this name                              | ""                    |
| parameter_group_name       | Parameter group to apply to this instance                             | ""                    |
| option_group_name          | Option group to apply to this instance                                | ""                    |
| storage_encrypted          | Enable storage encryption                                             | true                  |
| enable_event_notifications | Create an RDS event subscription for the database                     | false                 |
| topic_arn                  | SNS topic to send event notifications to                              | ""                    |

---

This module is also capable of sending RDS event notifications to an SNS topic.  To avoid creating topics for every instance, topics for each database engine will be created in environments/shared/database_sns.  If you use this functionality, make sure a topic has been created by terraform for the database engine in use before you create the RDS instance.  
