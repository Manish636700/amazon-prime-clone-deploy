module "this" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true
  create_cloudwatch_log_group = false

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }
  }

  eks_managed_node_groups = var.eks_managed_node_groups

  access_entries = {
    bastion_admin = {
      principal_arn = var.bastion_role_arn

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  } 
  tags = var.tags
}

resource "aws_security_group_rule" "bastion_to_eks" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"

  security_group_id        = module.this.node_security_group_id
  source_security_group_id = var.source_security_group_id
}

resource "aws_security_group_rule" "bastion_to_eks_api" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"

  security_group_id        = module.this.cluster_security_group_id
  source_security_group_id = var.source_security_group_id
}
