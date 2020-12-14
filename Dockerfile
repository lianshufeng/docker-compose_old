FROM python:alpine

RUN apk update 
RUN apk add --no-cache make gcc libffi-dev musl-dev python3-dev  openssl-dev


RUN pip install cffi
RUN pip3 install --upgrade pip
RUN pip install docker-compose


COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]