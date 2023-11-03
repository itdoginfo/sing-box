ARG RELEASE
FROM ghcr.io/sagernet/sing-box:${RELEASE} AS sing-box

FROM alpine:3.18.4

RUN apk add --no-cache libqrencode jq coreutils bash && mkdir -p /etc/sing-box/

COPY --from=sing-box /usr/local/bin/sing-box /bin/sing-box
COPY --from=ghcr.io/tarampampam/mustpl:0.1.1 /bin/mustpl /bin/mustpl
COPY entrypoint.sh config-template* show-template /opt/
COPY gen* /bin/

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["sing-box", "--config", "/etc/sing-box/config.json", "run"]