FROM postgres:15-alpine
COPY docker-entrypoint.sh /usr/local/bin/
COPY nfsd.sh /usr/local/bin/
RUN  set -ex; apk add openssl nfs-utils &&\
        echo "/var/lib/postgresql               0.0.0.0/0(rw,no_root_squash)" > /etc/exports &&\
        mkdir -p /var/lib/nfs &&\
        chmod ugo+rwx /var/lib/nfs &&\
        chmod +x /usr/local/bin/docker-entrypoint.sh &&\
        chmod +x /usr/local/bin/nfsd.sh
RUN  
ENTRYPOINT ["docker-entrypoint.sh"]
STOPSIGNAL SIGINT

EXPOSE 5432
CMD ["postgres"]