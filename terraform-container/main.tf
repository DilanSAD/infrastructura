terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  access_key                  = var.aws_access_key # Credenciales ficticias
  secret_key                  = var.aws_secret_key
  region                      = "us-east-1" # Región por defecto
  s3_use_path_style           = true
  skip_credentials_validation = true # Evita la validación de credenciales
  # skip_metadata_api_check     = true # Omite la validación de la instancia EC2
  skip_requesting_account_id  = true # Evita consultar el ID de la cuenta de AWS
  endpoints {
    s3       = "http://localhost:4566" # Endpoint para S3 en LocalStack
    dynamodb = "http://localhost:4566" # Endpoint para DynamoDB en LocalStack
    ec2      = "http://localhost:4566" # Endpoint de EC2 en LocalStack
  }
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  name          = var.instance_name
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  tags        = var.tags
}

module "dynamodb" {
  source        = "./modules/dynamodb"
  table_name    = var.table_name
  hash_key      = var.hash_key
  hash_key_type = var.hash_key_type
  tags          = var.tags
}

