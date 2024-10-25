[[password]] [[hash]] [[bcrypt]]

`pip install passlib[bcrypt]`


In main.py instantiate the functions
```python
from passlib.context import CryptContext
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto") # use bcrypt encrption
```

Passwords are hashed not encrypted like data. So its a one way operation. In order to validate the user on login. You will have to hash the password the user types in and compare the two.


# Handling JWT Tokens

`pip install python-jose[cryptography]`

`openssl rand -hex 32` to get a random string

```python
@router.post('/login')
async def login_user(user_credentials: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    query_res= db.query(models.Users).where(models.Users.email == user_credentials.username).first()
    
    if not query_res:
        dummy_check()
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid Credentials")

    if check(user_credentials.password, query_res.password):
        token = oauth.create_access_token({"used_id": query_res.id})
        return {"token" : token}
    else:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Wrong Password")

```

**Use `OAuth2PasswordRequestForm` to correctly handle form data. Like here the data need to included in the form-data section not the raw section in [[POSTMAN]]**
![[Pasted image 20241018112019.png]]

## Creating access tokens

```python

def create_access_token(data: dict):
    to_encode = data.copy() #not to tamper the send data

    expire = datetime.now() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    print(datetime.now())
    to_encode.update({"exp": expire})

    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

    return encoded_jwt
```

 