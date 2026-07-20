ARG REMNA_VERSION
ARG XRAY_VERSION

FROM ghcr.io/xtls/xray-core:${XRAY_VERSION} AS xray

FROM ghcr.io/remnawave/node:${REMNA_VERSION}

ARG REMNA_VERSION
ARG XRAY_VERSION

COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray

LABEL org.opencontainers.image.title="Remnawave Node with updated Xray"
LABEL io.remnawave.version="${REMNA_VERSION}"
LABEL io.xray.version="${XRAY_VERSION}"

RUN /usr/local/bin/xray version
