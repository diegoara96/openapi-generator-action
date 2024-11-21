FROM ubuntu:latest

# Instalación de dependencias necesarias
RUN apt update && apt install -y curl maven jq

# Copia el script entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]