# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}
output "owner" {
  value       = "${var.owner}"
}

output "environment_level" {
  value       = "${var.environment_level}"
}

output "cidr" {
  value       = "${var.vpc_cidr}"
}

output "aws_account_name" {
  value       = "${var.aws_account_name}"
}

output "product_brand" {
  value       = "${var.product_brand}"
}

output "region" {
  value       = "${var.region}"
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc.public_subnets}"]
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = ["${module.vpc.database_subnets}"]
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = ["${module.vpc.elasticache_subnets}"]
}

output "redshift_subnets" {
  description = "List of IDs of redshift subnets"
  value       = ["${module.vpc.redshift_subnets}"]
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = ["${module.vpc.nat_public_ips}"]
}

