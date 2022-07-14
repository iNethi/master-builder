# Setting Up Single Sign On (SSO)
## Docker environment
The docker environment used is built using the ```build_all.sh``` script found in the 
[iNethi Master Builder Repo](https://github.com/iNethi/master-builder). It was tested with a Let's Encrypt provided
certificate.
## Set up
### Keycloak
1. Create a new client:
   1. Client ID: ```nextcloud.example.com``` 
   2. Client Protocol: ```openid-connect``` 
   3. Root URL: ```https://nextcloud.example.com```
   4. Add ```http://nextcloud.example.com/*``` (the http is important) and leave the https entry in as well
2. Update the following client settings:
   1. Access Type: ```confidential```
3. In the roles tab add a new role:
   1. Role name: ```admin```
4. Add a mapper:
   1. Return to the clients view and open the Mappers tab
   2. Click ```Add Builtin```, search for ```client roles``` and add it
   3. Open the new mapper and add:
      1. Token claim name: ```roles```
      2. Add to userino: ```ON```
5. Open the credentials tab and copy the Secret
6. Disable ```Full Scope Allowed``` in the Scope tab
7. Navigate to Configure > Realm Settings > General tab and click on OpenID Endpoint Configuration (keep this open)
8. Apply the client admin role to your Keycloak account:
   1. Go to manage > users
   2. Select your user
   3. Click on role mappings and add the role under client roles
9. Enable user registration and add this role as a default role if you want users to be able to register and login into
nextcloud
### Nextcloud
1. Open the app dashboard and install the [social login app](https://github.com/zorn-v/nextcloud-social-login)
   1. Navigate to Settings > Administration > Social login and set the options to what you want or check the following:
      1. Prevent creating an account if the email address exists in another account
      2. Restrict login for users without mapped groups
2. Test this by navigating to your nextcloud url and logging in with the SSO option and your keycloak ID

### React Payment Portal