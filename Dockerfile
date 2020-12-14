#FROM alpine:3

#RUN yum install make gcc python3 python3-devel -y
#RUN ln -sf /usr/bin/python3 /usr/bin/python
#RUN pip3 install --upgrade pip
#RUN pip install docker-compose

#切换阿里的源
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

FROM alpine:3
RUN cat /etc/resolv.conf
RUN ping 39.156.69.79
RUN apk update
#RUN pip3 install --upgrade pip
#RUN pip install docker-compose




COPY docker-compose-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/docker-compose-entrypoint.sh"]