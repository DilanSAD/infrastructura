#!/bin/bash

# Incluir funciones comunes
source ./utils.sh

# Moverse un nivel arriba
cd .. || exit 1

# Listar entornos disponibles dinámicamente
list_environments() {
  echo -e "${CYAN}Entornos disponibles:${RESET}"
  echo -e "${CYAN}0) Todos los entornos${RESET}"
  i=1
  for dir in environments/*/; do
    env_name=$(basename "$dir")
    echo -e "${CYAN}${i}) ${env_name}${RESET}"
    environments_list+=("$env_name")
    ((i++))
  done
}

# Comprobar si existen archivos .tfstate para un entorno específico
check_tfstate_exists() {
  local environment=$1
  if [ "$environment" == "" ]; then
    # Verificar si existe algún estado en cualquier entorno
    if [ -d "states" ]; then
      for env_dir in states/*/; do
        if [ -d "$env_dir" ] && [ -f "${env_dir}/terraform.tfstate" ]; then
          return 0
        fi
      done
    fi
    return 1
  else
    # Verificar si existe estado para un entorno específico
    if [ -d "states/${environment}" ] && [ -f "states/${environment}/terraform.tfstate" ]; then
      return 0
    fi
    return 1
  fi
}

# ============================
# Flujo Principal del Script
# ============================

# Limpiar la pantalla para inicio claro
clear
print_separator
header "Reseteando la infraestructura de Terraform"

# Verificar y cambiar al directorio Terraform
header "Cambiando al directorio 'terraform-container'"
cd terraform-container || error_exit "Directorio 'terraform-container' no encontrado. Saliendo."
success_message "Directorio 'terraform-container' encontrado y cambiado con éxito"

# Comprobar si hay infraestructura
if ! check_tfstate_exists ""; then
  warning_message "No se encuentra infraestructura de Terraform. No es necesario realizar un reseteo."
  exit 0
fi

# Selección de entorno
print_separator
header "Selecciona el entorno que deseas resetear"
environments_list=()
list_environments
read -rp "Selecciona un número: " env_choice

# Validar que la entrada sea un número
if ! [[ "$env_choice" =~ ^[0-9]+$ ]]; then
  error_exit "Por favor, introduce un número válido"
fi

if [[ "$env_choice" -eq 0 ]]; then
  # Destruir todos los entornos
  warning_message "Este paso destruirá TODA la infraestructura gestionada por Terraform. ¿Estás seguro? (yes/no)"
  read -rp "> " confirm
  if [[ "$confirm" == "yes" ]]; then
    for env_dir in states/*/; do
      if [ -d "$env_dir" ]; then
        env_name=$(basename "$env_dir")
        if [ -f "${env_dir}/terraform.tfstate" ]; then
          header "Destruyendo infraestructura para el entorno '$env_name'"
          terraform init -reconfigure -backend-config="path=states/${env_name}/terraform.tfstate"
          terraform destroy -auto-approve -var-file="environments/$env_name/terraform.tfvars" || error_exit "Falló el destroy para el entorno '$env_name'."
          success_message "Infraestructura destruida para el entorno '$env_name'"
        fi
      fi
    done
    header "Eliminando archivos generados por Terraform"
    rm -rf .terraform .terraform.lock.hcl plan.tfplan states || error_exit "Error al eliminar archivos generados por Terraform."
    success_message "Todos los archivos generados eliminados correctamente"
  else
    warning_message "Operación cancelada por el usuario"
    exit 0
  fi
elif [[ "$env_choice" -gt 0 ]] && [[ "$env_choice" -le "${#environments_list[@]}" ]]; then
  # Destruir un entorno específico
  environment="${environments_list[$((env_choice - 1))]}"
  warning_message "Este paso destruirá la infraestructura para el entorno '$environment'. ¿Estás seguro? (yes/no)"
  read -rp "> " confirm
  if [[ "$confirm" == "yes" ]]; then
    header "Destruyendo infraestructura para el entorno '$environment'"
    terraform init -reconfigure -backend-config="path=states/${environment}/terraform.tfstate"
    terraform destroy -auto-approve -var-file="environments/$environment/terraform.tfvars" || error_exit "Falló el destroy para el entorno '$environment'."
    rm -rf "states/${environment}" || error_exit "Error al eliminar el estado del entorno '$environment'."
    success_message "Infraestructura destruida para el entorno '$environment'"
  else
    warning_message "Operación cancelada por el usuario"
    exit 0
  fi
else
  error_exit "Opción no válida. Saliendo."
fi

# Finalización del Script
print_separator
success_message "El proceso de reseteo de infraestructura ha finalizado"


