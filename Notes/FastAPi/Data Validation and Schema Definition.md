[[Python backend Development/Python]] [[fastApi]] [[database]] [[pydantic]]

`from pydantic import BaseModel`

Pydantic supports Python's native types, and it extends them with additional functionality.

- **`int`**: Standard integer type.
- **`float`**: Floating-point numbers.
- **`str`**: Strings.
- **`bool`**: Boolean values.
- **`list`**: Lists of elements.
- **`tuple`**: Tuples, with fixed size and types if specified.
- **`dict`**: Dictionaries, where you can specify the types for keys and values.
- **`set`**: Sets of elements.
```python
class Posts(BaseModel):
    title: str
    content: str
    published: bool = True
    rating: Optional[int] = None #optional

  
@app.post('/createposts')
async def create_post(posts: Posts):
    return {"title": f"The message was { payload['message'] }"}
```

FastAPI automatically validates if incoming data is in correct format

```Json
{
    "title": "here's some data",
    "content": "this is hello"
}
``` 
The word need to match word for word titleee won't work.

also if you give a value inside the class itself, provide a value like for "published"

The converted model now called posts also has a function to turn it back into a map.

```python
class Posts(BaseModel):
    title: str
    content: str
    published: bool = True
    rating: Optional[int] = None

@app.post('/createposts')
async def create_post(posts: Posts):
    print(posts.model_dump()) #posts.dict() is deprecated
    return {"title": f"The message was {posts.content} and it is {'yes' if posts.published else 'no'}"}
```
