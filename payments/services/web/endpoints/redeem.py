from flask import request, json
import json as j
import requests
import datetime


def redeem():
    """
    Makes an API call to 1FORYOU using details provided by the redeem_voucher() endpoint.
    :return: an HTTP response indicating whether the 1FORYOU voucher redemption was successful
    """

    error_response = {"keegan_says": "unclassified"}  # this needs to contain a very specific key that wont be
    # returned by flash
    amount = -1
    voucher_choice = request.json.get('voucherChoice')

    if voucher_choice == 'TIME30M':
        amount = 100
    if voucher_choice == 'TIME1H':
        amount = 200
    if voucher_choice == 'TIME3H':
        amount = 500
    if voucher_choice == 'TIME10H':
        amount = 800
    if voucher_choice == 'TIME1D':
        amount = 1500
    if voucher_choice == 'TIME15D':
        amount = 4000
    if voucher_choice == 'TIME28D':
        amount = 6000

    if voucher_choice == 'DATA1G':
        amount = 1000
    elif voucher_choice == 'DATA5G':
        amount = 4000
    elif voucher_choice == 'DATA10G':
        amount = 8000
    elif voucher_choice == 'DATA100G':
        amount = 12000
    elif voucher_choice == 'DATA300G':
        amount = 20000
    elif voucher_choice == 'DATA500G':
        amount = 30000
    

    voucher_pin = request.json.get('voucherPin')
    cellphone_number = request.json.get('cellphoneNumber')
    cellphone_number = "27" + cellphone_number[1:]  # remove the first digit and add SA code
    current_time = datetime.datetime.now()
    time = current_time.year + current_time.month + current_time.day + current_time.hour + current_time.minute + current_time.second + current_time.microsecond
    request_id = voucher_pin + "-" + cellphone_number + "-" + str(abs(hash(voucher_pin + cellphone_number + str(time))))
    # print(request_id)
    access_token = generate_access_token()
    print("Sending request to flash")
    response = send_request(access_token=access_token, amount=amount, voucher_pin=voucher_pin,
                            cellphone_number=cellphone_number, request_id=request_id)
    if response.status_code == 200:
        try:
            response_as_json = response.json()
            print(response_as_json)
            return response_as_json
        except Exception:
            return Exception
    else:
        error_response["keegan_says"] = str(response.status_code)
        return error_response


def send_request(amount, request_id, voucher_pin, cellphone_number, access_token):
    """
    Send redemption request to 1FORYOU API
    :param amount: the rand amount in cents that will be subtracted from the 1FORYOU voucher
    :param request_id: a unique request ID
    :param voucher_pin: the user's 1FORYOU voucher pin
    :param cellphone_number: the user's cellphone number
    :param access_token: our bearer token
    :return: the 1FORYOU API response
    """
    url = "https://api.flashswitch.flash-group.com/1foryou/1.0.0/redeem"
    payload = j.dumps({
        "requestId": request_id,
        "voucherPin": voucher_pin,
        "amount": amount,
        "userId": "XXXX",
        "customerContact": {
            "mechanism": "SMS",
            "address": cellphone_number
        },
        "acquirer": {
            "account": {
                "accountNumber": "XXXX"
            }
        }
    })
    headers = {
        'Authorization': 'Bearer ' + access_token,
        'Content-Type': 'application/json'
    }
    response = requests.post(url, headers=headers, data=payload)
    return response


def generate_access_token():
    """
    Create a bearer token so we can access the 1FORYOU API
    :return: the bearer token
    """
    url_access_token = "https://api.flashswitch.flash-group.com/token"
    payload_access_token = 'XXXX'
    headers_access_token = {
        'Authorization': 'XXXX',
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    response_access_token = requests.request("POST", url_access_token, headers=headers_access_token,
                                             data=payload_access_token)
    response_access_token_as_json = response_access_token.json()
    access_token = response_access_token_as_json["access_token"]
    return access_token
