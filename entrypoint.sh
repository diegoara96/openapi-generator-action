#!/bin/bash

# Si se proporciona una URL de backend, descargar la especificación JSON
if [ -n "$INPUT_URL" ]; then
  echo "Descargando la especificación OpenAPI desde la URL proporcionada..."
  
  # Instalar dependencias solo si es necesario (solo si se usa la URL)
  apt update
  apt install -y curl jq
  
  # Descargar la especificación OpenAPI usando curl
  curl -s $INPUT_URL -o spec.json
fi

# Si se proporciona un archivo JSON, usarlo directamente
if [ -n "$INPUT_SPEC_FILE" ]; then
  echo "Usando el archivo JSON proporcionado: $INPUT_SPEC_FILE"
  cp $INPUT_SPEC_FILE spec.json
fi

# Si no se tiene un archivo `spec.json`, fallar
if [ ! -f spec.json ]; then
  echo "Error: No se proporcionó ni una URL ni un archivo JSON. Por favor, especifica uno de los dos."
  exit 1
fi

# Generar la documentación utilizando el generador proporcionado
echo "Generando la documentación con OpenAPI Generator..."
openapi-generator-cli generate -i spec.json -g $INPUT_GENERATOR -o $INPUT_OUTPUT_DIR
