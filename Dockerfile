ARG PYTHON_VERSION=3.9
ARG ALPINE_VERSION=alpine
ARG DOCKER_VERSION=latest


# docker-compose
FROM python:${PYTHON_VERSION}-${ALPINE_VERSION} AS builder

RUN apk update 
RUN apk add --no-cache --virtual .build-deps \
    bash \
    build-base \
    ca-certificates \
    curl \
    gcc \
    git \
    libc-dev \
    libffi-dev \
    libgcc \
    make \
    musl-dev \
    openssl \
    openssl-dev \
    zlib-dev \
    rust \
    cargo


RUN pip install --no-cache-dir docker-compose

# docker-cli
FROM docker:${DOCKER_VERSION} AS docker-cli


# 运行环境
FROM python:${PYTHON_VERSION}-${ALPINE_VERSION} 
COPY --from=builder /usr/local/bin/docker-compose /usr/local/bin/docker-compose
COPY --from=builder /usr/local/lib/python3.10/site-packages/ /usr/local/lib/python3.10/site-packages
COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker


COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]