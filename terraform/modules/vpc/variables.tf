
variable "vpc_name" {
  type        = string
  default     = "VPCIP8000N8"
}

variable "vpc_cidr" {
	description = "CIDR for my VPC"
	default     = "172.16.0.0/16"
}

#Subnet Creation
variable "SUB_cidr_block" {
  default = ["172.16.0.0/19", "172.16.32.0/19", "172.16.64.0/19", "172.16.96.0/19"] #index 0 1 2 3
  type    = list(any)
}

variable "SUB_Tag_Name" {
  default = ["SUB-1-VPCIP8000N8", "SUB-2-VPCIP8000N8", "SUB-3-VPCIP8000N8", "SUB-4-VPCIP8000N8"] #index 0 1 2 3
  type    = list(any)
}

variable "route_name" {
  type        = string
  default     = "Route-VPCIP8000N8"
}

variable "ig_name" {
  type        = string
  default     = "IG_VPCIP8000N8"
}


