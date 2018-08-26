terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state = {
    backend = "s3"

    config {
      encrypt        = false
      bucket         = "terraform-state-devops-test"
      key            = "test/ecs_test.tfstate"
      region         = "us-west-2"
      dynamodb_table = "terragrunt-test-locks-table"
    }
  }
}


vpc_cidr = "10.0.0.0/16"

environment = "ecs-test"

public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]

private_subnet_cidrs = ["10.0.50.0/24", "10.0.51.0/24"]

availability_zones = ["us-west-2a", "us-west-2b"]

max_size = 1

min_size = 1

desired_capacity = 1

instance_type = "t2.micro"

ecs_aws_ami = "ami-95f8d2f3"

key_name    = "devops-test"