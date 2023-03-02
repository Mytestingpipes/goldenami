

###################### THIS IS FOR AWS GOLDENAMI ############################
###################### CREATED BY SATISH KORRA   ############################


#data "amazon-ami" "baseami" {
  #filters = {
    #virtualization-type = "hvm"
    #name                = "packerbaseami"
    #root-device-type    = "ebs"
  #}
  #owners      = ["363638483937"]
  #most_recent = true
  #region      = "us-east-1"
#}


############ INFRA ###################

source "amazon-ebs" "aws" {
  ami_name      = "Goldenami-v2"
  instance_type = "t2.micro"
  region        = "us-east-1"
  run_tags = {
    Name = "Goldenami-v2"
  }
  source_ami   = "ami-0aa7d40eeae50c9a9"
  ssh_username = "ec2-user"
  subnet_id    = "subnet-0b8f9a7b97fd1edf0"
  iam_instance_profile =  "ssm"
  ssh_interface        = "session_manager"
  communicator         = "ssh"
  tags = {
    Base_AMI_Name = "Goldenami-v2"
  }
}

################## PACKAGE INSTALLATIONS #####################
build {
  sources = ["source.amazon-ebs.aws"]

    provisioner "shell" {
    scripts = ["./Inspector_Agent_Install.sh"]
  }
  
    provisioner "shell" {
    inline = ["sudo mkdir rapid7", "sudo cd rapid7","sudo wget https://r7-sat.s3.amazonaws.com/linux_insight_agent/agent_installer-x86_64.sh","sudo wget https://r7-sat.s3.amazonaws.com/linux_insight_agent/agent_installer-x86_64.sh","sudo wget https://r7-sat.s3.amazonaws.com/linux_insight_agent/cafile.pem","sudo wget https://r7-sat.s3.amazonaws.com/linux_insight_agent/client.crt","sudo wget https://r7-sat.s3.amazonaws.com/linux_insight_agent/client.key","sudo wget https://r7-sat.s3.amazonaws.com/linux_insight_agent/config.json","sudo chmod u+x agent_installer-x86_64.sh","sudo ./agent_installer-x86_64.sh install_start"]
  }
  

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
