# ssh-keygen -t rsa
# Terraform version and provider configuration
terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS provider configuration
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

provider "aws" {
  region = var.region
}

# Create a key pair for SSH access
resource "aws_key_pair" "KeyToConnect" {
  key_name   = "KeyToConnect"
  public_key = file("pubkey.txt")
}

# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the default security group
data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
  vpc_id = data.aws_vpc.default.id
}

# Allow SSH ingress
resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

# Allow all egress traffic
resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

# Create an EC2 instance
resource "aws_instance" "AWSControllerVM" {
  ami                         = "ami-0cea098ed2ac54925"
  count                       = 1
  key_name                    = aws_key_pair.KeyToConnect.key_name
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = ["default"]
  tags = {
    Name = "AWSControllerVM"
  }

  user_data = <<-EOF
              #!/bin/bash
              set -e
              exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
              
              hostnamectl set-hostname 'AWSControllerVM'
              
              sudo yum install -y yum-utils
              sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
              sudo yum update -y
              sudo yum install -y terraform git
              
              # Install AWS CLI version 2
              sudo yum install -y https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
              sudo unzip awscli-exe-linux-x86_64.zip
              sudo ./aws/install

              # Install Ansible
              sudo yum install -y epel-release
              sudo yum install -y ansible
              
              # Clean up
              sudo rm -rf awscli-exe-linux-x86_64.zip aws

            EOF

}

# Output the instance's public IP address
# output "instance_public_ip" {
#   value       = aws_instance.AWSControllerVM.public_ip
#   description = "Public IP address of the EC2 instance"
# }