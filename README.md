# iNethi Docker master file

All the docker compose files to build iNethi-related dockers live here

# Usage
This is an open source solution that is freely available to everyone. With iNethi you can build a set of local services to share content amongst your local community and build a small ISP to sell Internet vouchers. [more detail...](https://inethi.net)

# How to use the Traefik build with Dnsmasq

This build has been tested on both Ubuntu server and desktop. This is the new architecture that iNethi is adopting. Please make use of it. You can either run the master build script to build all the dockers linked to iNethi or you can build individual dockers that you need. Docker and docker compose need to be installed before running the build scrip.

To build the whole system on a server simply run you can run the build script and follow the instructions displayed on screen. The majority of the process is automatic but there is one manual step. *Before* you run the build script navigate to docker-master/traefik-with-dnsmasq/dnsmasq/dnsmasq.conf and edit the 6th line of this file to read as follows:
  address=/inethihome.net/*the ip address of your server*
Where the 'the ip address of your server' is found using ``` ip a ``` or some equivalent. Find the ip address of the interface that you are connecting to your local network with on screen and use this ip address. This can be 'eth0', 'eth1', 'en0', etc. depending on what OS you are running. This is a vital step as the build script will disable your current dns settings on your device in order for the dnsmasq docker container to bind to port 53. If your system fails to resolve requests following this you may be having errors with the dns servers used by the docker container. These can be changed in the dnsmasq.conf file that has been moved to the /mnt/data/dnsmasq folder. Edit this using ``` sudo nano /mnt/data/dnsmasq/dnsmasq.conf ``` or some equivalent.

Once you have chosen the containers you want to start the build script will create a docker bridge network, download the trafik and dnsmasq docker files and then disable your current dns settings so that the dnsmasq and traefik docker containers can be set up correctly. Following this the rest of the containers will be built.

The build script can be starting by running:
```
sudo ./traefik_build_all
```
Note root privileges will be necessary.

A summary of what is happening in this build script. The docker images you choose are pulled first
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
