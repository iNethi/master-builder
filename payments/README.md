# dockerized-production-flask-api
This repo contains a flask API to process _1FORYOU_ payments called from the HTML code block provided.
The for development and production environment uses WordPress, Traefik (with Let's Encrypt Capabilities), 
Flask and Gunicorn.

It has been created as part of [iNethi's](https://www.inethi.org.za) ongoing mission to enable community built ISPs.
Find all the code for building a community ISP [here](https://github.com/iNethi).

## How to Use
### With the Build Script
1. Edit the environment variables to your liking and the redeem endpoints to contain your 1FORYOU account details
2. Run the build script and follow the instructions on screen:
### Without the Build Script
#### Production Environment
1. Run the following command from the traefik folder:
```
docker-compouse up -d
```
2. Run the following command from the root folder:
```
docker-compose -f docker-compose.prod.yml up -d --build
```
Note that in the production build we use a Docker multi-stage build to reduce the final image size. Essentially, builder is a temporary image that's used for building the Python wheels. The wheels are then copied over to the final production image and the builder image is discarded.
It is also important to note that we create a non-root user in this dockerfile.

#### Development Environment
1. Run the following command from the traefik folder:
```
docker-compouse up -d
```
2. Run the following command from the root folder:
```
docker-compose up -d --build
```
