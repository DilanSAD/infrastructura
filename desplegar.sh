#!/bin/bash

# Función para manejar errores
function error_exit {
  echo "Error: $1" >&2
  exit 1
}

# Iniciar Terraform
echo " --- Iniciando Terraform ---"

# Verificar si el directorio existe y cambiar a él
cd terraform-container || error_exit "Directorio 'terraform-container' no encontrado. Saliendo."

# Inicializar Terraform
echo " --- Ejecutando 'terraform init' ---"
terraform init || error_exit "'terraform init' falló."

# Confirmar antes de aplicar los cambios
echo " --- ¿Quieres aplicar los cambios de Terraform? (yes/no) ---"
read -r confirm

if [[ "$confirm" == "yes" ]]; then
  echo " --- Ejecutando 'terraform apply' ---"
  terraform apply -auto-approve || error_exit "'terraform apply' falló."
  echo " --- Cambios aplicados con éxito ---"
else
  echo " --- Operación cancelada por el usuario ---"
fi
