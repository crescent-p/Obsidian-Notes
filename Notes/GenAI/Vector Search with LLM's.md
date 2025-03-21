	- Use mongoDB
	- Setup is prettymuch straight
	- go to mongodb website create a new db
		- password is 1aA@GOOD
	- use string (remember to change <password> to 1aA@GOOD) and connect to VS Code MongoDB extension

## MongoDB
	- setup a venv with 'python -m venv venv' and source venv/bin/activate
	- pip install pymongo

	Connecting to the databse 
```python
import pymongo
from urllib.parse import quote_plus

username = quote_plus('crescentp2003') //conversion needed because of @ and other symbols
password = quote_plus('1aA@GOOD')

uri = "mongodb+srv://" + username + ":" + password + "@cluster0.bppjk.mongodb.net/?appName=Cluster0"
# Create a new client and connect to the server
client = pymongo.MongoClient(uri)

db = client.sample_mflix
collection = db.movies

```

### Using an embedding API with HugginFace
	- Create account
		- go to profile -> settings -> access tokens -> create new token
		- verify email and copy access token
```python
//Using hugginface API to generate a vector
hf_tokne = "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"
embedding_url = "https://api-inference.huggingface.co/pipeline/feature-extraction/sentence-transformers/all-MiniLM-L6-v2"


def create_embedding(text: str) -> List[float]:
    response = requests.post(embedding_url, headers={
                             "Authorization": "Bearer " + hf_tokne}, json={"inputs": text},)
    if (response.status_code != 200):
        print("ERROR")
```