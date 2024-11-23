variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

variable "hash_key" {
  description = "Clave principal de la tabla"
  type        = string
}

variable "hash_key_type" {
  description = "Tipo de dato de la clave principal (S para String, N para Number)"
  type        = string
  default     = "S"
}

variable "tags" {
  description = "Etiquetas para la tabla"
  type        = map(string)
  default     = {}
}
