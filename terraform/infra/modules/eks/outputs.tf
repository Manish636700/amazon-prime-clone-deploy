output "cluster_name" {
  value = module.this.cluster_name
}

output "cluster_endpoint" {
  value = module.this.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.this.cluster_certificate_authority_data
}

output "oidc_provider_arn" {
  value = module.this.oidc_provider_arn
}

output "node_security_group_id" {
  description = "EKS cluster security group ID"
  value       = module.this.node_security_group_id
}


