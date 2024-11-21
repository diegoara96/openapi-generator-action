#!/bin/bash

URL=$1
SPEC_FILE=$2
OUTPUT_DIR=$3
GENERATOR=$4

# Function to validate URL
validate_url() {
  if [[ $1 =~ ^https?://[a-zA-Z0-9.-]+(:[0-9]+)?(/.*)?$ ]]; then
    return 0
  else
    return 1
  fi
}

# Function to validate file path
validate_file() {
  if [[ -f $1 ]]; then
    return 0
  else
    return 1
  fi
}

# Function to validate output directory
validate_output_dir() {
  if [[ $1 =~ \.\. ]]; then
    return 1
  else
    return 0
  fi
}

# Function to validate generator
validate_generator() {
  local valid_generators=$(openapi-generator-cli list | tr ',' '\n')
  for generator in $valid_generators; do
    if [[ $1 == $generator ]]; then
      return 0
    fi
  done
  return 1
}

# Validate URL if provided
if [ -n "$URL" ]; then
  if ! validate_url "$URL"; then
    echo "Error: Invalid URL format."
    exit 1
  fi
  echo "Downloading the OpenAPI specification from the provided URL..."
  curl -s -k "$URL" -o spec.json
fi

# Validate SPEC_FILE if provided
if [ -n "$SPEC_FILE" ]; then
  if ! validate_file "$SPEC_FILE"; then
    echo "Error: Specified JSON file does not exist."
    exit 1
  fi
  echo "Using the provided JSON file: $SPEC_FILE"
  cp "$SPEC_FILE" spec.json
fi

# Ensure at least one of URL or SPEC_FILE is provided
if [ ! -f spec.json ]; then
  echo "Error: Neither a URL nor a JSON file was provided. Please specify one of the two."
  exit 1
fi

# Validate OUTPUT_DIR
if [ -n "$OUTPUT_DIR" ]; then
  if ! validate_output_dir "$OUTPUT_DIR"; then
    echo "Error: Invalid output directory specified."
    exit 1
  fi
else
  OUTPUT_DIR="./docs"
fi

# Validate GENERATOR
if [ -n "$GENERATOR" ]; then
  if ! validate_generator "$GENERATOR"; then
    echo "Error: Invalid generator specified."
    exit 1
  fi
else
  GENERATOR="html2"
fi

echo "Generating documentation with OpenAPI Generator..."
openapi-generator-cli generate -i spec.json -g "$GENERATOR" -o "$OUTPUT_DIR"