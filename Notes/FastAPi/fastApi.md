Returning status code
```python
from fastapi import Body, FastAPI, Response, status
@app.get('/posts/{id}')

async def get_post(id: int, response: Response):
    post = find_post(int(id))
    if(not post):
        response.status_code = status.HTTP_404_NOT_FOUND
    return post
```

[[HTTP]] [[HTTP methods]]
 ```python
 @app.get('/posts/{id}')

async def get_post(id: int, response: Response):
    post = find_post(int(id))
    if(not post):
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"post with {id} not found")
    # if(not post):
    #     response.status_code = status.HTTP_404_NOT_FOUND
    return post
```

According to documentation every time something is created we need to send back a 201 

```python
class Posts(BaseModel):
    title: str
    content: str
    published: bool = True
    rating: Optional[int] = None

@app.post('/createposts', status_code=status.HTTP_201_CREATED)

async def create_post(posts: Posts):
    my_post = posts.model_dump()
    my_post['id'] = randrange(0, 100000)
    my_posts.append(my_post)
    return {"body": my_post}
```

### Deleting a post
```python
@app.delete('/posts/{id}', status_code=status.HTTP_204_NO_CONTENT)
async def delete_post(id: int, response: Response):
    index = find_index_post(id)
    if(index == -1):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST)
    else:
        my_posts.pop(index)
        #return {"message": "succesffully deletd"}
```
After deleting a post nothing should be sent back. So don't sent any data back.

### Update
```python
@app.put('/posts/{id}')
async def update_post(id: int, post: Posts):
    index = find_index_post(id)
    if(index == -1):
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"The said id {id} doesn't exist")
    else:
        post_dic = post.model_dump()
        post_dic['id'] = id
        my_posts[index] = post_dic
        return {"Message": "the message is updated"}

```
According to convention 202 No Content is returned on successful updating.
- **200 OK**: Often used when the updated resource or some information needs to be returned in the response.
- **204 No Content**: Indicates success but doesn’t return any content, typically used when no further information is required after the update.
- **201 Created**: Used when an update leads to the creation of a new resource.

## Documentation

```http
http://localhost:8000/docs
```
