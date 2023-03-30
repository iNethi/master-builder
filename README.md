# iNethi Core Build

This is the starting place to build iNethi on your own server. 

- [Join our iNethi discord](https://discord.gg/ZxTSu7kufr)
- [View Contributors](https://github.com/iNethi/master-builder/blob/master/CONTRIBUTORS.md)

## A collection of awesome self-hosted services
iNethi creates a platform that brings a lot of awesome self-hosted services together. It provides a secure reverse proxy
in front of these services using Traefik, creates a nice splash page to access the web services, synchronization of 
content  between a global iNethi cloud and your iNethi, and will soon provide single sign-on to many of these services.
A great resource for many self-hosted services that can be ported to iNethi is here 
[Self hosted servces](https://github.com/awesome-selfhosted/awesome-selfhosted/blob/master/README.md)

# Build
To build a server and select the services you want to use, run the following from the root folder:
```
sudo ./build_all.sh
```

# Usage
This is an open source solution that is freely available to everyone, just keep it open source! With iNethi you can build 
a set of local services to share content amongst your local community and build a small ISP to sell Internet vouchers. 
[More detail...](https://splashg.inethi.net)

We offer bespoke services, support and payment integrations upon request. Contact us at: keeganthomaswhite@gmail.com,
davidlloydjohnson@gmail.com or inethi4us@gmail.com.

# Network notes

- iNethi makes use of traefik as a reverse proxy to route hosts to a specific docker container
- Docker will automatically create a bridged network which bridges traefik to the host Ethernet interface on your computer
- The services will be available at various URLs once you have set up a firewall/dns redirect. The URLs are:
  - splash.inethilocal.net
  - nextcloud.inethilocal.net
  - wordpress.inethilocal.net
  - keycloak.inethilocal.net
  - jellyfin.inethilocal.net
  - radiusdesk.inethilocal.net
  - traefik.inethilocal

## Set Up Firewall/DNS redirect
- On a firewall on your network like Pfsense, make a widlcard DNS resolve entry. 
Under services / dns resolver / general settings enable 'diplay custom options' and enter the follwoing:
```
server:
local-zone: "<URL>" redirect
local-data: "<URL> 86400 IN A <SERVER IP>"
```
where URL is the domain name i.e. for 'nextcloud.inethilocal.net' you would enter 'inethilocal.net' and the 
'SERVER IP'is the IP address of the device hosting the services you want to redirect to.

_Recommended: set a static IP address for your server_

## Set up a Redirect on your local machine
To set up a local redirect on a Mac or Ubuntu machine edit your hosts file ```sudo nano /etc/hosts```
and add an entry for the URL of each service with your local machine's IP address like this to the end of your host file
like this:
```
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1       localhost
255.255.255.255 broadcasthost
::1             localhost
# Added by Docker Desktop
# To allow the same kube context to work on the host and the container:
127.0.0.1 kubernetes.docker.internal
# End of section
# 192.168.68.105 jellyfin.inethilocal.net
# 192.168.68.105 treafik.inethilocal.net
# 192.168.68.105 nextcloud.inethilocal.net
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

- To set up go to [https://nextcloud.inethilocal.net](https://nextcloud.inethilocal.net)

### Choose a master username and password and storage location

- user: inethiadmin (suggestion)
- password: (pick a secure password)
- storage location: (leave as default)

### configure database

Select MySQL/MariaDB (under configure the database)

- Database user: inethi
- password: <the password you set in the builder>
- database name: inethi_nextcloud
- database: inethi-nextcloud-mysql

Once Nextcloud launches login as administrator

- Select Apps from top right icon
- Select Disabled Apps
- Enable External storage support

Add a Public Group

- Select Users option when clicking on Administator user icon
- Select Add Group - Enter Public

Add External storages

- Select Administator user - select Settings
- Bottom left - select External storages

Add the following:
- Folder name: Rshare , External storage: Local, Configuration /mnt/Rshare, Available for Public, Options: Enable Sharing,  Read only
- Folder name: Rvideo, External storage: Local, Configuration /mnt/Rvideo,  Available for Public, Options: Enable Sharing,  Read only
- Folder name: Rmusic, External storage: Local, Configuration /mnt/Rmusic,  Available for Public, Options: Enable Sharing,  Read only
- Folder name: Rphoto, External storage: Local, Configuration /mnt/Rphoto,  Available for Public, Options: Enable Sharing,  Read only
- Folder name: RWshare , External storage: Local, Configuration /mnt/Rshare, Available for admin, Options: Enable Sharing
- Folder name: RWvideo, External storage: Local, Configuration /mnt/Rvideo,  Available for admin, Options: Enable Sharing
- Folder name: RWmusic, External storage: Local, Configuration /mnt/Rmusic,  Available for admin, Options: Enable Sharing
- Folder name: RWphoto, External storage: Local, Configuration /mnt/Rphoto,  Available for admin, Options: Enable Sharing


## Jellyfin

- To setup go to [https://jellyfin.inethilocal.net](https://jellyfin.inethilocal.net)

### Complete Tell us about yourself

- Username: inethiadmin (suggestion)
- Password: select a strong password

### Add video library

- Select Add Media library
- Content type: Movies
- Display name: Videos
- Folders (+)
- Folder: /mnt/Rvideo
- Select OK

### Add music library

- Select Add Media library
- Content type: Music
- Display name: Music
- Folders (+)
- Folder: /mnt/Rmusic
- Select OK

# Add content

To add music and video content that van be viewed on Jellyfin. Open Nextcloud, login as administrator or a user with 
administrator priveledges and Drag videos to the RWVideo folder or Drag music to the RWMusic folder

# Added Synchronization

You can contact iNethi to get some space on the global iNethi cloud - a folder allocated for your organization will 
synchronize with your local iNethi instance. We will allocate a folder for you. keeganthomaswhite@gmail.com,
davidlloydjohnson@gmail.com or inethi4us@gmail.com for pricing arrangement if you require global storage options.

You will receive a login to the global iNethi storage and a Webdav link you will need to enter when you run the following code
```
./build_sync.sh
```

# Useful Docker Commands
- ```docker stop $(docker ps -a -q)``` - stop all docker containers
- ```docker rm $(docker ps -a -q)``` - remove all stopped docker containers
