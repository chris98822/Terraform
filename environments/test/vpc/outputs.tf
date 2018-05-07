# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

#CIDR
output "cidr" {
  description = "cide block for VPC"
  value       = "${module.vpc.cidr}"
}
# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "azs" {
  value = ["${module.vpc.azs}"]

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

output "default_ami" {
  value       = "${var.default_ami}"
}