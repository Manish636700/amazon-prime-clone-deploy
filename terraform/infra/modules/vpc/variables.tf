variable "vpc_cidr" {
 description = "CIDR block for the VPC"
 type        = string
}

variable "public_subnets" {
 description = "List of public subnet CIDR blocks"
 type        = list(string)
  
}

variable "private_subnets" {
 description = "List of private subnet CIDR blocks"
 type        = list(string)
}

variable "azs" {
 description = "List of availability zones"
 type        = list(string)
  
}

variable "vpc_name" {
 description = "Name of the VPC"
 type        = string
}

variable "ec2-sg-name" {
    description   = "Name prefix for ec2 resource"
    type          = string 
}
variable "ingress_rules" {
    type = list(object({
        description      = string
        from_port        = number
        to_port          = number
        protocol         = string
        cidr_blocks      = list(string)
    }))

}