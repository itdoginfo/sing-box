[English README](https://github.com/itdoginfo/sing-box/blob/main/README.EN.md)

Docker image для поднятия proxy-сервера c технологией shadowsocks2022.

## Установка
```
mkdir sing-box && cd sing-box && wget https://raw.githubusercontent.com/itdoginfo/sing-box/main/docker-compose.yml
```

Сгенерировать пароль
```
docker run itdoginfo/sing-box:v1.5.2 gen
```

Вставить полученный пароль в environment PASS.
Там же указать домен сервера или его IP-адрес.

Пример:
```
    environment:
      PASS: "ta87nmRO+LYN0P3Wx57ZTw=="
      SERVER: proxy.itdog.info
```

Поднять контейнер
```
docker compose up -d
```

Доступные env переменные:
- [METHOD](https://sing-box.sagernet.org/configuration/outbound/shadowsocks/#method)
- PASS
- PORT

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

Сгенерировать mainpass и пароли для юзеров
```
docker run itdoginfo/sing-box:v1.5.2 gen
```

Проставить их в `config/config.json`. Имена для юзеров любые, они будут отображаться при добавлении конфига на устройство.

При уже поднятом контейнере требуется down\up