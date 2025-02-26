#!/bin/sh
CONFIG_FILE="/app/config.yml"
if [ ! -f "$CONFIG_FILE" ]; then
    UUID=$(uuidgen)
    cat <<EOF > "$CONFIG_FILE"
client_secret: ${SECRET}
server: '${SERVER}'
tls: ${TLS}
uuid: ${UUID}
EOF

fi

exec /nezha-agent -c="$CONFIG_FILE"