variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "tags_s3" {
  description = "Etiquetas adicionales para el bucket S3"
  type        = map(string)
  default     = {}
}
