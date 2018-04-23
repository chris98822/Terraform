
/*
#Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_ip" {
  vpc = true
  #depends_on = ["site.aws_internet_gateway.default"]
}

 resource "aws_nat_gateway" "private_subnet_instance" {
  allocation_id = "${aws_eip.nat_ip.id}"
  subnet_id     = "${var.private_subnet_id}"
  vpc_security_group_ids = [
     "${var.ssh_from_bastion_sg_id}",
    "${var.web_nat}"
    ]
  key_name = "${var.key_name}"
 tags {
   Name = "terraform_demo_private_subnet"
 }
}
*/

resource "aws_instance" "private_subnet_instance" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "terraform_demo_private_subnet"
  }
  subnet_id = "${var.private_subnet_id}"
  vpc_security_group_ids = [
    "${var.ssh_from_bastion_sg_id}",
    "${var.web_nat}"
    ]
  key_name = "${var.key_name}"
}
