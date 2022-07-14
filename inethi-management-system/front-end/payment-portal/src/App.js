import React from "react";
import { ReactKeycloakProvider } from "@react-keycloak/web";
import keycloak from "./Keycloak";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Nav from "./components/Nav";
import Homepage from "./pages/Homepage";
import Create from "./Create";
import PrivateRoute from "./helpers/PrivateRoute";
import PurchaseHistory from "./pages/PurchaseHistory";
import Services from "./pages/Services";
import PaymentLimits from "./pages/PaymentLimits";

const Loading = () => <div>Loading...</div>
function App() {
 return (
   <div>
     <ReactKeycloakProvider
            authClient={keycloak}
            initOptions={{
                onLoad: "check-sso",
                checkLoginIframe: false
            }}
        LoadingComponent={<Loading />}
        >

       <Nav />
          <div className="content">
       <BrowserRouter>
         <Routes>
           <Route exact path="/" element={<PrivateRoute><Homepage /></PrivateRoute>} />
            <Route
             path="/services"
             element={
               <Services />
             }
           />
           <Route
             path="/purchase"
             element={
               <PrivateRoute>
                 <Create />
               </PrivateRoute>
             }
           />
             <Route
             path="/purchasehistory"
             element={
               <PrivateRoute>
                 <PurchaseHistory />
               </PrivateRoute>
             }
           />
             <Route
             path="/paymentlimits"
             element={
               <PrivateRoute>
                 <PaymentLimits />
               </PrivateRoute>
             }
           />
         </Routes>


       </BrowserRouter>

              </div>
     </ReactKeycloakProvider>

   </div>
 );
}

export default App;



