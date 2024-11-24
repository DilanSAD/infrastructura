#!/bin/bash

# ============================
# Colores y estilos ANSI
# ============================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
BOLD='\033[1m' # Negrilla
RESET='\033[0m' # Restablecer color y estilo

# ============================
# Funciones Utilitarias
# ============================

# Imprimir un separador visual
print_separator() {
  echo -e "${CYAN}========================================${RESET}"
}

# Encabezado para secciones
header() {
  echo -e "${BLUE}${BOLD} --- $1${RESET}"
}

# Mensaje de advertencia
warning_message() {
  echo -e "${YELLOW}${BOLD}! $1${RESET}"
}

# Mensaje de éxito
success_message() {
  echo -e "${GREEN}${BOLD} --- ✔ $1${RESET}"
}

# Mensaje de error
error_message() {
  echo -e "${RED}${BOLD} --- Error: $1${RESET}"
}

# Manejar errores y salir
error_exit() {
  error_message "$1"
  exit 1
}

# ============================
# Flujo Principal del Script
# ============================

# Limpiar la pantalla
clear
print_separator
header "Iniciando configuración del entorno virtual"

# Definir el nombre del entorno virtual, si no se pasa un nombre para el entorno por parámetro es venv por defecto
ENV_NAME="venv"
if [ "$#" -eq 1 ]; then
  ENV_NAME="$1"
fi

# Crear o verificar el entorno virtual
if [ -d "$ENV_NAME" ]; then
  success_message "El entorno virtual '$ENV_NAME' ya existe"
else
  python -m venv "$ENV_NAME" || error_exit "No se pudo crear el entorno virtual '$ENV_NAME'"
  success_message "Entorno virtual '$ENV_NAME' creado correctamente"
fi

# Activar el entorno virtual
header "Activando el entorno virtual"
if [ -f "$ENV_NAME/bin/activate" ]; then
  source "$ENV_NAME/bin/activate"
elif [ -f "$ENV_NAME/Scripts/activate" ]; then
  source "$ENV_NAME/Scripts/activate"
else
  error_exit "No se pudo encontrar el script de activación para el entorno virtual"
fi
success_message "Entorno virtual activado"

# Instalar dependencias
header "Instalando dependencias desde 'requirements.txt'"
if [ -f "requirements.txt" ]; then
  pip install -r requirements.txt || error_exit "Error al instalar las dependencias"
  success_message "Dependencias instaladas correctamente"
else
  error_exit "El archivo 'requirements.txt' no se encontró"
fi

# Iniciar el contenedor de LocalStack
header "Iniciando el contenedor de LocalStack"
cd LocalStack || error_exit "Directorio 'LocalStack' no encontrado. Saliendo"
docker-compose up -d || error_exit "Error al iniciar el contenedor de LocalStack"
success_message "Contenedor de LocalStack iniciado correctamente"

# Finalizar
print_separator
success_message "El entorno virtual y LocalStack están listos"

