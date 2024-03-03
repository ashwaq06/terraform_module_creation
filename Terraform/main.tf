provider "aws" {
  region = var.aws_region
}

provider "terraform" {
  
}

module "vpc" {
  source = "./modules/vpc"
}

module "ssh_keypair" {
  source  = "./modules/ssh_keypair"
  bastion_key_name          = "BastionSSHKey"
  private_instance_key_name = "PrivateInstanceSSHKey"
}

module "instances" {
  source                   = "./modules/instances"
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

module "load_balancer" {
  source           = "./modules/load_balancer"
  vpc_id           = module.vpc.vpc_id
  private_instance = module.instances.private_instance_ids
}

module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.vpc.vpc_id
  ssh_cidr = "0.0.0.0/0"
}

module "api_gateway" {
  source                = "./modules/api_gateway"
  aws_region            = var.aws_region
  vpc_id                = module.vpc.vpc_id
  private_alb_dns_name  = module.load_balancer.private_alb_dns_name
}
