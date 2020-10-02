#!/usr/bin/env bash


if [ -n "$CERTS" ]; then
    certbot certonly --manual --no-self-upgrade --keep \
    --preferred-challenges=dns --email "$EMAIL"  \
    --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d "$CERTS" \
    || exit 1
    
    mkdir -p /etc/haproxy/certs
    for site in `ls -1 /etc/letsencrypt/live | grep -v ^README$`; do
        cat /etc/letsencrypt/live/$site/privkey.pem \
          /etc/letsencrypt/live/$site/fullchain.pem \
          | tee /etc/haproxy/certs/haproxy-"$site".pem >/dev/null
    done
fi

exit 0