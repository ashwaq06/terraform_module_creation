variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.34.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["172.34.1.0/24", "172.34.2.0/24", "172.34.3.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["172.34.4.0/24", "172.34.5.0/24", "172.34.6.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
