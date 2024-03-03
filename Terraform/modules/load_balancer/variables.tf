variable "vpc_id" {
  description = "ID of the VPC"
}

variable "private_instance" {
  type        = list(string)
  description = "List of private instance IDs"
}
