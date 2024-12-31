# configure AWS provider
provider "aws" {
    region = var.region
    profile = "local aws cli profile name"  
}

module "vms" {
  source = "../modules/vms"
}

output "instance_public_ip" {
  description = "This will provide public ip of created instances"
  value = aws_instance[var.ubuntu20_name][0].public_ip
}

output "instance_dns_id" {
  description = "This will provide public ip of created instances"
  # value = "${aws_instance.JenMaster[0].public_dns} - ${aws_instance.JenMaster[0].id}"
  value = "${aws_instance[var.ubuntu20_name][0].public_dns} - ${aws_instance[var.ubuntu20_name][0].id}"
}

