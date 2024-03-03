resource "tls_private_key" "bastion_ssh_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_key_pair" {
  key_name   = var.bastion_key_name
  public_key = tls_private_key.bastion_ssh_keypair.public_key_openssh
}

resource "tls_private_key" "private_instance_ssh_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "private_instance_key_pair" {
  key_name   = var.private_instance_key_name
  public_key = tls_private_key.private_instance_ssh_keypair.public_key_openssh
}