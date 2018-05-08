variable "region" {
   default = "us-west-2"
}

#Add more tags to VPC here.
variable "additional_tags" {
    default = {
        additional = "test"
    }
}

#Static tag structure, used across all VPCs and Accounts. Use additional_tags above to add others.
variable "primary_tags" {
    default = {
        account = "devops"
        product = "testing"
        environment = "test"
        creator = "terraform"
    }
}