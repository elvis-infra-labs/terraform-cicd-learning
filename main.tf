terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "elvis-terraform-state-2026"
    key            = "06-cicd/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "app" {
  bucket = "elvis-cicd-app-${var.environment}-2026"

  tags = {
    Name        = "CICD App Bucket"
    Environment = var.environment
    ManagedBy   = "Terraform"
    DeployedBy  = "GitHub-Actions"
  }
}
