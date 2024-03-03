output "vpc_id" {
  value = aws_vpc.zenskar.id
}


output "public_subnet_id" {
  value = element(aws_subnet.public_subnet[*].id, 0)
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet[*].id
}
