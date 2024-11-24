variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "ami" {
  description = "AMI ID para EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
}

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
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

variable "tags" {
  description = "Etiquetas comunes para los recursos"
  type        = map(string)
}
