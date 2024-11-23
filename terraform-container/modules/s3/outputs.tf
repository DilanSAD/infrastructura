output "bucket_name" {
  description = "Nombre del bucket creado"
  value       = aws_s3_bucket.bucket.bucket
}

output "bucket_policy" {
  description = "Política aplicada al bucket"
  value       = aws_s3_bucket_policy.bucket_policy.policy
}
