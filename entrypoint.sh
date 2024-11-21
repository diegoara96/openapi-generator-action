#!/bin/bash
  apt update
  apt install -y curl jq maven
  mkdir -p ~/bin/openapitools
  curl https://raw.githubusercontent.com/OpenAPITools/openapi-generator/master/bin/utils/openapi-generator-cli.sh > ~/bin/openapitools/openapi-generator-cli
  chmod u+x ~/bin/openapitools/openapi-generator-cli
  export PATH=$PATH:~/bin/openapitools/
if [ -n "$INPUT_URL" ]; then
  echo "Downloading the OpenAPI specification from the provided URL..."
  curl -s $INPUT_URL -o spec.json
fi

if [ -n "$INPUT_SPEC_FILE" ]; then
  echo "Using the provided JSON file: $INPUT_SPEC_FILE"
  cp $INPUT_SPEC_FILE spec.json
fi

if [ ! -f spec.json ]; then
  echo "Error: Neither a URL nor a JSON file was provided. Please specify one of the two."
  exit 1
fi

echo "Generating documentation with OpenAPI Generator..."
openapi-generator-cli generate -i spec.json -g $INPUT_GENERATOR -o $INPUT_OUTPUT_DIR
