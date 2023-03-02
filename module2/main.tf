resource "aws_instance" "ec2" {
  ami           = "${data.aws_ami.packer_image.id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  tags = {
    Name = "${var.stack}"
  }
}


data "aws_ami" "packer_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Goldenami-v2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
