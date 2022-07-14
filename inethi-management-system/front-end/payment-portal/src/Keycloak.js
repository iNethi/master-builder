import Keycloak from "keycloak-js";
const keycloak = new Keycloak({
 url: "https://keycloak.inethicloud.net/auth/",
 realm: "master",
 clientId: "paymentportal.inethicloud.net",
});

export default keycloak