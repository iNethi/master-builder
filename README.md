# iNethi Docker master file

All the docker compose files to build iNethi-related dockers live here

# Usage
This is an open source solution that is freely available to everyone. With iNethi you can build a set of local services to share content amongst your local community and build a small ISP to sell Internet vouchers. [more detail...](https://inethi.net)

# How to use

You can either run the master build script to build all the dockers linked to iNethi or you can build individual dockers that you need

To build the whole system on a  server simply run
```
./traefik_build_all
```

# Important notes

If you want to build docker yourself, first build mysql docker and then build other dockers

Local dockers on local server machine are build with the following command in each docker folder

```
./local_build.sh
```

# Network notes

- iNethi makes use of traefik as a reverse proxy to route hosts to a specific docker container
- Docker will automatically create a bridged network which bridges traefik to the host Ethernet interface on your computer
- After installing check the ip address of the traefik container by running
```
docker inspect inethi-traefik | grep IPAddress
```
- Make sure you create a wildcard rule on your DNS server that points all traffic on the domain your choose to this traefik container. e.g. if inethi-traefik's IP address is 172.23.0.2 and your domain is inethihome.net
- Create a DNS entry that points *.inethihome.net to 172.23.0.2

## Core docker containers
- nginx: runs splash page
- traefik: reverse proxy)
- keycloak: single sign on tool

## Dependency dockers:
- mariadb: database
- mysql: database
- phpmyadmin: database management 
- mongo: database
- mysql-keycloak: database - seperate mysql for keycloak
- influxDB: database for real time stream
- musicshare-mariadb: database - seperate database for musicshare


## Elective dockers:
- nextcloud: File sharing system and collaboration platform
- avideo: Local video sharing system similar to Youtube
- avideo-encoder: Encoder for avideo
- plex: Video and music streaming service
- Rocketchat: Local Chat server
- Unifi Controller: Ubiquity Unifi WiFi hotspot managmenet 
- UNMS: Ubiquity WiFi backhaul management system
- Jellyfin: video streaming platform
- Grafana: Graphing dashboard
- radiusdesk3: Voucher management system
- Musicshare: Music sharing platform
- Musicshare-adminer: Ad mining for music sharing platform
- OnlyOffice: Open Source office colalbortive platform 
- Callobora: Open Source office colalbortive platform

# Post docker installation steps

Once all the docker are running there are some remaining configurations steps

## Nextcloud

Set up the connection to the database

- user: admin
- password: iNethi#2018

### Select MySQL/MariaDB (under configure the database)
- Database user: inethi
- password: inethi2018
- database name: inethi_nextcloud
- database: mariadb

Once Nextcloud launches login as administrator

- Select Apps from top right icon
- Select Disabled Apps
- Enable External storage support

Add a Public Group

- Select Users option when clicking on Administator user icon
- Select Add Group - Enter Public

Add External storages

- Select Administator user
- Bottom left - select External storages

Add the following: 
- Folder name: Share, External storage: Local, Configuration /mnt/Rshare
- Folder name: Shared Videos, External storage: Local, Configuration /mnt/Rvideos
- Folder name: Shared Music, External storage: Local, Configuration /mnt/Rmusic 

