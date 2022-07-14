import React from 'react';
import {Link} from "react-router-dom";


const Home = () => {

 return (

   <div className="navbar">
        <Link to="/purchase">
            <button>Make a Purchase</button></Link>
       <Link to="/purchasehistory">
            <button>See my Purchase History</button></Link>
       <Link to="/services">
            <button>Available Services</button></Link>
       <Link to="/paymentlimits">
            <button>Payment Limits</button></Link>
    <text></text>

   </div>
 );
};

export default Home;