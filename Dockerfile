FROM postgres:15-alpine
COPY docker-entrypoint.sh /usr/local/bin/
RUN  set -ex; apk add openssl &&\
        chmod +x /usr/local/bin/docker-entrypoint.sh
RUN  
ENTRYPOINT ["docker-entrypoint.sh"]
STOPSIGNAL SIGINT

EXPOSE 5432
CMD ["postgres"]