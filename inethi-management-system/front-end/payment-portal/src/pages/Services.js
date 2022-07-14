import React, { useState, useEffect } from 'react';
import {Link} from "react-router-dom";


const Services = () => {
    const [services, setServices] = useState([]);

    useEffect(() => {
        fetch('https://usermanagement.inethicloud.net/services/', {
            method: 'GET',
        }, []).then(response => response.json())
            .then(data => {console.log(data)
            setServices(data)})
    }, [])
if(services.length>0) {
    return (
        <div className="create">
            <h2>Available Services</h2>
            {
                services.map(services => {
                    if (services.pay_type === "PA"){
                        services.pay_type = "PAID";
                    }
                    else if (services.pay_type === "FR"){
                        services.pay_type = "FREE";
                    }
                    return <table>
                        <tbody>
                            <td>{services.description}</td>
                            <td>{services.pay_type}</td>
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

export default Services;