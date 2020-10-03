# iNethi haproxy ssl

This docker builds an ssl version of haproxy and uses letsencrypt to create a certificate for your domain

# Step 1: Customize
Make sure you do the following before running the docker build

Customize 
customize the haproxy.cfg and copy it to /mnt/data/haproxyssl  
```
cp haproxy.cfg /mnt/data/haproxyssl
vi /mnt/data/haproxyssl/haproxy.cfg
```
Also make sure you customize the .env file
```
vi .env
HAPROXYSSL_DOMAIN=<change to your list of domains or a wildcard domain>
HAPROXYSSL_EMAIL=<change to your email>
HAPROXYSSL_IPV4=<ip address of local build>
HAPROXYSSL_AWS_IPV4=<ip address for build on amazon AWS>
```

Example 1: Wild card certificate for a domain
```
HAPROXYSSL_DOMAIN=*.coolsite.io
HAPROXYSSL_EMAIL=awesomeemail@gmail.com
```

Example 2: Certificate for Subdomains 
```
HAPROXYSSL_DOMAIN=site1.coolsite.io,site2.coolsite.io
HAPROXYSSL_EMAIL=awesomeemail@gmail.com
```

# Step 2: Run

For a local build run
```
./local_build.sh
```

For a build on Amazon
```
./aws_build.sh
```