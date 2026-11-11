data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "./modules/vpc"

  name                 = var.project_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
}

module "security" {
  source = "./modules/security"

  name   = var.project_name
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  count = var.enable_ec2 ? 1 : 0

  name               = var.project_name
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_id  = module.security.web_security_group_id
  instance_type      = var.ec2_instance_type
}
