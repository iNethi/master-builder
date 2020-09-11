#!/usr/bin/env bash

certbot certonly --manual --no-self-upgrade --keep \
 --preferred-challenges=dns --email inethi4us@gmail.com \
 --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.inethi.net

mkdir -p /etc/haproxy/certs
for site in `ls -1 /etc/letsencrypt/live | grep -v ^README$`; do
    cat /etc/letsencrypt/live/$site/privkey.pem \
        /etc/letsencrypt/live/$site/fullchain.pem \
        | tee /etc/haproxy/certs/haproxy-"$site".pem >/dev/null
done


exit 0
