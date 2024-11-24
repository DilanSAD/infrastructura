#!/bin/bash

# ============================
# Colores y estilos ANSI
# ============================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
BOLD='\033[1m'
RESET='\033[0m' # Restablecer color y estilo

# ============================
# Funciones Utilitarias
# ============================

# Imprimir un separador visual
print_separator() {
  echo -e "${CYAN}========================================${RESET}"
}

# Manejar errores y salir
error_exit() {
  echo -e "${RED}${BOLD}Error:${RESET} $1" >&2
  exit 1
}

# Encabezado para secciones
header() {
  echo -e "${BLUE}${BOLD} --- $1${RESET}"
}

# Mensaje de éxito
success_message() {
  echo -e "${GREEN}${BOLD} --- ✔ $1${RESET}"
}

# Mensaje de advertencia
warning_message() {
  echo -e "${YELLOW}${BOLD}! $1${RESET}"
}

# ============================
# Flujo Principal del Script
# ============================

# Limpiar la pantalla para inicio claro
clear
print_separator
header "Iniciando Terraform"

# Verificar y cambiar al directorio Terraform
header "Cambiando al directorio 'terraform-container'"
cd terraform-container || error_exit "Directorio 'terraform-container' no encontrado. Saliendo."
success_message "Directorio encontrado y cambiado con éxito"

# Inicializar Terraform
header "Ejecutando 'terraform init'"
terraform init || error_exit "'terraform init' falló."
success_message "'terraform init' ejecutado correctamente"

# Confirmar acción de usuario
print_separator
warning_message "¿Quieres aplicar los cambios de Terraform? (yes/no)"
read -rp "> " confirm

if [[ "$confirm" == "yes" ]]; then
  # Ejecutar Terraform Apply
  header "Ejecutando 'terraform apply'"
  terraform apply -auto-approve || error_exit "'terraform apply' falló."
  success_message "Cambios aplicados con éxito"
else
  # Operación cancelada
  warning_message "Operación cancelada por el usuario"
fi

# Finalización del Script
print_separator
success_message "Terraform está listo"
