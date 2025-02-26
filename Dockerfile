FROM alpine:latest

RUN apk add --no-cache util-linux unzip

RUN wget https://github.com/nezhahq/agent/releases/download/v1.7.3/nezha-agent_linux_$(arch).zip && unzip nezha-agent_linux_$(arch).zip && rm nezha-agent_linux_$(arch).zip

ENV SECRET=default_secret \
    SERVER=default_server \
    TLS=false

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]