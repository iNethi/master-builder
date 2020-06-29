# docker-youphptube

This is a docker image to run Avdideo v8.8 in LXC.

# YouPHPTube
YouPHPTube! is an video-sharing website, It is an open source solution that is freely available to everyone. With YouPHPTube you can create your own video sharing site, YouPHPTube will help you import and encode videos from other sites like Youtube, Vimeo, etc. and you can share directly on your website. In addition, you can use Facebook or Google login to register users on your site. The service was created in march 2017. [more detail...](https://github.com/WWBN/AVideo)

# How to use
The simple way, you edit docker-compose.yml then run the command below:
```
docker-compose up -d
```

This way will create all service containers, include: mysql, phpmyadmin and youphptube.


You may want to change the default language, use the parameters -e LANG=your_country.

When the contianer is running, you can setup your own SSL certificates **OR** generate [Let's Encrypt](https://letsencrypt.org/) free SSL by shell script


