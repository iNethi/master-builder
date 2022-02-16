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
docker exec -it inethi-radiusdesk-mariadb sh
```
```
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root  mysql
```
```
mysql -u root
GRANT ALL PRIVILEGES ON rd.* to 'rd'@'%' IDENTIFIED BY 'rd' WITH GRANT OPTION;
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