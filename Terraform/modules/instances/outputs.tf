output "private_instance_1_id" {
  description = "ID of the first private instance"
  value       = aws_instance.private_instance_1.id
}

output "private_instance_2_id" {
  description = "ID of the second private instance"
  value       = aws_instance.private_instance_2.id
}

output "private_instance_ids" {
  description = "List of private instance IDs"
  value       = [
    aws_instance.private_instance_1.id,
    aws_instance.private_instance_2.id
  ]
}

output "public_instance_id" {
  description = "ID of the public instance (bastion host)"
  value       = aws_instance.bastion_host.id
}

  
