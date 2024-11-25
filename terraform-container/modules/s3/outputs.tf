output "bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = aws_s3_bucket.example.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3 creado"
  value       = aws_s3_bucket.example.arn
}

output "bucket_region" {
  description = "Región donde se encuentra el bucket S3"
  value       = aws_s3_bucket.example.region
}
