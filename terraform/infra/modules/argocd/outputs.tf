output "argocd_namespace" {
  value = kubernetes_namespace_v1.argocd.metadata[0].name
}

output "argocd_url" {
  description = "Argo CD Server URL"
  value       = "http://${data.kubernetes_service_v1.argocd_server.status[0].load_balancer[0].ingress[0].hostname}"
}

output "argocd_username" {
  description = "Argo CD admin username"
  value       = "admin"
}

output "argocd_password" {
  description = "Argo CD admin password"
  value       = base64decode(data.kubernetes_secret_v1.argocd_admin.data["password"]) 
}