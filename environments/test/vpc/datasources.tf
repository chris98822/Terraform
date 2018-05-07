
#Default AMI to use is Amazon Linux 2
#Change this under the specific resource for something different
data "aws_ami" "amazon_linux2" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}