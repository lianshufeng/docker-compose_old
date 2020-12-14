FROM python:alpine
RUN pip3 install --upgrade pip
RUN pip install docker-compose


COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]