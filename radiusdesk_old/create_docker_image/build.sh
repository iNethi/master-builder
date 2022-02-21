#!bin/sh

docker build ./ -t radiusdesk3-php7-ubuntu16-supervisord-v3
docker run --restart unless-stopped --name  radiusdeskv3.0 -it radiusdesk3-php7-ubuntu16-supervisord-v3
