#!/bin/bash


mkdir -p ~/bin/openapitools


apt update
apt install -y curl maven jq
curl https://raw.githubusercontent.com/OpenAPITools/openapi-generator/master/bin/utils/openapi-generator-cli.sh > ~/bin/openapitools/openapi-generator-cli


chmod u+x ~/bin/openapitools/openapi-generator-cli

export PATH=$PATH:~/bin/openapitools/

curl $INPUT_URL > spec.json

openapi-generator-cli generate -i spec.json -g $INPUT_GENERATOR -o $INPUT_OUTPUT_DIR
