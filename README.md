# iNethi Core Docker Build

This is the starting place to build iNethi on your own server. [Join our iNethi discord](https://discord.gg/ZxTSu7kufr).

# Usage
This is an open source solution that is freely available to everyone. With iNethi you can build a set of local services to share content amongst your local community and build a small ISP to sell Internet vouchers. [More detail...](https://splashg.inethi.net)

# How to build a server
This process is similar to setting up a VM as detailed below. You can follow the [video](https://www.youtube.com/watch?v=EIt8GShQFlQ&ab_channel=KeeganWhite) made for the VM set up and ignore the steps referencing dnsmasq.

## Preparation
Each folder contains a compose file and environment varaibles. View the environment variables in order to familiarise yourself with the folders the data will be mounted to and the URLs the services will be availible at.

## Build automatically
To build a server and select the services you want to use, run the following from the root folder:
```
sudo ./traefik_build_all.sh
```
Note root privileges will be necessary.

## Manual build
Build a docker bridge for the containers to attach to (it must match all your environment variables that use this network):
```
docker network create --attachable -d bridge inethi-bridge-traefik
```
Move into the traefik directory and run:
```
sudo ./local_build.sh
```
Following this run the local build scripts in the directories of the services you want to deploy.

# How to use the Traefik build with Dnsmasq (Recommended for VM's)

[Here's a video of a server being set up with step by step instructions](https://www.youtube.com/watch?v=EIt8GShQFlQ&ab_channel=KeeganWhite), or you can read below.

This build has been tested on both an Ubuntu server and desktop. This is the new architecture that iNethi is adopting. Please make use of it. You can either run the master build script to build all the dockers linked to iNethi or you can build individual dockers that you need. Docker and docker compose need to be installed before running the build script.

To build the whole system on a server simply run the build script and follow the instructions displayed on screen. The majority of the process is automatic but there is one manual step. *Before* you run the build script navigate to master-builder/traefik-with-dnsmasq/dnsmasq/dnsmasq.conf and edit the 6th line of this file to read as follows:
  address=/inethihome.net/*the ip address of your server*
Where the 'the ip address of your server' is found using ``` ip a ``` or some equivalent. Find the ip address of the interface that you are connecting to your local network with on screen and use this ip address. This can be 'eth0', 'eth1', 'en0', etc. depending on what OS you are running. This is a vital step as the build script will disable your current dns settings on your device in order for the dnsmasq docker container to bind to port 53. If your system fails to resolve requests following this you may be having errors with the dns servers used by the docker container. These can be changed in the dnsmasq.conf file that has been moved to the /mnt/data/dnsmasq folder. Edit this using ``` sudo nano /mnt/data/dnsmasq/dnsmasq.conf ``` or some equivalent.

Once you have chosen the containers you want to start the build script will create a docker bridge network, download the trafik and dnsmasq docker files and then disable your current dns settings so that the dnsmasq and traefik docker containers can be set up correctly. Following this the rest of the containers will be built.

The build script can be starting by running:
```
sudo ./traefik_dnsmasq_build_all.sh
```
Note root privileges will be necessary.

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

## Core docker containers
- nginx: runs splash page
- traefik: reverse proxy

## Dependency dockers:
- mariadb: database
- mysql: database
- phpmyadmin: database management
- mongo: database
- mysql-keycloak: database - seperate mysql for keycloak


## Elective dockers:
- nextcloud: File sharing system and collaboration platform
- Jellyfin: video streaming platform
- radiusdesk3: Voucher management system
- keycloak: single sign on tool

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

# Features in the works
- Payment integrations
- Nextcloud conversion to Traefik
- Improved building mechanisms
- Architecture diagrams
