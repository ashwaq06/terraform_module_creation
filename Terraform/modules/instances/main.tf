resource "aws_instance" "private_instance_1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.private_security_group_id]
  subnet_id              = var.private_subnet_id
  key_name               = var.private_instance_key_name
  tags = {
    Name = "private_instance_1"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ansible",
    ]
  }

  provisioner "local-exec" {
    command     = "ansible-playbook -i ${self.private_ip}, playbook.yml"
    working_dir = "${path.module}/ansible"
  }
}

resource "aws_instance" "private_instance_2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.private_security_group_id]
  subnet_id              = var.private_subnet_id
  key_name               = var.private_instance_key_name
  tags = {
    Name = "private_instance_2"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ansible",
    ]
  }

  provisioner "local-exec" {
    command     = "ansible-playbook -i ${self.private_ip}, playbook.yml"
    working_dir = "${path.module}/ansible"
  }
}

resource "aws_instance" "bastion_host" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.public_security_group_id]
  subnet_id              = var.public_subnet_id
  associate_public_ip_address = true
  key_name               = var.bastion_key_name

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private_route_table.id
}
