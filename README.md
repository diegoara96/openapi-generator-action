# OpenAPI Generator Action

Esta acción permite generar documentación OpenAPI en formato HTML a partir de una especificación OpenAPI.

## Entrada

### `backend-url`
- **Descripción**: La URL del backend donde se encuentra la especificación OpenAPI.
- **Valor por defecto**: `http://localhost:8090/v3/api-docs`
- **Requerido**: Sí

### `output-dir`
- **Descripción**: El directorio donde se generarán los archivos de documentación.
- **Valor por defecto**: `./docs`
- **Requerido**: No

## Ejemplo de uso

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

      - name: Generar documentación OpenAPI
        uses: diegoara96/openapi-generator-action@v1
        with:
          backend-url: 'http://backend:8090/v3/api-docs'
          output-dir: './generated-docs'
