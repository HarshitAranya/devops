#SSH from putty by using ppk | ssh-keygen -t rsa
resource "aws_key_pair" "KeyToConnect" {
  key_name = "KeyToConnect" #name should be there in txt file
  public_key = file("${var.pubkeypath}") #var.pubkeypath #file("pubkeyforsshputty.txt") not defigned in variable. it will be pars at the time of execution
}

# Fetch the latest AMI ID based on a filter, such as the latest Ubuntu image
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["${var.owners}"]  # AWS Account ID for Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu-20.04-*"]  # Filter based on the AMI name pattern
  }
}

# create vms
resource "aws_instance" "ubuntu20" {
  ami                         = data.aws_ami.latest_ubuntu.id  # Dynamically fetched AMI ID #"ami-0cea098ed2ac54925"
  count                       = 1
  key_name                    = aws_key_pair.KeyToConnect.key_name #name should be there in txt file

  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.SG_VPCIP8000N8.id}"] #should be already created
  subnet_id                   = aws_subnet.SUB-1-VPCIP8000N8.id
  # security_groups             = ["default"]
  associate_public_ip_address = true
  tags = {
    Name = var.ubuntu20_name
  }
  
  user_data = <<-EOF
            #!/bin/bash
            hostnamectl set-hostname ${var.ubuntu20_name}
            mkdir -p /root/.ssh
            echo "${var.sshpubkey}" >> /root/.ssh/authorized_keys
            chmod 600 /root/.ssh/authorized_keys
            chown root:root /root/.ssh /root/.ssh/authorized_keys
          EOF
}