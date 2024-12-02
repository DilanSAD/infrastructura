#!/bin/bash

# Incluir funciones comunes
source ./utils.sh

# Moverse un nivel arriba
cd .. || exit 1

# ============================
# Flujo Principal del Script
# ============================

# Limpiar la pantalla
clear
print_separator
header "Iniciando configuración del entorno virtual"

# Nombre fijo del entorno virtual
ENV_NAME="venv"

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

# Instalar dependencias solo si faltan
header "Verificando dependencias desde 'requirements.txt'"
if [ -f "requirements.txt" ]; then
  pip install --upgrade pip > /dev/null 2>&1
  MISSING=$(pip install -r requirements.txt --dry-run | grep "Would install" | wc -l)
  if [ "$MISSING" -eq 0 ]; then
    success_message "Todas las dependencias ya están instaladas y actualizadas"
  else
    pip install -r requirements.txt || error_exit "Error al instalar las dependencias"
    success_message "Dependencias instaladas correctamente"
  fi
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
