variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "ami" {
  description = "AMI ID para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2 (e.g., t2.micro, t3.small, etc.)"
  type        = string
}

variable "instance_name" {
  description = "Nombre lógico de la instancia EC2 (para la etiqueta 'Name')"
  type        = string
}

variable "tags_ec2" {
  description = "Etiquetas para la instancia EC2"
  type        = map(string)
}

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "tags_s3" {
  description = "Etiquetas para el bucket S3"
  type        = map(string)
}

variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

variable "hash_key" {
  description = "Clave principal de la tabla DynamoDB"
  type        = string
}

variable "hash_key_type" {
  description = "Tipo de dato de la clave principal (S para String, N para Number)"
  type        = string
  default     = "S"
}

variable "tags_dynamodb" {
  description = "Etiquetas para la tabla DynamoDB"
  type        = map(string)
}
