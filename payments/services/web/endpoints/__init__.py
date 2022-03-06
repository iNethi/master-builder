from dataclasses import dataclass

from flask_cors import CORS, cross_origin
from flask import Flask, jsonify, request, json
from flask_sqlalchemy import SQLAlchemy
from .redeem import redeem


app = Flask(__name__)  # create an instance of the class


app.config.from_object("endpoints.config.Config")
app.config['CORS_HEADERS'] = 'application/json'
cors = CORS(app, resources={r"/REDEEM": {"origins": "http://localhost:63342"}})  # this URL does not seem necessary
db = SQLAlchemy(app)


# helps us serialize the database objects
@dataclass
class Vouchers(db.Model):

    id: int = db.Column(db.Integer, primary_key=True)
    voucher_pin: str = db.Column(db.String(120), unique=True, nullable=True)
    status: bool = db.Column(db.Enum("new","used","depleted","expired","issued"), default="new", nullable=False)
    name: str = db.Column(db.String(64), nullable=False)  # radius desk code
    profile: str = db.Column(db.String(120), nullable=False)  # profile
    phone_number: int = db.Column(db.String(20), nullable=True)
    paytype: str = db.Column(db.String(20), nullable=True)
    amount: int = db.Column(db.Integer, nullable=True)

    def __init__(self, name: str, profile: str) -> None:
        self.name = name
        self.profile = profile
'''
class Vouchers(db.Mobel):
    CREATE TABLE `vouchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `batch` varchar(128) NOT NULL DEFAULT '',
  `status` enum('new','used','depleted','expired','issued') DEFAULT 'new',
  `perc_time_used` int(6) DEFAULT NULL,
  `perc_data_used` int(6) DEFAULT NULL,
  `last_accept_time` datetime DEFAULT NULL,
  `last_reject_time` datetime DEFAULT NULL,
  `last_accept_nas` varchar(128) DEFAULT NULL,
  `last_reject_nas` varchar(128) DEFAULT NULL,
  `last_reject_message` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `extra_name` varchar(100) NOT NULL DEFAULT '',
  `extra_value` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL DEFAULT '',
  `realm` varchar(50) NOT NULL DEFAULT '',
  `realm_id` int(11) DEFAULT NULL,
  `profile` varchar(50) NOT NULL DEFAULT '',
  `profile_id` int(11) DEFAULT NULL,
  `expire` datetime DEFAULT NULL,
  `time_valid` varchar(10) NOT NULL DEFAULT '',
  `data_used` bigint(20) DEFAULT NULL,
  `data_cap` bigint(20) DEFAULT NULL,
  `time_used` int(12) DEFAULT NULL,
  `time_cap` int(12) DEFAULT NULL,

  `issued` datetime DEFAULT NULL,
  `paytype` varchar(20) DEFAULT NULL,
  `voucher_pin` varchar(120), DEFAULT NULL,
  `phone_number` varchar(20), DEFAULT NULL,
  `amount` int(2), DEFAULT NULL


  PRIMARY KEY (`id`),
  UNIQUE KEY `ak_vouchers` (`name`)
'''

@app.get("/list")
def read_root():
    data = Vouchers.query.all()
    return jsonify(data)


@app.route('/query', methods=['POST'])
@cross_origin(origin='voucherapi.inethimac.net', headers=['application/json', 'Authorization'])
def query_voucher():
    """
    An endpoint that relies on the user submitting a 1FORYOU pin and phone number that is used to query the database to
    to see if this user has purchased a Radious voucher using these details. This allows users to retrieve a forgotten
    or lost code
    :return: an HTTP response indicating whether this user has purchased a voucher with these details and the Radius
    voucher code if they did purchase one.
    """
    voucher_pin = request.json.get('voucherPin')  # 1FORYOU voucher pin
    cellphone_number = request.json.get('cellphoneNumber')  # user's cellphone number
    match = Vouchers.query.filter_by(used=True, voucher_pin=voucher_pin, phone_number=cellphone_number).first()  #
    # check if a Radius voucher has been purchased
    print(type(match))
    if match is None:  # if no Radius voucher has not been purchased with the users details
        print("None if statement activated.")
        confirmation = {
            "message": "We cannot find a matching voucher",
            "responseCode": 1  # response code of 1 indicates no voucher was purchased
        }
        api_response = app.response_class(
            response=json.dumps(confirmation),
            status=200,
            mimetype="application/json"
        )
        return api_response
    else:
        print("Matching voucher code " + match.name)
        confirmation = {
            "message": match.name,
            "responseCode": 0  # response code of 0 indicates there was a match
        }
        api_response = app.response_class(
            response=json.dumps(confirmation),
            status=200,
            mimetype="application/json"
        )
        return api_response


@app.route('/redeem', methods=['POST'])
@cross_origin(origin='flaskprod.inethimac.net', headers=['application/json', 'Authorization'])
def redeem_voucher():
    """

    :return: an HTTP response with a Radius voucher code if the 1FORYOU voucher code was successful redeemed else
    return an error, of which there are many.
    """
    voucher_choice = request.json.get('voucherChoice')
    amount = ""  # this amount variable is the rand amount each voucher corresponds to. We assign it a Radius profile
    # code and then convert it to the rand amount when processing the 1FORYOU API call in the redeem() method.
    if voucher_choice == '1GDATA':
        amount = "FCD1"  # update to match your Radius profile code
    elif voucher_choice == '10GDATA':
        amount = "FCD10"  # update to match your Radius profile code
    elif voucher_choice == '100GDATA':
        amount = "FCD100"  # update to match your Radius profile code
    elif voucher_choice == '5GDATA':
        amount = "FCD5"  # update to match your Radius profile code
    elif voucher_choice == '1HTIME':
        amount = "FCT1"  # update to match your Radius profile code
    elif voucher_choice == '24HTIME':
        amount = "FCT24"  # update to match your Radius profile code
    elif voucher_choice == '3HTIME':
        amount = "FCT3"  # update to match your Radius profile code
    elif voucher_choice == '15DAYTIME':
        amount = "FCTD15"  # update to match your Radius profile code
    elif voucher_choice == '28DAYTIME':
        amount = "FCTD28"  # update to match your Radius profile code


    voucher_pin = request.json.get('voucherPin')
    cellphone_number = request.json.get('cellphoneNumber')
    match = Vouchers.query.filter_by(status="new", profile=amount).first()  # check if a voucher is available
    print(type(match))
    if match is None:  # no voucher available
        print("None if statement activated.")
        confirmation = {
            "message": "We do not have any of these voucher available at this time",
            "responseCode": 1  # response code of 1 indicates an error whereas 0 indicates a successful transaction
            # and a radius voucher has been received
        }
        api_response = app.response_class(
            response=json.dumps(confirmation),
            status=200,
            mimetype="application/json"
        )
        return api_response
    else:
        match.status = "issued"  # reserve voucher in DB
        match.phone_number = cellphone_number
        # match.voucher_pin = voucher_pin can't do this as this is unique and will cause a DB error if user tries to
        # reuse a 1FORYOU voucher
        print("reserving voucher code: " + match.name)
    try:
        db.session.commit()
    except Exception as e:
        confirmation = {
            "message": "Our system is not working at the moment. Please notify your provider or try again later",
            "responseCode": 1  # response code of 1 indicates an error whereas 0 indicates a successful transaction
            # and a radius voucher has been received
        }
        api_response = app.response_class(
            response=json.dumps(confirmation),
            status=200,
            mimetype="application/json"
        )
        print(e)
        return api_response
    #  response.headers.add('Access-Control-Allow-Origin', '*')
    response = redeem()
    print("The response from init.py is" + str(response))

    # Deal with errors connecting to 1FORYOU API
    if "keegan_says" in response:  # this value needs to be arbitrary so that we can return error codes. The name must
        # never match a 1FORYOU response
        confirmation = {
            "message": "There has been an error processing your voucher",
            "responseCode": 1  # response code of 1 indicates an error whereas 0 indicates a successful transaction
            # and a radius voucher has been received
        }
        api_response = app.response_class(
            response=json.dumps(confirmation),
            status=200,
            mimetype="application/json"
        )
        print("unreserving voucher code: " + match.name)
        match.status = "new"
        match.phone_number = ""
        try:
            db.session.commit()
        except Exception as e:
            confirmation = {
                "message": "Our system is not working at the moment. Please notify your provider or try again later",
                "responseCode": 1  # response code of 1 indicates an error whereas 0 indicates a successful transaction
                # and a radius voucher has been received
            }
            api_response = app.response_class(
                response=json.dumps(confirmation),
                status=200,
                mimetype="application/json"
            )
            print(e)
            return api_response
        return api_response  # automatically jsonify'd

    # Deal with response codes from 1FORYOU (v1.0.0)
    else:
        if response['responseCode'] == 0:  # 0 indicates a success
            print(match.name)
            confirmation = {
                "message": match.name,
                "responseCode": 0
            }
            api_response = app.response_class(
                response=json.dumps(confirmation),
                status=200,
                mimetype="application/json"
            )
            match.voucher_pin = voucher_pin
            try:
                db.session.commit()
            except Exception as e:
                print(e)
                return api_response  # do this so the user gets their voucher even if the DB fails
            return api_response
        elif response['responseCode'] == 2400:  # 2400 indicates insufficient funds
            confirmation = {
                "message": "Insufficient funds.",
                "responseCode": 1
            }
        elif response['responseCode'] == 2401:  # 2401 indicates the voucher has already been used
            confirmation = {
                "message": "This 1FORYOU voucher has already been used.",
                "responseCode": 1
            }
        elif response['responseCode'] == 2402:  # 2402 indicates the voucher cannot be found (pin is most likely
            # incorrect)
            confirmation = {
                "message": "1FORYOU voucher not found.",
                "responseCode": 1
            }
        else:  # catch other errors
            confirmation = {
                "message": "Your 1FORYOU voucher details are invalid",
                "responseCode": 1
            }
        api_response = app.response_class(
            response=json.dumps(confirmation),
            status=200,
            mimetype="application/json"
        )
        print("unreserving voucher code: " + match.name)
        match.status = "new"
        match.phone_number = ""
        try:
            db.session.commit()
        except Exception as e:
            confirmation = {
                "message": "Our system is not working at the moment. Please notify your provider or try again later",
                "responseCode": 1  # response code of 1 indicates an error whereas 0 indicates a successful transaction
                # and a radius voucher has been received
            }
            api_response = app.response_class(
                response=json.dumps(confirmation),
                status=200,
                mimetype="application/json"
            )
            print(e)
            return api_response
        return api_response  # automatically jsonify'd
