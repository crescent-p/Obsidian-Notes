
[[ORM]] [[Python backend Development/Python]] [[Relational]] [[DBMS]] [[SQL]]

A layer of abstraction between DBMS and us.  We don't have to work with raw SQL. We can use python code.

### Install SqlAlchemy

`pip install sqlalchemy`


### Setting up the database.py file in apps 

```python
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker  

SQLALCHEMY_DATABASE_URL = 'postgresql://crescent:password@localhost/fastapi'

engine = create_engine(SQLALCHEMY_DATABASE_URL)

SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)

Base = declarative_base()
```

initializing in main.py
```python
from . import models
from .database import engine
from .database import SessionLocal

models.Base.metadata.create_all(bind=engine)

#Dependency injection method 
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close() #similar to dependenct injection
```
### What is yield in python ?
	
- **`SessionLocal()`**: This creates a new database session.
- **`yield db`**: Instead of returning the database session, the function yields it. When `yield` is called, the function pauses, and control is transferred to the calling code, allowing the caller to use the yielded `db` object (the database session).
- **`finally` block**: After the caller is done with the session (i.e., after the function resumes), the `finally` block ensures that the session is properly closed, even if an exception occurs


##### SQLAlchemy doesn't do migrations, so if you want to update a database column, you need to drop the entire column and restart the application.

## Creating a post using [[ORM]]
```python
@app.post('/createposts', status_code=status.HTTP_201_CREATED)
async def create_post(posts: Posts, db: Session = Depends(get_db)):
    new_post = models.Post(title=posts.title, content=posts.content, published=posts.published)
    db.add(new_post)
    db.commit()
    db.refresh(new_post)
    return {"body": new_post}
```
instead of typing out posts = modles.post
You can instead use ** to unpack a dictionary.
	So pydantic model -> dict -> unpacked to said model.

### `db: Session = Depends(get_db)` What does this do?

- **`db: Session`**: This specifies that the variable `db` will be of type `Session`, which is typically an [[SQLAlchemy]] database session. This means that in the function where this line is used, the `db` variable will represent an active [[database]] session.
    
- **`Depends(get_db)`**: This is FastAPI's **dependency injection** mechanism. The `Depends()` function tells FastAPI that it should call the `get_db()` function to provide the value of `db`.
	- Here’s what happens:
		1. FastAPI sees `db: Session = Depends(get_db)` and knows it needs to call the `get_db()` function.
		2. FastAPI calls `get_db()`, which creates and yields a new database session (`db`).
		3. FastAPI injects this `db` session into the `get_posts()` function.
		4. You can now use `db` inside `get_posts()` to query or modify the database.
		5. After the function finishes, [[FastAPI]] ensures the database session is properly closed.

# What is the difference between pydantic models and ORM models

- **Pydantic Models**: Are often used as data transfer objects (DTOs). For example, when handling a request or returning a response, you typically use a Pydantic model to define the expected data format.
- **ORM Models**: Are used to interact with the database. You usually retrieve an ORM model from the database, perform operations on it, and then serialize it into a Pydantic model for returning in API responses.

## Setting up a Response Model
```python
class Post(BaseModel):
    title: str
    content: str
    published: bool = True

    class Config:
        orm_mode = True
```

orm_mode enables reading the model as both a dictionary and as an attribute. `model['id']` as well as `mode.id`.
By default Pydantic only reads dictionaries.

```python
@app.post('/createposts', status_code=status.HTTP_201_CREATED, response_model=schemas.Post)
async def create_post(posts: PostBase, db: Session = Depends(get_db)):
    new_post = models.Post(**posts.model_dump())
    db.add(new_post)
    db.commit()
    db.refresh(new_post)
    return new_post
```

==Add the parameter `response_model=schemas.Post` to hint python that the response model is a Pydantic Model.==


```python
@app.get('/', status_code=status.HTTP_200_OK, response_model=List[schemas.Post]) # To return a List of posts. It'a all about hinting or giving the return class.
async def root(db : Session = Depends(get_db)):
    posts = db.query(models.Post).all()
    return posts
```

## Returning the data of a related table, Much like joining a table

```python
class Post(Base):
    __tablename__ = "posts"
    
    id = Column(Integer, primary_key=True, nullable=False)
    title = Column(String, nullable=False)
    content = Column(String, nullable=False)
    published = Column(Boolean, default=True, server_default='TRUE')
    created_at = Column(TIMESTAMP(timezone=True), server_default=text('now()'), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    owner = relationship("Users") # add this to return the data on retrieval. It automatically looks up Users table and retires the connected data. :0
```

Update the schema of response_model as well.

```python
class Post(PostBase):
    id: int
    created_at: Optional[datetime]
    user_id: int
    owner: UserResponse
    
    class Config:
        from_attributes = True
```