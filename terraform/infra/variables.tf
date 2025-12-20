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