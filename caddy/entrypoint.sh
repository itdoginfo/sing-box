#!/bin/sh

mustpl -d '{"SERVER": "${SERVER:-example.com}", "DEBUG":"${DEBUG:-0}"}' -o /etc/caddy/Caddyfile /opt/Caddyfile-template

cat /etc/caddy/Caddyfile

exec "$@"