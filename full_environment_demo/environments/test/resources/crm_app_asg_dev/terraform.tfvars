terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state = {
    backend = "s3"

    config {
      encrypt        = false
      bucket         = "terraform-state-devops-test"
      key            = "test/crm_app_asg.tfstate"
      region         = "us-west-2"
      dynamodb_table = "terragrunt-test-locks-table"
    }
  }
}
