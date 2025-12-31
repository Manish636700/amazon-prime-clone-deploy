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

output "argocd_url" {
  description = "Argo CD Server URL"
  value       = module.argocd.argocd_url
}

output "argocd_username" {
  description = "Argo CD admin username"
  value       = module.argocd.argocd_username
}

output "argocd_password" {
  description = "Argo CD admin password"
  value       = module.argocd.argocd_password
  sensitive   = true
}