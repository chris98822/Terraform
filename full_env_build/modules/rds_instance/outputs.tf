output "address" {
  value = "${aws_db_instance.instance01.address}"
}

output "endpoint" {
  value = "${aws_db_instance.instance01.endpoint}"
}
