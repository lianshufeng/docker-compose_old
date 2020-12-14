FROM python:alpine

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

RUN pip3 install --upgrade pip
RUN pip install --no-cache-dir cffi docker-compose
RUN apk del .build-deps


COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]