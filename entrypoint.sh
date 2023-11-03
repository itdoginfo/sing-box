#!/bin/sh

mustpl -d '{"SERVER": "${SERVER:-SET_SERVER}", "PUBLIC_KEY": "${PUBLIC_KEY:-SET_PUBLIC_KEY}"}' -o /bin/show /opt/show-template
chmod +x /bin/show

if [ ! -f /etc/sing-box/config.json ] && [ "${PROTOCOL}" = "shadowsocks" ]; then
    mustpl -d '{"METHOD": "${METHOD:-2022-blake3-aes-128-gcm}", "PASS": "${PASS:-SET_PASSWORD}", "PORT": "${PORT:-443}"}' -o /etc/sing-box/config.json /opt/config-template-shadowsocks.json
elif [ ! -f /etc/sing-box/config.json ] && [ "${PROTOCOL}" = "vless" ]; then
    mustpl -d '{"UUID": "${UUID:-SET_UUID}", "PRIVATE_KEY": "${PRIVATE_KEY:-SET_PRIVATE_KEY}", "SHORD_ID": "${SHORD_ID:-153bb5b1383b79fd}", "FAKE_SERVER": "${FAKE_SERVER:-www.google.com}", "PORT": "${PORT:-443}"}' -o /etc/sing-box/config.json /opt/config-template-vless.json
fi

exec "$@"