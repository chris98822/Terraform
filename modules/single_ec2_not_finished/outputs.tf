# outputs.  This will output all the same attibutes as the aws_instance
# resource
output "id" {
  value = "${aws_instance.single.id}"
}
output "availability_zone" {
  value = "${aws_instance.single.availability_zone}"
}
output "placement_group" {
  value = "${aws_instance.single.placement_group}"
}
output "key_name" {
  value = "${aws_instance.single.key_name}"
}
output "public_dns" {
  value = "${aws_instance.single.public_dns}"
}
output "public_ip" {
  value = "${aws_instance.single.public_ip}"
}
output "private_dns" {
  value = "${aws_instance.single.private_dns}"
}
output "private_ip" {
  value = "${aws_instance.single.private_ip}"
}
output "security_groups" {
  value = "${aws_instance.single.security_groups}"
}
output "vpc_security_group_ids" {
  value = "${aws_instance.single.vpc_security_group_ids}"
}
output "subnet_id" {
  value = "${aws_instance.single.subnet_id}"
}
