resource "kubernetes_cluster_role_binding_v1" "terraform_admin" {
    metadata {
      name = "terraform-admin"
    }
    role_ref {
      api_group = "rbac.authorization.k8s.io"
      kind      = "ClusterRole"
      name      = "cluster-admin"
    }
    subject {
      kind      = "User"
      name      = "arn:aws:iam::084129281014:user/project"
      api_group = "rbac.authorization.k8s.io"
    }
}
    
  resource "kubernetes_cluster_role_binding_v1" "bastion_admin" {
  metadata {
    name = "bastion-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"
    name      = aws_iam_role.bastion_role.arn
    api_group = "rbac.authorization.k8s.io"
  }
}
