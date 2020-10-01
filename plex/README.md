# PLEX Docker file


# Allow full local lan access

After installing you need to edit this file to enusre you have local access without needing to login
```
/mnt/data/plex/database/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
```
E.g. to add full access to all ip address on 10.x.x.x/8 subnet
```
allowedNetworks="10.0.0.0/255.0.0.0"
```
