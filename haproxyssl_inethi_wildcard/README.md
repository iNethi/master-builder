# iNethi Wildcard haproxy ssl 

This docker builds uses an exisiting certificate setup for *.inethi.net for you to deploy on your local server. Contact the author for certificates before building: inethi4us@gmail.com

# Usage
Make sure you do the following before running the docker build

## customize the haproxy.cfg 

```
...
frontend https
    bind *:443 ssl crt /etc/haproxy/certs/ no-sslv3 no-tls-tickets no-tlsv10 no-tlsv11
    #http-response set-header Strict-Transport-Security "max-age=16000000; includeSubDomains; preload;"

    acl inethi-<your service> ssl_fc_sni <your service>.inethi.net
    use_backend web_<your service> if inethi-<your service>

	default_backend web_<default service>

backend web_<your service>
    mode http
    server inethi-<your service> inethi-<your service>:80

```

For example

```
...
frontend https
    bind *:443 ssl crt /etc/haproxy/certs/ no-sslv3 no-tls-tickets no-tlsv10 no-tlsv11
    #http-response set-header Strict-Transport-Security "max-age=16000000; includeSubDomains; preload;"

    acl inethi-musicshare ssl_fc_sni musicshare.inethi.net
    use_backend web_musicshare if inethi-musicshare

	default_backend web_musicshare

backend web_musicshare
    mode http
    server inethi-musicshare inethi-musicshare:80

```

## Check the .env setup

Make sure the ip address is correct and in the right subnet and that the INETHI_NETWORK points to your network bridge

```
HAPROXYSSL_IPV4=10.2.1.5
HAPROXYSSL_DOMAIN=*.inethi.net 
HAPROXYSSL_EMAIL=inethi4us@gmail.com
HAPROXYSSL_VOLUME=/mnt/data/haproxyssl
INETHI_NETWORK=inethi-bridge
```

## Run the build script

```
./local_build.sh

```