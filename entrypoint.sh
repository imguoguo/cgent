#!/bin/sh
CONFIG_FILE="/app/config.yml"
if [ -f "$CONFIG_FILE" ]; then
    UUID=$(awk -F': ' '/uuid:/ {print $2}' "$CONFIG_FILE" | tr -d "'")
    if [ -z "$UUID" ]; then
        UUID=$(uuidgen)
    fi
else
    UUID=$(uuidgen)
fi
Z
cat <<EOF > "$CONFIG_FILE"
client_secret: ${SECRET}
server: '${SERVER}'
tls: ${TLS}
uuid: ${UUID}
EOF

exec /cgent -c="$CONFIG_FILE"
