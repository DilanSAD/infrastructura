resource "aws_dynamodb_table" "example" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST" # Modo de facturación recomendado
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  tags = merge(
    var.tags_dynamodb,        # Etiquetas personalizadas
    { Name = var.table_name } # Etiqueta "Name" para identificar la tabla
  )
}
