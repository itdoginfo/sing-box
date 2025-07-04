[![Docker pulls](https://img.shields.io/docker/pulls/itdoginfo/sing-box?logo=docker&style=flat-square)](https://hub.docker.com/r/itdoginfo/sing-box)
[![GitHub stars](https://img.shields.io/github/stars/itdoginfo/sing-box?logo=github&style=flat-square)](https://github.com/itdoginfo/sing-box/)

# Self-masked VLESS+Reality server via Sing-box

**UPD 2025-07-04:** Shadowsocks2022 has been removed. It is now only available in the `show` command (for generating links) if you use your own config.

## Requirements
- VPS with Docker
- Domain name

## Installation
```
mkdir sing-box && cd sing-box && wget https://raw.githubusercontent.com/itdoginfo/sing-box/main/docker-compose.yml
```

Generate UUID, private and public keys, and short ID:
```
docker run itdoginfo/sing-box:v1.11.4 gen-vless
```

Insert the generated values and your domain into the `environment` section of `docker-compose.yml`.

Start the container:
```
docker compose up -d
```

## Client configuration
Get connection details for your devices:
```
docker exec sing-box show
```

## Working with multiple accounts
In `docker-compose.yml`, uncomment:
```
    # volumes:
    #  - ./config:/etc/sing-box/
```

Download the config template:
```
mkdir config && wget -O config/config.json https://raw.githubusercontent.com/itdoginfo/sing-box/main/config-examples/some-users.json
```

If you use your own config, only the `SERVER` and `PUBLIC_KEY` variables are required in `docker-compose.yml`.

Generate keys, short_id, and the first UUID:
```
docker run itdoginfo/sing-box:v1.11.14 gen-vless
```

Insert `PrivateKey` and `SHORT_ID` into the **tls** object.  
Insert `PublicKey` into the **PUBLIC_KEY** variable in `docker-compose.yml`.

Set the UUID for the first user. For the second user, run `gen-vless` again. For additional users, only use the UUID. `PrivateKey`, `PublicKey`, and `SHORT_ID` are common for all users.

## Dev mode
```
docker compose -f docker-compose-dev.yml build
docker compose -f docker-compose-dev.yml up
```

## Related Projects
- [Akiyamov/xray-vps-setup](https://github.com/Akiyamov/xray-vps-setup) — Script and Ansible playbook for installing Xray with steal-self
- [vernette/steal-oneself-examples](https://github.com/vernette/steal-oneself-examples) — Example Xray and Sing-box configurations for steal-self