# terraform-aws-cloudtrail 

Terraform module to provision an AWS [CloudTrail](https://aws.amazon.com/cloudtrail/).

The module accepts an encrypted S3 bucket with versioning to store CloudTrail logs.

The bucket could be from the same AWS account or from a different account.

This is useful if an organization uses a number of separate AWS accounts to isolate the Audit environment from other environments (production, staging, development).

In this case, you create CloudTrail in the production environment (production AWS account), 
while the S3 bucket to store the CloudTrail logs is created in the Audit AWS account, restricting access to the logs only to the users/groups from the Audit account.


## Usage

```hcl
module "cloudtrail" {
  source                        = "git::https://github.com/cloudposse/terraform-aws-cloudtrail.git?ref=master"
  namespace                     = "cp"
  stage                         = "dev"
  name                          = "cluster"
  enable_log_file_validation    = "true"
  include_global_service_events = "true"
  is_multi_region_trail         = "false"
  enable_logging                = "true"
  s3_bucket_name                = "my-cloudtrail-logs-bucket"
}
```


For a complete example, see [examples/complete](examples/complete).


## Variables

|  Name                            |  Default             |  Description                                                                                       | Required |
|:---------------------------------|:--------------------:|:---------------------------------------------------------------------------------------------------|:--------:|
| `namespace`                      | ``                   | Namespace (e.g. `cp` or `cloudposse`)                                                              | Yes      |
| `stage`                          | ``                   | Stage (e.g. `prod`, `dev`, `staging`)                                                              | Yes      |
| `name`                           | ``                   | Name  (e.g. `cluster` or `app`)                                                                    | Yes      |
| `attributes`                     | `[]`                 | Additional attributes (e.g. `logs`)                                                                | No       |
| `tags`                           | `{}`                 | Additional tags  (e.g. `map("BusinessUnit","XYZ")`                                                 | No       |
| `delimiter`                      | `-`                  | Delimiter to be used between `namespace`, `stage`, `name` and `attributes`                         | No       |
| `enable_log_file_validation`     | `true`               | Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs    | No       |
| `include_global_service_events`  | `false`              | Specifies whether the trail is publishing events from global services such as IAM to the log files | No       |
| `is_multi_region_trail`          | `false`              | Specifies whether the trail is created in the current region or in all regions                     | No       |
| `enable_logging`                 | `true`               | Enable logging for the trail. Logs will be stored in the S3 bucket                                 | No       |
| `s3_bucket_name`                 | ``                   | S3 bucket name for CloudTrail logs                                                                 | Yes (if `enable_logging`=`true`)  |


## Outputs

| Name                      | Description                                  |
|:--------------------------|:---------------------------------------------|
| `cloudtrail_id`           | The name of the trail                        |
| `cloudtrail_home_region`  | The region in which the trail was created    |
| `cloudtrail_arn`          | The Amazon Resource Name of the trail        |
