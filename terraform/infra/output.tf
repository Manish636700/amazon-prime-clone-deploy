output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "private_subnets" {
  value = module.vpc.private_subnets_ids
}

output "bastion_public_ip" {
  value = module.bastion_ec2
}

output "ecr_url" {
  value  = module.ecr.repository_url
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}