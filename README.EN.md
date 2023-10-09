Docker image for shadowsocks2022 proxy server

## Install
```
mkdir sing-box && cd sing-box && wget https://raw.githubusercontent.com/itdoginfo/sing-box/main/docker-compose.yml
```

Generate password
```
docker run itdoginfo/sing-box:v1.5.2 gen
```

Paste the received password in the environment variable PASS.
Specify the domain or IP address server.
For example:
```
    environment:
      PASS: "ta87nmRO+LYN0P3Wx57ZTw=="
      SERVER: proxy.itdog.info
```

Container up
```
docker compose up -d
```
Available environment variables:
- [METHOD](https://sing-box.sagernet.org/configuration/outbound/shadowsocks/#method)
- PASS
- PORT

## Configure clients
Get configs for clients devices
```
docker exec sing-box show
```

## Multi-accounting
In docker-compose.yml uncomment
```
    # volumes:
    #  - ./config:/etc/sing-box/
```

Generate mainpass and passwords for users
```
docker run itdoginfo/sing-box:v1.5.2 gen
```

Specify this passwords in `config/config.json`. You can use any name you want. They will be displayed on the device when you add them

With the container up, you have to down\up