module "vpc" {
  source = "../vpc"
}

module "ssh_keypair" {
  source = "../ssh_keypair"
  bastion_key_name          = "BastionSSHKey"
  private_instance_key_name = "PrivateInstanceSSHKey"
}

module "instances" {
  source = "../instances"
  vpc_id                   = module.vpc.vpc_id
  public_subnet_id         = module.vpc.public_subnet_id
  private_subnet_id        = element(module.vpc.private_subnet_id,0)
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
resource "aws_lb" "private_alb" {
  name               = "private-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = module.vpc.private_subnet_id
}

resource "aws_lb_target_group" "private_target_group" {
  name     = "private-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_target_group.arn
  }
}
locals {
  private_instance_map = {
    for idx, instance_id in [
      module.instances.private_instance_1_id,
      module.instances.private_instance_2_id
    ] : idx => instance_id
  }
}


resource "aws_lb_target_group_attachment" "private_target_attachment" {
  for_each = local.private_instance_map

  target_group_arn = aws_lb_target_group.private_target_group.arn
  target_id        = each.value
}
