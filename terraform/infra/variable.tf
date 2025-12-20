variable "region" {
 description = "AWS region"
 type        = string
  
}

variable "vpc_cidr" {
 description = "CIDR block for the VPC"
 type        = string
  
}

variable "azs" {
  description  = "Public subnet CIDR"
  type         = list(string)
}

variable "public_subnets" {
  description   =  "Public subnet CIDRs"
  type          = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR"
  type        = list(string)
}