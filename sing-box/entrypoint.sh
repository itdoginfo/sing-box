#!/bin/sh

mustpl -d '{"SERVER": "${SERVER:-SET_SERVER}", "PUBLIC_KEY": "${PUBLIC_KEY:-SET_PUBLIC_KEY}", "NAME": "${NAME:-user}"}' -o /bin/show /opt/show-template
chmod +x /bin/show

if [ ! -f /etc/sing-box/config.json ]; then
    mustpl -d '{"UUID": "${UUID:-SET_UUID}", "PRIVATE_KEY": "${PRIVATE_KEY:-SET_PRIVATE_KEY}", "SHORT_ID": "${SHORT_ID}", "FAKE_SERVER": "${SERVER}", "PORT": "${PORT:-443}", "NAME": "${NAME:-user}"}}' -o /etc/sing-box/config.json /opt/config-template-vless.json
fi

exec "$@"