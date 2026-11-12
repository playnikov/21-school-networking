FROM nginx

COPY nginx.conf /etc/nginx/
COPY build.sh /
COPY server.c /

RUN apt-get update &&  \
    apt-get install -y gcc spawn-fcgi libfcgi-dev && \ 
    gcc server.c -o part4 -l fcgi && \
    chmod +x /build.sh

ENTRYPOINT ["./build.sh"]