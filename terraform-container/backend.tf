# Bloque de configuración del backend de Terraform
terraform {
  # Especifica el tipo de backend como "local"
  # El backend local almacena el estado en el sistema de archivos local
  backend "local" {
    # Ruta donde se guardará el archivo de estado
    # Por defecto, se guardará como "terraform.tfstate" en el directorio actual
    path = "terraform.tfstate"
  }
} 