#!/bin/bash 

apkurl=$(curl -s https://api.github.com/repos/daneren2005/Subsonic/releases/latest | jq -r ".assets|.[]|.browser_download_url")
curl -sL $apkurl -o dsub.apk 
if diff -q dsub.apk repo/dsub.apk  ;then
      	echo "no diff"
	rm dsub.apk
else 
 	mv dsub.apk repo/dsub.apk
	git add repo/dsub.apk
	git commit -m "new dsub version"
	git push
fi
