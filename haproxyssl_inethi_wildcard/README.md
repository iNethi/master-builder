# iNethi haproxy ssl

This docker builds an ssl version of haproxy

# Usage
Make sure you do the following before running the docker build

customize the haproxy.cfg and copy it to /mnt/data/haproxyssl  
```
cp haproxy.cfg /mnt/data/haproxyssl
vi /mnt/data/haproxyssl/haproxy.cfg
```
Also make sure you customize the .env file
```
vi .env
HAPROXYSSL_DOMAIN=<change to your list of domains>
```
