#!/usr/bin/env bash

mkdir -p /etc/haproxy/certs
for site in `ls -1 /etc/letsencrypt/live | grep -v ^README$`; do
    cat /etc/letsencrypt/live/$site/privkey.pem \
        /etc/letsencrypt/live/$site/fullchain.pem \
        | tee /etc/haproxy/certs/haproxy-"$site".pem >/dev/null
done
#echo Copied all certificates ...

exit 0
