FROM ubuntu:latest
RUN apt update && apt install -y curl maven jq
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]