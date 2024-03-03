module "vpc" {
  source = "../vpc"
}
module "ssh_keypair" {
  source = "../ssh_keypair"
  bastion_key_name          = "BastionSSHKey"
  private_instance_key_name = "PrivateInstanceSSHKey"
}

module "instances" {
  source                   = "../instances"
  vpc_id                   = module.vpc.vpc_id
  public_subnet_id         = module.vpc.public_subnet_id
  private_subnet_id        = element(module.vpc.private_subnet_id, 0)
  ami_id                   = "ami-03f4878755434977f"
  instance_type            = "t2.micro"
  public_security_group_id = module.security_groups.public_security_group_id
  private_security_group_id = module.security_groups.private_security_group_id
  bastion_key_name         = module.ssh_keypair.bastion_key_name
  private_instance_key_name = module.ssh_keypair.private_instance_key_name
}

module "security_groups" {
    source = "../security_groups"
    vpc_id    = module.vpc.vpc_id
    ssh_cidr = "0.0.0.0/0"
  
}

module "load_balancer" {
    source = "../load_balancer"
    vpc_id                = module.vpc.vpc_id
    private_instance    = [module.instances.private_instance_1_id]
  
}

resource "aws_api_gateway_rest_api" "main" {
  name        = "main-api"
  description = "Main API Gateway"
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_method" "any_method" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.root.id
  http_method             = aws_api_gateway_method.any_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri = "http://${module.load_balancer.private_alb_dns_name}/nginx"


}

resource "aws_api_gateway_method_response" "response" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.any_method.http_method

  status_code = "200"
}

resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.any_method.http_method

  status_code = aws_api_gateway_method_response.response.status_code
}

resource "aws_api_gateway_deployment" "main" {
  depends_on  = [aws_api_gateway_integration.api_integration]
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = "prod"
}
