# remnawave-node

Docker-образ **Remnawave Node**, в котором встроенный бинарник Xray заменяется на более новую версию из официального образа `ghcr.io/xtls/xray-core`.

Образ основан на официальном `ghcr.io/remnawave/node`. Оригинальные параметры запуска, конфигурация и логика работы ноды сохраняются.

## Как это работает

GitHub Actions периодически проверяет последние стабильные версии:

* Remnawave Node
* Xray-core

При появлении новой комбинации собирается multi-platform образ для:

* `linux/amd64`
* `linux/arm64`

Бинарник Xray копируется из официального образа XTLS с помощью multi-stage Docker build.

## Теги образа

```text
ghcr.io/0x2badc0de/remnawave-node:latest
ghcr.io/0x2badc0de/remnawave-node:<версия-xray>
ghcr.io/0x2badc0de/remnawave-node:remna-<версия-remna>-xray-<версия-xray>
```

Используйте `latest` для автоматических обновлений или комбинированный тег для фиксации конкретной версии.

## Docker Compose

Замените оригинальный образ Remnawave Node в Compose-файле:

```yaml
services:
  remnanode:
    #image: remnawave/node:latest # <-- лучше закомментировать строку, чтобы была возможность откатиться
    image: ghcr.io/0x2badc0de/remnawave-node:latest
    container_name: remnanode
    hostname: remnanode
    network_mode: host
    restart: always
    cap_add:
      - NET_ADMIN
    ulimits:
      nofile:
        soft: 1048576
        hard: 1048576
    environment:
      NODE_PORT: "2222"
      SECRET_KEY: "${SECRET_KEY}"
```

Обновление контейнера:

```bash
docker compose pull remnanode
docker compose up -d remnanode
```

## Предупреждение

Проект не связан с разработчиками Remnawave или XTLS.

Образ собирается из официальных upstream-образов. Новая версия Xray не всегда может быть полностью совместима с текущей версией Remnawave Node.
