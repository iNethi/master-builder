import React, { useState, useEffect } from 'react';
import {Link} from "react-router-dom";
import keycloak from "../Keycloak";


const PurchaseHistory = () => {
    const [purchases, setPurchases] = useState([]);
    const username = keycloak.tokenParsed.preferred_username
    console.log(username)
    const keycloak_id = username


    useEffect(() => {

        console.log(JSON.stringify(keycloak_id))
        fetch('https://usermanagement.inethicloud.net/getuserpayments/'+keycloak_id, {
            method: 'GET',
        }, []).then(response => response.json())
            .then(data => {console.log(data)
            setPurchases(data)})
    }, [keycloak_id])
if(purchases.length>0) {
    return (

        <div className="create">
            <h2>{keycloak.tokenParsed.preferred_username}'s Purchase History</h2>
            {
                purchases.map(purchase => {
                    if (purchase.payment_method === 1){
                        purchase.payment_method = "Cash";
                    }
                    return <table>
                        <tr>
                            <td>{purchase.amount}</td>
                            <td>{purchase.service_type_id}</td>
                            <td>{purchase.payment_method}</td>
                            <td>{purchase.service_period_sec}</td>
                            <td>{purchase.paydate_time}</td>
                        </tr>
                    </table>
                })
            }


            <Link to="/">
                <button>Home Page</button>
            </Link>
        </div>

    );
}

};

export default PurchaseHistory;