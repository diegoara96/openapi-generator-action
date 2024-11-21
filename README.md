# OpenAPI Generator Action

Esta acción de GitHub permite generar documentación OpenAPI en formato HTML (o cualquier otro formato soportado por OpenAPI Generator) a partir de una especificación OpenAPI. Puedes proporcionar la especificación a través de una URL (para obtenerla desde un backend) o a partir de un archivo JSON ya existente.

## Entrada

### `backend-url` (Opcional)
- **Descripción**: La URL desde donde se puede obtener la especificación OpenAPI (por ejemplo, `http://localhost:8090/v3/api-docs`).
- **Valor por defecto**: Ninguno.
- **Requerido**: No.
- **Comportamiento**: Si se proporciona una URL, la acción descargará la especificación desde esa URL.

### `spec-file` (Opcional)
- **Descripción**: Ruta al archivo JSON que contiene la especificación OpenAPI.
- **Valor por defecto**: Ninguno.
- **Requerido**: No.
- **Comportamiento**: Si se proporciona un archivo JSON, la acción utilizará ese archivo directamente, sin descargar nada.

### `output-dir`
- **Descripción**: El directorio donde se generarán los archivos de documentación.
- **Valor por defecto**: `./docs`
- **Requerido**: No.

### `generator`
- **Descripción**: El generador que se utilizará para generar la documentación. Los valores posibles incluyen `html2`, `markdown`, `pdf`, etc. Por defecto se usará `html2`.
- **Valor por defecto**: `html2`
- **Requerido**: No.

## Ejemplo de uso

### Usando una URL

Si prefieres que la acción descargue automáticamente la especificación desde una URL, usa el siguiente ejemplo:

```yaml
name: 'Generar Documentación OpenAPI'

on:
  push:
    branches:
      - main

jobs:
  generate-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout del código
        uses: actions/checkout@v2

      - name: Generar documentación OpenAPI desde URL
        uses: <tu-usuario>/<tu-repo>@v1
        with:
          backend-url: 'http://backend:8090/v3/api-docs'  # URL de la especificación
          output-dir: './generated-docs'
          generator: 'html2'
```

### Usando un archivo JSON

Si ya tienes un archivo JSON con la especificación OpenAPI, puedes usarlo directamente como en el siguiente ejemplo:

```yaml
name: 'Generar Documentación OpenAPI'

on:
  push:
    branches:
      - main

jobs:
  generate-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout del código
        uses: actions/checkout@v2

      - name: Generar documentación OpenAPI desde archivo JSON
        uses: <tu-usuario>/<tu-repo>@v1
        with:
          spec-file: './spec.json'  # Archivo JSON de la especificación OpenAPI
          output-dir: './generated-docs'
          generator: 'html2'
```

### Notas

- Si se proporcionan tanto `backend-url` como `spec-file`, la acción priorizará el archivo JSON (`spec-file`).
- Si no se proporciona ni una URL ni un archivo JSON, la acción fallará y mostrará un mensaje de error.
- El valor por defecto para el generador es `html2`, pero puedes cambiarlo a otro tipo de generador compatible con OpenAPI Generator, como `markdown`, `html`, `pdf`, etc.

## Requisitos

- La acción instalará `curl`, `jq` y otras dependencias necesarias solo si se usa la URL para descargar la especificación. Si se usa un archivo JSON, no se instalarán herramientas adicionales.
