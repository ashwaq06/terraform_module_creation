output "bastion_key_name" {
  value = var.bastion_key_name
}

output "private_instance_key_name" {
  value = var.private_instance_key_name
}

output "bastion_public_key" {
  value = aws_key_pair.bastion_key_pair.public_key
}

output "private_instance_public_key" {
  value = aws_key_pair.private_instance_key_pair.public_key
}
