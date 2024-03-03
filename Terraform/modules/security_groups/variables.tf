variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "ssh_cidr" {
  description = "CIDR range to allow SSH access"
}

variable "private_sg_name" {
  description = "Name for the private security group"
  default     = "private_sg"
}

variable "public_sg_name" {
  description = "Name for the public security group"
  default     = "public_sg"
}
