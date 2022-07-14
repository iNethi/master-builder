import React, {useEffect, useState} from 'react';
import {Link} from "react-router-dom";
import keycloak from "../Keycloak";


const PaymentLimits = () => {
    const [serviceLimits, setServiceLimits] = useState([]);
    const [customServiceLimits, setCustomServiceLimits] = useState([]);
    const keycloak_id = keycloak.tokenParsed.preferred_username

    useEffect(() => {

         fetch('https://usermanagement.inethicloud.net/getdefaultlimits/', {
            method: 'GET',
        }, []).then(response => response.json())
            .then(data => {console.log(data)
            setServiceLimits(data)})

        fetch('https://usermanagement.inethicloud.net/getuserlimits/'+keycloak_id, {
            method: 'GET',
        }, []).then(response => response.json())
            .then(data => {console.log(data)
            setCustomServiceLimits(data)})
    }, [])
if(serviceLimits.length>0) {
    return (
        <div className="create">
            <h2>{keycloak.tokenParsed.preferred_username}'s Payment Limits</h2>
            {
                customServiceLimits.map(customServiceLimits => {
                    if (customServiceLimits.service_type_id === 1){
                        customServiceLimits.service_type_id = "Internet Voucher";
                    }
                    else if (customServiceLimits.service_type_id === 2){
                        customServiceLimits.service_type_id = "iNethi Club Voucher";
                    }
                    else if (customServiceLimits.service_type_id === 3){
                        customServiceLimits.service_type_id = "iNethi Advertising";
                    }
                    if (customServiceLimits.payment_method === 1){
                        customServiceLimits.payment_method = "Cash";
                    }
                    else if (customServiceLimits.payment_method === 2){
                        customServiceLimits.payment_method = "One4You";
                    }
                    else if (customServiceLimits.payment_method === 4){
                        customServiceLimits.payment_method = "CIC";
                    }
                    else if (customServiceLimits.payment_method === 8){
                        customServiceLimits.payment_method = "PayPal";
                    }
                    else if (customServiceLimits.payment_method === 16){
                        customServiceLimits.payment_method = "Credit Card";
                    }
                    return <table>
                        <tbody>
                            <td>{customServiceLimits.service_type_id }</td>
                            <td>{customServiceLimits.payment_limit}</td>
                            <td>{customServiceLimits.payment_method}</td>
                            <td>{customServiceLimits.payment_limit_period_sec}</td>
                        </tbody>
                    </table>
                })
            }
            <h2>Default Payment Limits</h2>
            {
                serviceLimits.map(serviceLimits => {
                    if (serviceLimits.service_type_id === 1){
                        serviceLimits.service_type_id = "Internet Voucher";
                    }
                    else if (serviceLimits.service_type_id === 2){
                        serviceLimits.service_type_id = "iNethi Club Voucher";
                    }
                    if (serviceLimits.payment_method === 1){
                        serviceLimits.payment_method = "Cash";
                    }
                    else if (serviceLimits.payment_method === 2){
                        serviceLimits.payment_method = "One4You";
                    }
                    else if (serviceLimits.payment_method === 4){
                        serviceLimits.payment_method = "CIC";
                    }
                    else if (serviceLimits.payment_method === 8){
                        serviceLimits.payment_method = "PayPal";
                    }
                    else if (serviceLimits.payment_method === 16){
                        serviceLimits.payment_method = "Credit Card";
                    }
                    return <table>
                        <tbody>
                            <td>{serviceLimits.service_type_id }</td>
                            <td>{serviceLimits.payment_limit}</td>
                            <td>{serviceLimits.payment_method}</td>
                            <td>{serviceLimits.payment_limit_period_sec}</td>
                        </tbody>
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

export default PaymentLimits;