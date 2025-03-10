FROM alpine:latest

ARG TARGETARCH

RUN apk add --no-cache util-linux unzip

RUN wget https://github.com/nezhahq/agent/releases/download/v1.7.3/nezha-agent_linux_${TARGETARCH}.zip && unzip nezha-agent_linux_${TARGETARCH}.zip && rm nezha-agent_linux_${TARGETARCH}.zip

ENV SECRET=default_secret \
    SERVER=default_server \
    TLS=false

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN adduser -S nezha -G users -s /bin/sh

ENTRYPOINT ["/entrypoint.sh"]