terraform {
  backend "s3" {
    bucket         = "prod-terraform-state-manish"
    key            = "prod/infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}