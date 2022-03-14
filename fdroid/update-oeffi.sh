#!/bin/bash


wget -r -I downloads -A "*aosp.apk" -nc -nd https://oeffi.schildbach.de/download.html

if diff -q oeffi-*-aosp.apk repo/oeffi.apk  ;then
      	echo "no diff"
	rm oeffi-*-aosp.apk
else 
	mv oeffi-*-aosp.apk repo/oeffi.apk
	git add repo/oeffi.apk
	git commit -m "new oeffi version"
	git push
fi
