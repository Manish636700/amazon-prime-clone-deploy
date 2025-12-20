module "vpc" {
  source          = "./modules/vpc"
  vpc_name        = "production-vpc"
  vpc_cidr        = var.vpc_cidr
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  key_name   = "prod-devops-key"
  public_key = tls_private_key.this.public_key_openssh
}

module "bastion_ec2" {
  source        = "./modules/ec2"
  name          = "prod-bastion"
  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.bastion.key_name
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  volume_size   = var.volume_size
  ingress_rules = var.ingress_rules


}