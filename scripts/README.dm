# Scripts para Gestión de Infraestructura

Este directorio contiene scripts que facilitan la gestión de la infraestructura de Terraform y la configuración del entorno de desarrollo. A continuación, se describen los scripts disponibles y su funcionalidad.

## Contenido del Directorio

- **`desplegar.sh`**: Despliega la infraestructura de Terraform en el entorno seleccionado.
- **`ejecutar.sh`**: Crea y configura un entorno virtual de Python y prepara LocalStack.
- **`reset.sh`**: Resetea la infraestructura de Terraform, permitiendo destruir entornos específicos o todos a la vez.
- **`utils.sh`**: Contiene funciones utilitarias y definiciones de colores para mejorar la salida en la terminal.

## Cómo Usar los Scripts

### 1. `desplegar.sh`

Este script se encarga de desplegar la infraestructura de Terraform. Realiza las siguientes acciones:

- **Inicializa Terraform**: Prepara el entorno de trabajo.
- **Valida la configuración**: Asegura que la configuración de Terraform sea correcta.
- **Selecciona el entorno**: Permite al usuario elegir el entorno a desplegar.
- **Genera un plan**: Muestra los cambios que se aplicarán.
- **Aplica los cambios**: Ejecuta `terraform apply` para implementar la infraestructura.

**Uso**:
```bash
./scripts/desplegar.sh
```

### 2. `ejecutar.sh`

Este script configura un entorno virtual de Python y prepara LocalStack. Sus funciones incluyen:

- **Crea un entorno virtual**: Verifica si ya existe y lo crea si es necesario.
- **Activa el entorno virtual**: Permite instalar dependencias en el entorno.
- **Instala dependencias**: Verifica e instala las dependencias necesarias desde `requirements.txt`.
- **Inicia LocalStack**: Levanta el contenedor de LocalStack para simular servicios de AWS.

**Uso**:
```bash
./scripts/ejecutar.sh
```

### 3. `reset.sh`

Este script permite resetear la infraestructura de Terraform. Sus principales funciones son:

- **Verifica la infraestructura existente**: Comprueba si hay archivos de estado de Terraform.
- **Selecciona el entorno a resetear**: Permite al usuario elegir un entorno específico o destruir todos.
- **Destruye la infraestructura**: Ejecuta `terraform destroy` para eliminar la infraestructura seleccionada.

**Uso**:
```bash
./scripts/reset.sh
```

### 4. `utils.sh`

Este script contiene funciones utilitarias que son utilizadas por los otros scripts. Incluye:

- **Definiciones de colores**: Mejora la legibilidad de la salida en la terminal.
- **Funciones para imprimir mensajes**: Facilita la visualización de mensajes de éxito, advertencia y error.
- **Manejo de errores**: Proporciona una forma estandarizada de manejar errores y salir del script.

## Requisitos

Antes de ejecutar los scripts, asegúrate de tener instalados:

- **Terraform**: Para gestionar la infraestructura.
- **Python**: Para crear el entorno virtual.
- **Docker**: Para ejecutar LocalStack.

## Conclusión

Estos scripts están diseñados para simplificar la gestión de tu infraestructura y entorno de desarrollo. Si tienes alguna pregunta o necesitas asistencia, no dudes en preguntar.
