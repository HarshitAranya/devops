# configure AWS provider
provider "aws" {
    region = var.region
    profile = "local aws cli profile name"  
}

module "vpc" {
  source = "../modules/vpc"  
}

module "sg" {
  source = "../modules/sg"
}

module "vms" {
  source = "../modules/vpc"
}

output "instance_JenMaster_public_ip" {
  description = "This will provide public ip of created instances"
  value = aws_instance.JenMaster[0].public_ip
}

output "instance_JenMaster_dns_id" {
  description = "This will provide public ip of created instances"
  value = "${aws_instance.JenMaster[0].public_dns} - ${aws_instance.JenMaster[0].id}"
}

output "instance_JenSlave_public_ip" {
  description = "This will provide public ip of created instances"
  value = aws_instance.JenSlave[0].public_ip
}

output "instance_JenSlave_dns_id" {
  description = "This will provide public ip of created instances"
  value = "${aws_instance.JenSlave[0].public_dns} - ${aws_instance.JenSlave[0].id}"
}

