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

variable "subnet_id" {
    description = "subnet id where the ec2 instance"
    type        = string
}

variable "key_name" {
    description = "Ec2 key pair name "
    type        = string

}

variable "public_key" {
    description = "Public key for the ec2 instance"
    type        = string
    sensitive   = true 
  
}



variable "vpc_id" {
  description    = "VPC Id for the security group"
  type           = string
}



variable "volume_size" {
    description = "Root EBS volume size in GB"
    type        = number

}


variable "iam_instance_profile" {
  description = "IAM instance profile name passed from root"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to attach to the EC2 instance"
  type        = list(string)
  
}