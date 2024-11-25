#!/bin/bash

# Incluir funciones comunes
source ./utils.sh

# Listar entornos disponibles dinámicamente
list_environments() {
  echo -e "${CYAN}Entornos disponibles:${RESET}"
  i=1
  for dir in environments/*/; do
    env_name=$(basename "$dir")
    echo -e "${CYAN}${i}) ${env_name}${RESET}"
    environments_list+=("$env_name")
    ((i++))
  done
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

# Formatear código Terraform
header "Formateando archivos Terraform"
terraform fmt -recursive || error_exit "'terraform fmt' falló."
success_message "Código formateado correctamente"

# Inicializar Terraform
header "Ejecutando 'terraform init'"
terraform init || error_exit "'terraform init' falló."
success_message "'terraform init' ejecutado correctamente"

# Validar configuración de Terraform
header "Validando configuración de Terraform"
terraform validate || error_exit "'terraform validate' falló."
success_message "Configuración validada correctamente"

# Selección de entorno
print_separator
header "Selecciona el entorno que deseas desplegar"

environments_list=()
list_environments
read -rp "Selecciona un número: " env_choice

if [[ "$env_choice" -gt 0 && "$env_choice" -le "${#environments_list[@]}" ]]; then
  environment="${environments_list[$((env_choice - 1))]}"
else
  error_exit "Opción no válida. Saliendo."
fi

# Previsualización del plan de Terraform
print_separator
header "Generando plan de Terraform para el entorno '$environment'"
terraform plan -var-file="environments/$environment/terraform.tfvars" -out="plan.tfplan" || error_exit "'terraform plan' falló."
success_message "Plan generado correctamente"

# Confirmar acción de usuario
warning_message "¿Quieres aplicar los cambios de Terraform para el entorno $environment? (yes/no)"
read -rp "> " confirm

if [[ "$confirm" == "yes" ]]; then
  # Aplicar cambios de Terraform
  header "Aplicando cambios con 'terraform apply'"
  terraform apply "plan.tfplan" || error_exit "'terraform apply' falló."
  success_message "Cambios aplicados con éxito para el entorno $environment"
else
  # Operación cancelada
  warning_message "Operación cancelada por el usuario"
fi

# Finalización del Script
print_separator
success_message "Terraform está listo"
