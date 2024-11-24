# Crear el bucket S3
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

# Asignar una política al bucket S3
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource  = [
          "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*"
        ],
        Condition = {
          Bool: {
            "aws:SecureTransport": "false"
          }
        }
      }
    ]
  })
}

