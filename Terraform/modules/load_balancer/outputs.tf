output "private_alb_dns_name" {
  description = "DNS name of the private ALB"
  value       = aws_lb.private_alb.dns_name
}
