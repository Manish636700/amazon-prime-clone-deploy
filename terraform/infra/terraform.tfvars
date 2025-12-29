region          = "us-east-1"
vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]

instance_type = "t3.medium"
volume_size   = 50

cluster_name = "prime-eks-prod"
cluster_version = "1.34" 
environment = "production"

tags = {
  Environment = "production"
  Project     = "amazon-prime-clone"
  Owner       = "manish"
  ManagedBy   = "terraform"
}

ingress_rules = [{
  description = "SSH access"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  },
  {
    description = "prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  },
  {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  },
  {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}]
