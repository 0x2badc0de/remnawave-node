# remnawave-node

A Docker image of **Remnawave Node** with the bundled Xray binary replaced by a newer version from the official `ghcr.io/xtls/xray-core` image.

The image is based on the official `ghcr.io/remnawave/node` image. Its original entrypoint, configuration, and runtime behavior are preserved.

## How it works

GitHub Actions periodically checks the latest stable releases of:

* Remnawave Node
* Xray-core

When a new combination is found, a multi-platform image is built for:

* `linux/amd64`
* `linux/arm64`

The Xray binary is copied from the official XTLS image using a multi-stage Docker build.

## Image tags

```text
ghcr.io/0x2badc0de/remnawave-node:latest
ghcr.io/0x2badc0de/remnawave-node:<xray-version>
ghcr.io/0x2badc0de/remnawave-node:remna-<remna-version>-xray-<xray-version>
```

Use `latest` for automatic updates or the combined version tag for a fixed deployment.

## Docker Compose

Replace the original Remnawave Node image in your Compose file:

```yaml
services:
  remnanode:
    #image: remnawave/node:latest # <-- comment this line if you plan to move back to original package
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

Update the container with:

```bash
docker compose pull remnanode
docker compose up -d remnanode
```

## Disclaimer

This project is not affiliated with Remnawave or XTLS.

The image is built from official upstream images. A new Xray release may not always be fully compatible with the current Remnawave Node release.
