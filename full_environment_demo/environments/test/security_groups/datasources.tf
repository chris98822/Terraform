data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "terraform-state-devops-test"
    key    = "test/vpc.tfstate"
    region = "us-west-2"
  }
}