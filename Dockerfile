FROM riscv64/golang:alpine3.21 AS builder
WORKDIR /root

RUN apk add --no-cache git && \
    git clone --depth=1 https://github.com/nezhahq/agent && \
    cd agent && \
    go generate ./... && \
    cd cmd/agent && \
    CGO_ENABLED=0 go build -v -trimpath -ldflags \
    "-s -w -X github.com/nezhahq/agent/pkg/monitor.Version=1.7.3"

FROM alpine:latest
WORKDIR /app

RUN apk add --no-cache util-linux

COPY --from=builder /root/agent/cmd/agent/agent /cgent

ENV SECRET=default_secret \
    SERVER=default_server \
    TLS=false

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
