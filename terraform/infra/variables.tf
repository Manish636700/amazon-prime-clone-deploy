variable "region" {
 description = "AWS region"
 type        = string
  
}

variable "vpc_cidr" {
 description = "CIDR block for the VPC"
 type        = string
    validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block"
  }
}

variable "public_subnets" {
  description   =  "Public subnet CIDRs"
  type          = list(string)

  validation {
    condition     = alltrue([for cidr in var.public_subnets : can(cidrnetmask(cidr))])
    error_message = "All public_subnets must be valid CIDR blocks"
  }
}

variable "private_subnets" {
  description = "Private subnet CIDR"
  type        = list(string)

   validation {
    condition     = alltrue([for cidr in var.private_subnets : can(cidrnetmask(cidr))])
    error_message = "All private_subnets must be valid CIDR blocks"
  }
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}
variable "public_key" {
  description = "ec2 instace public key"
  type        = string
  sensitive   = true

  
}

variable "instance_type" {
  description = "Instance_type"
  type        = string
}
variable "volume_size" {
  description = "volume size"
  type        = number 

  validation {
    condition =  var.volume_size >= 20
    error_message = "volume_size must be at least 20 GB"

  }
}

variable "ingress_rules" {
  type   = list(object({
    description    = string
    from_port      = number
    to_port        = number
    protocol       = string
    cidr_blocks    = list(string)
  }))
}

variable "aws_region" {
  default  = "ap-south-1"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  default     = "1.34"
}

variable "environment" {
  type        = string
  default     = "production"
}

variable "tags" {
  description = "common resource tags"
  type        = map(string)
}

variable "private_key_path" {
  default = " SSH private key path"
  type        = string 
}

variable "namespace" {
  description = "Namespace for Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
    description = "Argo CD Helm chart version"
    type        = string
    default     = "6.7.14"    
}