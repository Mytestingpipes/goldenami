variable "subnet_id" {}
#variable "instance_type" {}
variable "availability_zone" {}
#variable "environment" {}
#variable "ami" {}


variable region {
    description = "AWS Region"
    default = "ap-south-1"
}

variable "stack" {
    description = "Name of the Stack"
    default = "Goldenami-v2"
}

variable "instances" {
     default = 1
     description = "No of instances"
}

variable "instance_type" {
    description = "Size of the VM"
    default = "t2.micro"
}
