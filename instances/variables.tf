
variable "region" {
  default = "us-west-2"
}
variable "key_name" {}
variable "instance_type" {
  default = "t2.micro"
}

variable "amis" {
  default = {
    us-east-1 = "ami-60b6c60a"
    us-west-2 = "ami-d874e0a0"
  }
}

variable "public_subnet_id" {}
variable "bastion_ssh_sg_id" {}
variable "private_subnet_id" {}
variable "ssh_from_bastion_sg_id" {}
variable "web_nat" {}
