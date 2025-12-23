module "vpc" {
  source          = "./modules/vpc"
  vpc_name        = "production-vpc"
  vpc_cidr        = var.vpc_cidr
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "bastion_ec2" {
  source        = "./modules/ec2"
  name          = "prod-bastion"
  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name
  public_key    = var.public_key 
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  volume_size   = var.volume_size
  ingress_rules = var.ingress_rules


}

module "ecr" {
  source = "./modules/ecr"

  repository_name = "amazon-prime-prod"
  tags = {
    Environment = "production"
    Project     = "amazon-prime-clone"
    Owner       = "devops"
  }
}

module "eks" {
  source = "./modules/eks"


  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets_ids

  eks_managed_node_groups = {
    on_demand = {
      name           = "on-demand-ng"
      capacity_type  = "ON_DEMAND"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 5
      desired_size = 2
    }
  }

  tags = var.tags
}
