[![Docker Hub](https://img.shields.io/badge/%20-DockerHub-blue?logo=docker)](https://hub.docker.com/r/itdoginfo/sing-box)
![Docker Pulls](https://img.shields.io/docker/pulls/itdoginfo/sing-box)

[![Docker Hub](https://img.shields.io/badge/%20-GitHub-black?logo=github)](https://github.com/itdoginfo/sing-box)
![GitHub Repo stars](https://img.shields.io/github/stars/itdoginfo/sing-box)

Docker image for shadowsocks2022 and VLESS proxy server

## Install
```
mkdir sing-box && cd sing-box && wget https://raw.githubusercontent.com/itdoginfo/sing-box/main/docker-compose.yml
```

### Shadowsocks2022
Generate password
```
docker run itdoginfo/sing-box:v1.6.0 gen-ss
```

Paste the received password in the environment variable PASS.
Specify the domain or IP address server.
Specify protocol shadowsocks.

For example:
```
    environment:
      PROTOCOL: shadowsocks
      PASS: "ta87nmRO+LYN0P3Wx57ZTw=="
      SERVER: proxy.itdog.info
```

Container up
```
docker compose up -d
```
Available environment variables:
- SERVER (required)
- PASS (required)
- [METHOD](https://sing-box.sagernet.org/configuration/outbound/shadowsocks/#method)
- PORT

### VLESS
Generate UIID, Private and public keys, Short ID
```
docker run itdoginfo/sing-box:v1.6.0 gen-vless
```

Paste the received values in the environment.
Specify the domain or IP address server.
Specify protocol vless.
Specify site to mask the traffic (HTTP2, TLS 1.3, unblocked).

For example:
```
    environment:
      PROTOCOL: vless
      SERVER: proxy.itdog.info
      UUID: 71c48bba-6b5d-484d-83ef-b047ab96f1a3
      PRIVATE_KEY: KCaRO6tGf6dLXH21HOJkPaKYQAG64WdR4JVHx41TLnc
      PUBLIC_KEY: 3h_XmVpREusSRsLo8ii3GtIpGZf-2cP5iBrQ7uzVm2Q
      SHORD_ID: b627ec56b4f8ff40
      FAKE_SERVER: www.youtube.com
```

Container up
```
docker compose up -d
```

Available environment variables:
- SERVER (required)
- UUID (required)
- PRIVATE_KEY (required)
- PUBLIC_KEY (required)
- SHORD_ID
- FAKE_SERVER
- PORT

## Configure clients
Get configs for clients devices
```
docker exec sing-box show
```

## Multi-accounting on Shadowsocks2022
In docker-compose.yml uncomment
```
    # volumes:
    #  - ./config:/etc/sing-box/
```

Download template config
```
mkdir config && wget -O config/config.json https://raw.githubusercontent.com/itdoginfo/sing-box/main/config/config.json
```

Generate mainpass and passwords for users
```
docker run itdoginfo/sing-box:v1.6.0 gen-ss
```

Specify this passwords in `config/config.json`. You can use any name you want. They will be displayed on the device when you add them

With the container without volume up, you have to down\up.

Adding/removing users requires restarting the sing-box
```
docker restart sing-box
```

## Multi-accounting on VLESS
Example coming soon