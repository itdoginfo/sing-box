FROM caddy:2.10.0-alpine

COPY --from=ghcr.io/tarampampam/mustpl:0.1.1 /bin/mustpl /bin/mustpl
COPY srv/ /srv/
COPY Caddyfile-template entrypoint.sh /opt/

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]