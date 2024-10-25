![[Pasted image 20241015001549.png]]

```python
@app.get("/posts/{id}")
def main():
	print(id)
	return
```


==Always use plural form. not Post but Posts==


Path parameters are always read as strings be sure to convert back to int if necessary.

## Query Parameters

`{{URL}}posts?limit=130` ~ pass in the variable after the question mark

```python
@router.get('/', response_model=List[schemas.Post])
async def get_all_posts(db: Session = Depends(get_db), limit: int = 10): # add a variable to be captured.
    return db.query(models.Post).limit(limit=limit)
```

