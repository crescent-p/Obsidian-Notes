Create a folder called routes and create files for each time of API calls.

`router = APIRouter(prefix="/users", tags=["users"])` 
Add appropriate routers at the start of each router file.

```python
app.include_router(posts.router)
app.include_router(users.router)
```
Import the router files in main.py and add them to the app router list.

