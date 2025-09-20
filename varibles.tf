# Private IPs for VMs
variable "vm1_private_ip" {
  type        = string
  description = "Private IP for VM1"
  default     = "10.5.0.10"
}

variable "vm2_private_ip" {
  type        = string
  description = "Private IP for VM2"
  default     = "10.15.0.10"
}


