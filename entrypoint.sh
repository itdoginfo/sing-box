#!/bin/sh

mustpl -d '{"SERVER": "${SERVER:-SET_SERVER}"}' -o /bin/show /opt/show-template
chmod +x /bin/show

if [ ! -f /etc/sing-box/config.json ]; then
    mustpl -d '{"METHOD": "${METHOD:-2022-blake3-aes-128-gcm}", "PASS": "${PASS:-SET_PASSWORD}", "PORT": "${PORT:-443}"}' -o /etc/sing-box/config.json /opt/config-template.json
fi

exec "$@"