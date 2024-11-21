#!/bin/bash

URL=$1
SPEC_FILE=$2
OUTPUT_DIR=$3
GENERATOR=$4

if [ -n "$URL" ]; then
  echo "Downloading the OpenAPI specification from the provided URL..."
  curl -s $URL -o spec.json
fi

if [ -n "$SPEC_FILE" ]; then
  echo "Using the provided JSON file: $SPEC_FILE"
  cp $SPEC_FILE spec.json
fi

if [ ! -f spec.json ]; then
  echo "Error: Neither a URL nor a JSON file was provided. Please specify one of the two."
  exit 1
fi

echo "Generating documentation with OpenAPI Generator..."
openapi-generator-cli generate -i spec.json -g $GENERATOR -o $OUTPUT_DIR
