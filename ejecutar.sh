#!/bin/bash

# Nombre por defecto del entorno virtual
ENV_NAME="venv"
# Verificar si se proporcionó un argumento para usarlo como nombre de entorno
if [ "$#" -eq 1 ]; then
  ENV_NAME="$1"
fi
# Verificar si el entorno virtual ya existe
if [ -d "$ENV_NAME" ]; then
  echo " --- El entorno virtual '$ENV_NAME' ya existe"
else
  # Crear el entorno virtual
  python -m venv "$ENV_NAME"
  echo " --- Entorno virtual '$ENV_NAME' creado correctamente"
fi

# Activar el entorno virtual
if [ -f "$ENV_NAME/bin/activate" ]; then
  # Desde Bash en Unix/Linux
  source "$ENV_NAME/bin/activate"
elif [ -f "$ENV_NAME/Scripts/activate" ]; then
  # Desde Bash en Windows
  source "$ENV_NAME/Scripts/activate"
else
  echo " --- Error: No se pudo encontrar el script de activación"
  exit 1
fi

# Instalar las dependencias
if [ -f "requirements.txt" ]; then
  echo " --- Comenzando la instalación de las dependencias de requirements dentro del entorno virtual"
  pip install -r requirements.txt
else
  echo " --- El archivo requirements.txt no se encontró"
  exit 1
fi


: 'Activa el entorno virtual (esto depende del shell que estés usando)
Ejemplos de comandos
  cmd
    venv\Scripts\activate
    venv\Scripts\deactivate
  bash
    source venv/Scripts/activate
    deactivate
'

# Iniciar el contenedor de localstack
echo " --- Iniciando el contenedor de LocalStack"
cd LocalStack || { echo "Directorio LocalStack no encontrado. Saliendo."; exit 1; }
docker-compose up -d
# Espera un momento para que los los servicios de LocalStack se inicien
sleep 15