FROM centos:8

RUN yum install make gcc python3 python3-devel -y
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN pip3 install --upgrade pip
RUN pip install docker-compose

COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]