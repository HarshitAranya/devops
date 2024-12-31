variable "pubkeypath" {
	description = "Public key path from local"
  type = string
  default = ""
}

variable "sshpubkey" {
  description = "The SSH public key"
  type        = string
  default = ""
}

variable "owners" {
	description = "AWS Account ID for Canonical (Ubuntu)"
  type = string
  default = ""
}

variable "ubuntu20_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = ""  # Default value can be provided, or you can pass it at runtime
}

