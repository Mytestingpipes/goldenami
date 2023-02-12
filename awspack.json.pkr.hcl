
############ INFRA ###################

source "amazon-ebs" "aws" {
  ami_name      = "Goldenami-v1"
  instance_type = "${var.instance_type}"
  region        = "${var.region}"
  run_tags = {
    Name = "Goldenami-v1"
  }
  source_ami   = "${var.source_ami}"
  ssh_username = "ec2-user"
  subnet_id    = "${var.subnet_id}"
  iam_instance_profile =  "ssm"
  ssh_interface        = "${var.ssh_interface}"
  communicator         = "ssh"
  tags = {
    Base_AMI_Name = "Goldenami-v1"
  }
}

################## PACKAGE INSTALLATIONS #####################
build {
  sources = ["source.amazon-ebs.aws"]

  #provisioner "shell" {
    #inline = ["sleep 30", "sudo yum update -y"#sudo amazon-linux-extras install ansible2 -y", "sudo yum install git -y", "sudo sed -i.bak -e '/Defaults.*requiretty/s/^/#/' /etc/sudoers","sudo git clone https://github.com/blackbaud/ansible-role-linux-hardening.git /root/roles", "sudo ansible-galaxy install blackbaud.linux-hardening"]
  #}
  

  #provisioner "shell" {
    #inline = ["sudo ansible-playbook ./playbook.yaml -t level-1", "sudo ansible-playbook ./playbook.yaml -t section-3", "sudo ansible-playbook ./playbook.yaml -t 1.3.1,2.2.10", "sudo ansible-playbook ./playbook.yaml -t scored"]
  #}
   provisioner "file"{
    source = "./files"
    destination = "/tmp"
  }
  
  provisioner "shell" {
    scripts = ["./scripts/hardening.sh", "./scripts/install.sh"]
  }
}
