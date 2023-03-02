variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "source_ami" {
  type    = string
  default = "ami-0aa7d40eeae50c9a9"
}

variable "subnet_id" {
  type    = string
  default = "subnet-0b8f9a7b97fd1edf0"
}

variable "ssh_interface" {
  type    = string
  default = "session_manager"
}
