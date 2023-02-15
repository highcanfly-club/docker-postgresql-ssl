FROM postgres:latest as builder
# Install latest su-exec
RUN  set -ex; \
     fetch_deps='gcc libc-dev curl'; \
     apt-get update; \
     apt-get install -y --no-install-recommends $fetch_deps; \
        \
     curl -k -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     rm -rf /var/lib/apt/lists/*; \
     gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps

FROM postgres:latest
COPY docker-entrypoint.sh /usr/local/bin/
COPY nfsd.sh /usr/local/bin/
COPY --from=builder /usr/local/bin/su-exec /usr/local/bin/su-exec
RUN  set -ex; apt-get update && apt-get install -y openssl nfs-kernel-server &&\
        echo "/var/lib/postgresql               0.0.0.0/0(rw,sync,no_wdelay,root_squash,insecure,no_subtree_check,fsid=0)" > /etc/exports &&\
        mkdir -p /var/lib/nfs &&\
        chmod ugo+rwx /var/lib/nfs &&\
        chmod +x /usr/local/bin/docker-entrypoint.sh &&\
        chmod +x /usr/local/bin/nfsd.sh
RUN  
ENTRYPOINT ["docker-entrypoint.sh"]
STOPSIGNAL SIGINT

EXPOSE 5432
CMD ["postgres"]