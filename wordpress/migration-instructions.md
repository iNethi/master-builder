## Migration and setup
To migrate Wordpress instances between different servers:
1. Compress wp-content folder from the version of the website you wish migrate. Export the corresponding database for the site.
2. Startup a new mariadb container.
3. Import database using the database export created in step 1. (make sure the URL is updated to the current URL being used in the database. This can be changed easily pre-import by editing the text file.)
4. Edit the volumes in the docker-compose so that your new wordpress instance uses the wp-contentfolder from step 1 and link it to your new mariadb container.
5. Start up the wordpress docker container.