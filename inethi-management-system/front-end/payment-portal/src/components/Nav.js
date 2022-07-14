import React from "react";
import { useKeycloak } from "@react-keycloak/web";
import { Link } from "react-router-dom";
const Nav = () => {

    const {keycloak} = useKeycloak();

 return (
         <nav className="navbar">
            <h1>iNethi</h1>
             <div className="links">
               <div className="hover:text-gray-200">
                 {!keycloak.authenticated && (
                   <button
                     onClick={() => keycloak.login()}
                   >
                     Login
                   </button>
                 )}

                 {!!keycloak.authenticated && (
                   <button
                     onClick={() => keycloak.logout()}
                   >
                     Logout ({keycloak.tokenParsed.preferred_username})
                   </button>
                 )}
               </div>
             </div>
         </nav>

 );
};

export default Nav;