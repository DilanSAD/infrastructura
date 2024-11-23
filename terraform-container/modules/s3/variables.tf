variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "tags" {
  description = "Etiquetas para el bucket"
  type        = map(string)
  default     = {}
}
