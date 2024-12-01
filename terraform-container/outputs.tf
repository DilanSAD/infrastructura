# Output para el ID de la instancia EC2
# Este valor se obtiene del módulo EC2 y puede ser utilizado 
# para referenciar la instancia en otros recursos
output "ec2_instance_id" {
  value       = module.ec2.instance_id
  description = "El ID único de la instancia EC2 creada"
}

# Output para el nombre del bucket S3
# Expone el nombre del bucket creado por el módulo S3
# para su uso en otras configuraciones
output "s3_bucket_name" {
  value       = module.s3.bucket_name
  description = "El nombre del bucket S3 creado"
}

# Output para el nombre de la tabla DynamoDB
# Proporciona el nombre de la tabla creada por el módulo DynamoDB
# útil para referencias posteriores
output "dynamodb_table_name" {
  value       = module.dynamodb.table_name
  description = "El nombre de la tabla DynamoDB creada"
}