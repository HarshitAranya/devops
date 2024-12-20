variable "name" {type = string}

variable "sshpubkey" {
  description = "The SSH public key"
  type        = string
}


variable "region" {
  description = "Region where infrastructure will be created"
  # default = "us-west-2" # this will come from terraform.tfvars
  default = ""
  type = string
}

variable "owners" {
	description = "AWS Account ID for Canonical (Ubuntu)"
  type = string
  default = ""
}


variable "slave_name" {
  description = "The name of the EC2 instance"
  type        = string
  # default     = "JenSlave"  # Default value can be provided, or you can pass it at runtime
}

variable "master_name" {
  description = "The name of the EC2 instance"
  type        = string
  # default     = "JenMaster"  # Default value can be provided, or you can pass it at runtime
}


variable "vpc_cidr" {
	description = "CIDR for my VPC"
  type        = string
	# default     = "172.16.0.0/16"
}

variable "SUB_cidr_block" {
  # default = ["172.16.0.0/19", "172.16.32.0/19", "172.16.64.0/19", "172.16.96.0/19"] #index 0 1 2 3
  type    = list(any)
}

variable "SUB_Tag_Name" {
  # default = ["SUB-1-VPCIP8000N8", "SUB-2-VPCIP8000N8", "SUB-3-VPCIP8000N8", "SUB-4-VPCIP8000N8"] #index 0 1 2 3
  type    = list(any)
}

variable "route_name" {
  type        = string
  # default     = "Route-VPCIP8000N8"
}

variable "ig_name" {
  type        = string
  # default     = "IG_VPCIP8000N8"
}

#list
variable "ICMP-description" {
  # default = ["VPC", "Allow_ICMP_for_All", "IGW"] #index 0 1 2
  type    = list(any)
}

#map
variable "TCP-description" {
  type = map(any)
  default = {
    "TCP-desc"     = "Allow TCP for All"
    "TCP_Out-desc" = "Allow TCP_Out for All"
  }
}
