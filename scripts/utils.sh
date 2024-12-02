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