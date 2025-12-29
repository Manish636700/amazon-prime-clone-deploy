variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "eks_managed_node_groups" {
  type = any
}

variable "tags" {
  type = map(string)
}

variable "bastion_role_arn" {
  description = "IAM role ARN of bation Ec2"
  type = string
  
}

variable "source_security_group_id" {
  description = "Security group ID of bastion EC2"
  type = string
}