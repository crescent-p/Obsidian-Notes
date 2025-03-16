# Features
1) Login
2) upload finance data
3) analysis  of finance data
4) Payment data with finance insight
## LOGIN

	- People Involved: Ervin, Crescent
	- Google Sign in With our own backend for storing email (will serve as identifier for later)
	- API design 
		- POST - {str: email, str: google_oauth_token, str: name} 
			- verify email with token and return SUCCESS/FAILURE
	- App Side 
		- use google_o_auth to sign_in and send POST to GO backend
## Upload Finance data

https://developer.federalbank.co.in/fedbnkdev/dev/product/6051
	- DATA required
		- monthly budget ??
		- account number 
		- account name
		- username
		- password
	- Returned data will be of form
 ``` JSON
"statement": {
              "type": "array",
              "items": {
                "properties": {
                  "seq_num": {
                    "type": "number"
                  },
                  "foracid": {
                    "type": "string"
                  },
                  "tran_date": {
                    "type": "string"
                  },
                  "value_date": {
                    "type": "string"
                  },
                  "tran_id": {
                    "type": "string"
                  },
                  "tran_type": {
                    "type": "string"
                  },
                  "debit": {
                    "type": "number"
                  },
                  "credit": {
                    "type": "number"
                  },
                  "balance": {
                    "type": "number"
                  },
                  "crdr_flg": {},
                  "tran_particular": {
                    "type": "string"
                  },
                  "ref_num": {},
                  "tran_rmks": {},
                  "txn_datetime": {
                    "type": "string"
                  }
                },
                "type": "object"
              }
            },
```
### Retrieving user data. (just know it is possible at this stage.)
```python
import requests
import json
from datetime import datetime, timedelta

class FederalBankAPI:
    def __init__(self, client_id, client_secret, user_id, password):
        """
        Initialize the FederalBankAPI with authentication credentials.

        Args:
            client_id (str): The X-IBM-Client-Id.
            client_secret (str): The X-IBM-Client-Secret.
            user_id (str): The user ID for authentication.
            password (str): The password for authentication.
        """
        self.base_url = "https://devgateway.federalbank.co.in/fedbnkdev/dev/paylite"
        self.client_id = client_id
        self.client_secret = client_secret
        self.user_id = user_id
        self.password = password
        self.headers = {
            "X-IBM-Client-Id": self.client_id,
            "X-IBM-Client-Secret": self.client_secret,
            "Content-Type": "application/json"
        }

    def get_account_statement(self, sender_cd, account_num, date, seq_num=""):
        """
        Retrieve account statement for a specific account and date.

        Args:
            sender_cd (str): The sender code.
            account_num (str): The account number.
            date (str): The date for which to retrieve the statement (YYYY-MM-DD).
            seq_num (str, optional): The sequence number for pagination. Defaults to "".

        Returns:
            dict: A dictionary containing the API response or an error message.
        """
        endpoint = f"{self.base_url}/accountStatement"
        payload = {
            "account_statement_req": {
                "header": {
                    "user_id": self.user_id,
                    "password": self.password
                },
                "body": {
                    "sender_cd": sender_cd,
                    "account_num": account_num,
                    "date": date,
                    "seq_num": seq_num
                }
            }
        }

        try:
            response = requests.post(endpoint, headers=self.headers, json=payload)
            response.raise_for_status()  # Raise HTTPError for bad responses (4xx or 5xx)
            return response.json()  # Return the parsed JSON data
        except requests.exceptions.RequestException as e:
            return {"error": f"Request failed: {e}"}
        except json.JSONDecodeError:
            return {"error": "Failed to decode JSON response"}

# Usage Example
if __name__ == '__main__':
    # Replace with your actual credentials and account details
    CLIENT_ID = "YOUR_CLIENT_ID"
    CLIENT_SECRET = "YOUR_CLIENT_SECRET"
    USER_ID = "YOUR_USER_ID"
    PASSWORD = "YOUR_PASSWORD"
    SENDER_CODE = "YOUR_SENDER_CODE"
    ACCOUNT_NUMBER = "YOUR_ACCOUNT_NUMBER"

    # Initialize the API client
    api = FederalBankAPI(CLIENT_ID, CLIENT_SECRET, USER_ID, PASSWORD)

    # Get the date for the last month
    today = datetime.now()
    last_month_date = (today - timedelta(days=30)).strftime("%Y-%m-%d")

    # First API call
    response = api.get_account_statement(SENDER_CODE, ACCOUNT_NUMBER, last_month_date)

    # Process the response
    if "error" in response:
        print(f"Error: {response['error']}")
    else:
        print(f"Response: {response}")
        # Check if there's a last_seq_num for pagination
        last_seq_num = response.get("account_statement_resp", {}).get("last_seq_num")
        if last_seq_num:
            print(f"Next sequence number: {last_seq_num}")
            # Make subsequent calls using the last_seq_num
```

		Should store this data in relational database.
			1 : m relation from user_login with email and user to transactions table. (use non-relational maybe ??)
	How often should data be retirved and syned to datbase?? 
		- keep dedicated button ? 
		- use a sync interval ?
	 At this stage it is possible to login the user. Retrieve user transaction details and store it in a database.

## Educational part
	- Should include quizes
	- Should have material that can be read
		- maybe keep a facebook post kindof setup 
		- keep quizes related to the post at the end.
	- chatbot assistance for failed part and retries??
## QR Scanning and Receipt Scanning
	- Option to scan items. 
	- Should auto-detect ?? or keep as separate tabs?
	- Should accept a picture and return
		- type : [qr, Reciept]
		- if qr :
			- url
			- FOLLOW UP
				- ENTER AMOUNT 
					- send data to backend to analyze good or bad decision
				- Show a dialog box to indicate whether good or bad decision
					- on bad decision cancel request
				- on good request redirect to GPay
					- (we can implement our own payment method - but obviously we will put it as a "Coming SOOOn")
		- else 
			- reciept details 
				- should be simple
				- Contain
					- date
					- location?
					- item-price? just price of everything??
## Dashboard
	- graph like UI for reviewing spend and recieved data
	- Should have AI insight??
	- Data should be retrived from database. 
		- So AI insight should be baked in the response?
		- server should send data to AI backend and return the details within a single request...
