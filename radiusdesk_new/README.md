# radiusdesk
Dockerised new radiusdesk from https://github.com/RADIUSdesk based on 
 - php7.4-fpm
 - FreeRadius 3.x
 - NGINX for the web server.
 - MariaDB to store the data.
 - CakePHP 3.x to create an API.
 - ExtJs 7.0 to present a modern GUI that interacts with the API.

## To install just run the build script
```
./local_build.sh
```

## Note these steps are still needed after  install (will automate in the future)
### Database fixes

```
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p mysql
```
```
mysql -u root
CREATE DATABASE rd;
GRANT ALL PRIVILEGES ON rd.* to 'rd'@'127.0.0.1' IDENTIFIED BY 'rd';
GRANT ALL PRIVILEGES ON rd.* to 'rd'@'localhost' IDENTIFIED BY 'rd';
FLUSH PRIVILEGES;
exit;
```

### nginx server fixes
```
docker exec -it inethi-radiusdesk2022 sh
```
```
cp /usr/share/nginx/html/cake3/rd_cake/setup/cron/cron3 /etc/cron.d
```