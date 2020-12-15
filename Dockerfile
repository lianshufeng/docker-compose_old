ARG PYTHON_VERSION=3.9.1
ARG PYTHON_FOLDER=python3.9

#编译环境
FROM python:${PYTHON_VERSION}-alpine AS build


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

RUN pip install --no-cache-dir docker-compose
RUN apk del .build-deps \
	&& rm -rf /var/cache/apk/*


# 运行环境
FROM python:${PYTHON_VERSION}-alpine
COPY --from=builder /usr/local/bin/docker-compose /usr/local/bin/docker-compose
COPY --from=builder /usr/local/lib/${PYTHON_FOLDER}/site-packages/ /usr/local/lib/${PYTHON_FOLDER}/site-packages



COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]