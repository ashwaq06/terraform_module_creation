output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "List of IDs for public subnets"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "List of IDs for private subnets"
  value       = module.vpc.private_subnet_id
}

output "public_key" {
  description = "Public key for SSH keypair"
  value       = module.ssh_keypair.bastion_public_key
}

output "private_key" {
  description = "Private key for SSH keypair"
  value       = module.ssh_keypair.private_instance_public_key
  sensitive   = true
}
# output "private_instance_1_id" {
#   description = "ID of the first private instance"
#   value       = module.instances.private_instance_1_id
# }

# output "private_instance_2_id" {
#   description = "ID of the second private instance"
#   value       = module.instances.private_instance_2_id
# }

output "public_instance_id" {
  description = "ID of the public instance (bastion host)"
  value       = module.instances.public_instance_id
}

output "api_gateway_url" {
  value = "https://${module.api_gateway.api_gateway_id}.execute-api.${var.aws_region}.amazonaws.com/v1"
}


