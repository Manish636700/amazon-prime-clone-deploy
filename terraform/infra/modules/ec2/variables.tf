variable "name" {
    description   = "Name prefix for ec2 resource"
    type          = string 
}

variable "ami_id" {
    description = "AMI Id for the ec2 instance"
    type        = string
  
}

variable "instance_type" {
    description = " ec2 instance type"
    type        = string

}

variable "key_name" {
    description = "Ec2 key pair name "
    type        = string

}

variable "subnet_id" {
    description = "subnet id where the ec2 instance"
    type        = string
}

variable "vpc_id" {
  description    = "VPC Id for the security group"
  type           = string
}

variable "volume_size" {
    description = "Root EBS volume size in GB"
    type        = number

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