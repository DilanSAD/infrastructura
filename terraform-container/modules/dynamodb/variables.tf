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
  description = "Etiquetas adicionales para la tabla DynamoDB"
  type        = map(string)
  default     = {}
}
