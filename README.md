[![Docker Hub](https://img.shields.io/badge/%20-DockerHub-blue?logo=docker)](https://hub.docker.com/r/itdoginfo/sing-box)
![Docker Pulls](https://img.shields.io/docker/pulls/itdoginfo/sing-box)

[![Docker Hub](https://img.shields.io/badge/%20-GitHub-black?logo=github)](https://github.com/itdoginfo/sing-box)
![GitHub Repo stars](https://img.shields.io/github/stars/itdoginfo/sing-box)

[English README](https://github.com/itdoginfo/sing-box/blob/main/README.EN.md)

Docker image для поднятия proxy-сервера c технологиями shadowsocks2022 и VLESS.

## Установка
```
mkdir sing-box && cd sing-box && wget https://raw.githubusercontent.com/itdoginfo/sing-box/main/docker-compose.yml
```

### Shadowsocks2022
Сгенерировать пароль
```
docker run itdoginfo/sing-box:v1.9.3 gen-ss
```

Вставить полученный пароль в environment PASS.
Там же указать домен сервера или его IP-адрес.
Указать, что это shadowsocks

Пример:
```
    environment:
      PROTOCOL: shadowsocks
      PASS: "ta87nmRO+LYN0P3Wx57ZTw=="
      SERVER: proxy.itdog.info
```

Поднять контейнер
```
docker compose up -d
```

Доступные env переменные:
- SERVER (обязательная)
- PASS (обязательная)
- [METHOD](https://sing-box.sagernet.org/configuration/outbound/shadowsocks/#method)
- PORT
- NAME (config name)

### VLESS
Сгенерировать UIID, Private и public keys, Short ID
```
docker run itdoginfo/sing-box:v1.9.3 gen-vless
```

Вставить полученные значения в environment.
Там же указать домен сервера или его IP-адрес.
Указать, что это vless.
Подобрать сайт, под который будет производиться маскировка (HTTP2, TLS 1.3, не заблокирован).

Пример:
```
    environment:
      PROTOCOL: vless
      SERVER: proxy.itdog.info
      UUID: 71c48bba-6b5d-484d-83ef-b047ab96f1a3
      PRIVATE_KEY: KCaRO6tGf6dLXH21HOJkPaKYQAG64WdR4JVHx41TLnc
      PUBLIC_KEY: 3h_XmVpREusSRsLo8ii3GtIpGZf-2cP5iBrQ7uzVm2Q
      SHORT_ID: b627ec56b4f8ff40
      FAKE_SERVER: www.youtube.com
```

Поднять контейнер
```
docker compose up -d
```

Доступные env переменные:
- SERVER (обязательная)
- UUID (обязательная)
- PRIVATE_KEY (обязательная)
- PUBLIC_KEY (обязательная)
- SHORT_ID
- FAKE_SERVER
- PORT
- NAME (config name)

## Настройка клиентов
Получить данные для настройки устройств
```
docker exec sing-box show
```

# Работа с несколькими аккаунтами
В docker-compose.yml раскоментировать
```
    # volumes:
    #  - ./config:/etc/sing-box/
```

Скачать темплейт конфига
```
mkdir config && wget -O config/config.json https://raw.githubusercontent.com/itdoginfo/sing-box/main/config/config.json
```

При своём конфиге в docker-compose нужны только переменные SERVER(SS2022, VLESS) и PUBLIC_KEY(VLESS).

## Shadowsocks2022

Сгенерировать mainpass и пароли для юзеров
```
docker run itdoginfo/sing-box:v1.9.3 gen-ss
```

Проставить их в `config/config.json`. Имена для юзеров любые, они будут отображаться при добавлении конфига на устройство.

При уже поднятом контейнере без volume требуется down\up.

При добавлении\удалении пользователей требуется рестарт sing-box
```
docker restart sing-box
```

# VLESS
Сгенерировать ключи, short_id и первый UUID
```
docker run itdoginfo/sing-box:v1.9.3 gen-vless
```
PrivateKey, SHORT_ID подставить в объект **tls**.
PublicKey в переменную docker-compose **PUBLIC_KEY**.

UUID проставить первому юзеру. Для второго юзера снова запустить команду gen-vless. Брать только UUID для следующих юзеров. PrivateKey, PublicKey, SHORT_ID общие для всех.

Пример конфигурации с двумя юзерами для SS2022 и VLESS: https://github.com/itdoginfo/sing-box/blob/main/config/config.json

# Dev mode
```
docker compose -f docker-compose-dev.yml build
docker compose -f docker-compose-dev.yml up
```