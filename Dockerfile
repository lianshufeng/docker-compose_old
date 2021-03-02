ARG PYTHON_VERSION=3.9.1
ARG PYTHON_PATH=3.9
ARG ALPINE_VERSION=alpine:3.13


#编译环境
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
    zlib-dev

RUN pip install pep517
RUN pip install -U pip
RUN pip install --no-cache-dir docker-compose


# 运行环境
FROM python:${PYTHON_VERSION}-${ALPINE_VERSION} 
COPY --from=builder /usr/local/bin/docker-compose /usr/local/bin/docker-compose
COPY --from=builder /usr/local/lib/python${PYTHON_PATH}/site-packages/ /usr/local/lib/python${PYTHON_PATH}/site-packages



COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]