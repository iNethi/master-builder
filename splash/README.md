This splash content is uploaded to the pfsense Captive Portal config page 

## Instructions for embedded html content

* Ensure that embedded objects have a prefex "captiveportal-"
* Login occurs wehn an HTTP POST is sent with #PORTAL_LOGIN#
* #PORTAL_MESSAGE#  contains any error message from the server "e.g. Login incorrect"

## Upload instructions for obecjts

* Go to the File Manager tab
* Upload each individual object at a time
* Ensure objects don't have the "captiveportal-" prefix - this is added automatically

## Upload instructions for html files

* Go to the Captive Portal Config screen on PFsense [<server ip]/services_captiveportal_zones.php]
* ensure that the option "Use custom captive portal page" is checked
* Select Choose file under Portal page contents
* Upload the modified portal.html file

