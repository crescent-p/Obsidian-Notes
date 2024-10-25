
Store the variables inside your system. Instead of your program. That way it will be secure.

```python
from pydantic_settings import BaseSettings
class Settings(BaseSettings):
    database_hostname: str
    database_port: str
    database_password: str
    database_name: str
    database_username: str
    secret_key: str
    algorithm: str
    access_token_expire_min: int

    class Config:
        env_file = ".env"

settings = Settings()
```
Create a config.py file and store this in it.

Create another .env file in the main directory. 

```.env
DATABASE_HOSTNAME=localhost
DATABASE_PORT=5432
DATABASE_NAME=fastapi
DATABASE_USERNAME=crescent
SECRET_KEY=c57893382b253d4d67f3288a6e78aa64712e0773a0c11dad4b5bd5e4dbbac95d
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MIN=60
```

