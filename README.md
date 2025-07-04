[![Docker pulls](https://img.shields.io/docker/pulls/itdoginfo/sing-box?logo=docker&style=flat-square)](https://hub.docker.com/r/itdoginfo/sing-box)
[![GitHub stars](https://img.shields.io/github/stars/itdoginfo/sing-box?logo=github&style=flat-square)](https://github.com/itdoginfo/sing-box/)

[English README](https://github.com/itdoginfo/sing-box/blob/main/README.EN.md)

# Self-masked VLESS+Reality sever via Sing-box

UPD 4.07.2025 Начинаяя с образа 1.11.14 убран Shadowsocks2022. Остался только в команде `show`, если вы используйте свой конфиг sing-box.

## Требования
- VPS с docker
- Домен

## Установка
```
mkdir sing-box && cd sing-box && wget https://raw.githubusercontent.com/itdoginfo/sing-box/main/docker-compose.yml
```

Сгенерировать UIID, Private и public keys, Short ID
```
docker run itdoginfo/sing-box:v1.11.4 gen-vless
```

Вставить полученные значения и ваш домен в environment docker-compose.

Поднять контейнер
```
docker compose up -d
```

## Настройка клиентов
Получить данные для настройки устройств
```
docker exec sing-box show
```

## Работа с несколькими аккаунтами
В docker-compose.yml раскомментировать
```
    # volumes:
    #  - ./config:/etc/sing-box/
```

Скачать темплейт конфига
```
mkdir config && wget -O config/config.json https://raw.githubusercontent.com/itdoginfo/sing-box/main/config-examples/some-users.json
```

При своём конфиге в docker-compose нужны только переменные `SERVER` и `PUBLIC_KEY`.

Сгенерировать ключи, short_id и первый UUID
```
docker run itdoginfo/sing-box:v1.11.14 gen-vless
```

`PrivateKey`, `SHORT_ID` подставить в объект **tls**.
`PublicKey` в переменную docker-compose **PUBLIC_KEY**.

`UUID` проставить первому юзеру. Для второго юзера снова запустить команду `gen-vless`. Для последующих юзеров брать только UUID. `PrivateKey`, `PublicKey`, `SHORT_ID` общие для всех.

## Dev mode
```
docker compose -f docker-compose-dev.yml build
docker compose -f docker-compose-dev.yml up
```

## Похожие проекты
- [Akiyamov/xray-vps-setup](https://github.com/Akiyamov/xray-vps-setup) Скрипт и Ansible-playbook для установки Xray с steal-self
- [vernette/steal-oneself-examples](https://github.com/vernette/steal-oneself-examples) Примеры конфигов Xray и Sing-box для steal-self