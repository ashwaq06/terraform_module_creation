variable "ami_id" {
  description = "AMI ID for the instances"
  default     = "ami-03f4878755434977f"
}

variable "instance_type" {
  description = "Instance type for the instances"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "ID of the VPC where the instances will be deployed"
  type        = string
}

variable "public_security_group_id" {
  description = "ID of the security group for public instances"
  type        = string
}

variable "private_security_group_id" {
  description = "ID of the security group for private instances"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet where the bastion server will be deployed"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet where the private instances will be deployed"
  type        = string
}


variable "bastion_key_name" {
  description = "Name of the SSH key pair for the bastion host"
}

variable "private_instance_key_name" {
  description = "Name of the SSH key pair for the private instances"
}
