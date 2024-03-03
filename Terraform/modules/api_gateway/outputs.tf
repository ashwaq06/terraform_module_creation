output "api_gateway_url" {
  value = "https://${aws_api_gateway_deployment.main.invoke_url}/v1"
}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.main.id
}

