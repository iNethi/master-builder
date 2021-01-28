# iNethi Docker master file

All the docker compose files to build iNethi-related dockers live here

# Usage
This is an open source solution that is freely available to everyone. With iNethi you can build a set of local services to share content amongst your local community and build a small ISP to sell Internet vouchers. [more detail...](https://inethi.net)

# How to use

You can either run the master build script to build all the dockers linked to iNethi or you can build individual dockers that you need

To build the whole system on a local server simply run
```
./local_build_all.sh <network interface connected to internet> <plex claim token>
```
To get your plex claim token go to [plex claim](https://www.plex.tv/claim/) 

Example if eth0 is WAN interface connected to network and your plex claim is claim-xZ4QYD4rJnpVyLWoKgzA
```
./local_build_all.sh eth0 claim-xZ4QYD4rJnpVyLWoKgzA
```

To build the whole system on a AWS simply run
```
./aws_build_all.sh
```

# Important notes

If you want to build docker yourself, first build mysql docker and then build other dockers

Local dockers on local server machine are build with the following command in each docker folder

```
./local_build.sh
```

AWS dockers are built with the following command in each docker folder

```
./aws_build.sh
```

# Network notes

- `Local server bridge using macvlan: ` 10.2.1.1/16 (linternal network 172.17.0.1/16)
- `AWS EC2 bridge:` 172.18.0.1/16

## Low level dockers
- splash (nginx1): x.x.1.3
- nginx (nginx2): x.x.1.4
- haproxyssl: x.x.1.5
- keycloak: x.x.1.7

## Base dockers:
- mariadb: x.x.1.20
- mysql: x.x.1.22
- phpmyadmin: x.x.1.23
- mongo: x.x.1.24
- mysql-keycloak: x.x.1.25
- influxDB: x.x.1.26
- musicshare-mariadb: x.x.1.27 **


## App dockers:
- nextcloud: x.x.1.50 (depends (mariadb))
- avideo: x.x.1.51 (depends mysql)
- avideo-encoder: x.x.1.52 (depends mysql)
- plex: x.x.1.53 
- Rocketchat: x.x.1.54 (depends mongo)
- Unifi Controller: x.x.1.55
- UNMS: x.x.1.56
- Jellyfin: x.x.1.57
- Grafana: x.x.1.58
- radiusdesk3: x.x.1.59 **
- Musicshare: x.x.1.60 **
- Musicshare-adminer: x.x.1.61 **
- OnlyOffice: x.x.1.62
- Callobora: x.x.1.63

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


## Other notes 

- AVideo mounts a Volume for /var/www/localhost/htdocs/videos
