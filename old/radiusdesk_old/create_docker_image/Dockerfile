FROM tungs/radiusdesk3-php7-ubuntu16:latest
   RUN apt-get install -y supervisor
   RUN mkdir -p /var/log/php-fpm /var/log/freeradius /var/run/php
   ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
   CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
   
 

  
   