# Bloque de configuración principal de Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Proveedor oficial de AWS
      version = "~> 4.16"       # Versión específica del proveedor
    }
  }

  required_version = ">= 1.2.0" # Versión mínima requerida de Terraform
}

# Configuración del proveedor AWS para LocalStack
provider "aws" {
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  region                      = "us-east-1"
  s3_use_path_style           = true # Necesario para compatibilidad con LocalStack
  skip_credentials_validation = true # Desactiva validación de credenciales para entorno local
  skip_requesting_account_id  = true # Omite la verificación de cuenta AWS

  # Configuración de endpoints para servicios LocalStack
  endpoints {
    s3       = "http://localhost:4566" # Endpoint local para S3
    dynamodb = "http://localhost:4566" # Endpoint local para DynamoDB
    ec2      = "http://localhost:4566" # Endpoint local para EC2
  }
}

# Módulo para la creación de instancias EC2
module "ec2" {
  source        = "./modules/ec2"   # Ruta al módulo EC2
  ami           = var.ami           # ID de la AMI a utilizar
  instance_type = var.instance_type # Tipo de instancia EC2
  tags_ec2      = var.tags_ec2      # Etiquetas para la instancia
  instance_name = var.instance_name # Nombre de la instancia
}

# Módulo para la creación de buckets S3
module "s3" {
  source      = "./modules/s3"  # Ruta al módulo S3
  bucket_name = var.bucket_name # Nombre del bucket
  tags_s3     = var.tags_s3     # Etiquetas para el bucket
}

# Módulo para la creación de tablas DynamoDB
module "dynamodb" {
  source        = "./modules/dynamodb" # Ruta al módulo DynamoDB
  table_name    = var.table_name       # Nombre de la tabla
  hash_key      = var.hash_key         # Clave primaria de la tabla
  hash_key_type = var.hash_key_type    # Tipo de dato de la clave primaria
  tags_dynamodb = var.tags_dynamodb    # Etiquetas para la tabla
}
