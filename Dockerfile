FROM ubuntu:latest
RUN apt update && apt install -y curl maven jq
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN   mkdir -p ~/bin/openapitools && \
      curl https://raw.githubusercontent.com/OpenAPITools/openapi-generator/master/bin/utils/openapi-generator-cli.sh > ~/bin/openapitools/openapi-generator-cli && \
      chmod u+x ~/bin/openapitools/openapi-generator-cli && \
      export PATH=$PATH:~/bin/openapitools/
ENTRYPOINT ["/entrypoint.sh"]