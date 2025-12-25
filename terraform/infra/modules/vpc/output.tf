output "vpc_id" {
  description           = "VPC ID"
  value                 = aws_vpc.this.id
}

output "public_subnet_ids" {
    description           = "Public dubnet Ids"
    value                 = aws_subnet.public[*].id
  
}

output "private_subnets_ids" {
  description             = "Private subnet IDs"
  value                   = aws_subnet.private[*].id
}