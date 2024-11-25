resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name # Nombre del bucket S3

  tags = merge(
    var.tags_s3,               # Etiquetas personalizadas
    { Name = var.bucket_name } # Etiqueta "Name" para identificar el bucket
  )
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
