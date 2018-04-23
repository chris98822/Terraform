
variable "ip_range" {
  default = "10.30.0.0/16" 
}
variable "availability_zones" {
  
  default = ["us-west-2a","us-west-2b","us-west-2c"]
}
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "10.30.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = "10.30.0.0/24"
}
variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.30.1.0/24"
}
variable "key_name" {}
