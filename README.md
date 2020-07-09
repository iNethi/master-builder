# docker-master
All docker compose files live here

First build mysql docker and then build other dockers

Local dockers on local server machine are build with local_build.sh in each docker folder
Amazon AWS dockers on an Amazon EC2 mchine are built with aws_build.sh in each docker folder


Network
Local server bridge: 10.2.1.1/16
AWS EC2 bridge: 172.18.0.1/16

Base dockers:
mariadb: x.x.1.20
mysql: x.x.1.22
phpmyadmin: x.x.1.23



App dockers:
nextcloud: x.x.1.50
avideo: x.x.1.51
avideo-encoder: x.x.1.52
plex: x.x.1.53
