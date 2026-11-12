FROM nginx

WORKDIR /home/

COPY nginx.conf /etc/nginx/nginx.conf
COPY build.sh /home/build.sh
COPY server.c /home/server.c

RUN apt-get update && apt-get install -y gcc spawn-fcgi libfcgi-dev; \
    chown -R nginx:nginx /etc/nginx/nginx.conf; \
    chown -R nginx:nginx /var/cache/nginx; \
    chown -R nginx:nginx /home; \
    touch /var/run/nginx.pid; \
    chown -R nginx:nginx /var/run/nginx.pid; \
    rm -rf /var/lib/apt/lists

RUN gcc server.c -o part5 -l fcgi 


USER nginx
ENTRYPOINT ["sh", "./build.sh"]