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

- `Local server bridge using macvlan: ` 10.2.1.1/16
- `AWS EC2 bridge:` 172.18.0.1/16


## Base dockers:
- mariadb: x.x.1.20
- mysql: x.x.1.22
- phpmyadmin: x.x.1.23


## App dockers:
- nextcloud: x.x.1.50
- avideo: x.x.1.51
- avideo-encoder: x.x.1.52
- plex: x.x.1.53


# Post docker installation steps

Once all the docker are running there are some remaining configurations steps

## Nextcloud

Set up the connection to the database

- user: admin
- password: iNethi#2018

### Select MySQL
- user: inethi
- password: inethi2018
- database name: inethi_nextcloud
- database: mariadb

Once Nextcloud launches login as administrator

- Select Apps from top right icon
- Select Disabled Apps
- Enable External storage support




