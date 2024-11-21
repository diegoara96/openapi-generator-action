FROM ubuntu:latest
COPY entrypoint.sh /entrypoint.sh
ADD https://raw.githubusercontent.com/OpenAPITools/openapi-generator/master/bin/utils/openapi-generator-cli.sh  /usr/local/bin/openapi-generator-cli
RUN apt update && apt install -y curl jq maven && apt-get clean && \
chmod u+x /usr/local/bin/openapi-generator-cli && \
chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]