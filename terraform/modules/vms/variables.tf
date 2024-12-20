variable "pubkeypath" {
	description = "Public key path from local"
  type = string
  default = ""
}

variable "sshpubkey" {
  description = "The SSH public key"
  type        = string
}

variable "owners" {
	description = "AWS Account ID for Canonical (Ubuntu)"
  type = string
  default = ""
}

variable "slave_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "JenSlave"  # Default value can be provided, or you can pass it at runtime
}

variable "master_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "JenMaster"  # Default value can be provided, or you can pass it at runtime
}

