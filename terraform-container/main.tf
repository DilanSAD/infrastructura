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
  skip_metadata_api_check     = true # Omite la validación de la instancia EC2
  skip_requesting_account_id  = true # Evita consultar el ID de la cuenta de AWS
  endpoints {
    s3       = "http://localhost:4566" # Endpoint para S3 en LocalStack
    dynamodb = "http://localhost:4566" # Endpoint para DynamoDB en LocalStack
    ec2      = "http://localhost:4566" # Endpoint de EC2 en LocalStack
  }
}

module "ec2" {
  source        = "./modules/ec2"  # Ruta relativa al módulo
  ami           = "ami-0abcdef1234567890" # ID ficticio
  instance_type = "t2.micro"
  name          = "localstack-ec2"
}


module "s3" {
  source      = "./modules/s3"
  bucket_name = "localstack-bucket"
  tags = {
    Environment = "LocalStack"
  }
}

module "dynamodb" {
  source        = "./modules/dynamodb"
  table_name    = "localstack-dynamodb"
  hash_key      = "id"
  hash_key_type = "S"
  tags = {
    Environment = "LocalStack"
  }
}
