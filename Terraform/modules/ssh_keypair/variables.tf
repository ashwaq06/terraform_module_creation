variable "bastion_key_name" {
  description = "The name of the SSH key pair for the bastion host"
  type        = string
}

variable "private_instance_key_name" {
  description = "The name of the SSH key pair for the private instances"
  type        = string
}
