[[uvicorn]] [[Python]] [[fastapi]]
``` python
from fastapi import FastAPI

  

app = FastAPI()
  
# know as path operation or route
@app.get('/')
#normal async needed for talking with DB
async def root():
    return {'message': 'Hello world'}
```

Starting up uvicorn
```bash
uvicorn main:app
```

How to reload server? 

`uvicorn main:app --reload` ! only try in dev env

Order of checking the path. 
	method + name + first occurrence in code.
	![[Pasted image 20241014231043.png]]
	here message: hello world would be displayed first.

[[POSTMAN]] Tool to develop api's

[[POST]] 
```python
@app.post('/createposts')

async def create_post(payload: dict = Body(...)):

    print(payload)

    return {"message": 'Successfully creted'}
```
payload is just a variable of type dict aka dictionary. Body is a FastAPI function that converts json to dict format.

