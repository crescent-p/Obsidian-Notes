
**CORS** (Cross-Origin Resource Sharing) is a security feature implemented by web browsers to control how resources are requested from a different origin (domain, protocol, or port) than the one that served the original web page.

### What Does CORS Do?

By default, web browsers block certain types of requests made to different origins for security reasons. CORS provides a way for servers to relax this restriction and allow specific cross-origin requests.

For example, if you have a frontend web application hosted at `https://frontend.com`, and it tries to make an API request to `https://api.backend.com`, the browser's **same-origin policy** would typically block this request. CORS allows `https://api.backend.com` to explicitly permit requests from `https://frontend.com`.

### CORS Workflow:

When a browser detects that a cross-origin request is being made, it sends an **OPTIONS** request (called a preflight request) to the server to check whether the server allows the cross-origin request. The server then responds with CORS headers indicating if the request is allowed.

If the response includes appropriate CORS headers, the actual request (GET, POST, etc.) proceeds. Otherwise, the browser blocks the request.

### CORS Headers:

To allow cross-origin requests, the server must include specific headers in the response, such as:

1. **Access-Control-Allow-Origin**: Specifies which origins are allowed to access the resource. It can be a specific domain (e.g., `https://frontend.com`) or `*` to allow any origin.

   Example:
   ```
   Access-Control-Allow-Origin: https://frontend.com
   ```

2. **Access-Control-Allow-Methods**: Specifies which HTTP methods (e.g., GET, POST, PUT) are allowed for cross-origin requests.

   Example:
   ```
   Access-Control-Allow-Methods: GET, POST, PUT
   ```

3. **Access-Control-Allow-Headers**: Specifies which HTTP headers can be used when making the actual request.

   Example:
   ```
   Access-Control-Allow-Headers: Content-Type, Authorization
   ```

4. **Access-Control-Allow-Credentials**: Indicates whether cookies or other credentials are allowed to be sent in the request.

   Example:
   ```
   Access-Control-Allow-Credentials: true
   ```

### Simple CORS Example:

For a typical GET request:

1. **Request**:
   The frontend app sends a request from `https://frontend.com` to the backend at `https://api.backend.com`.

2. **Response** (from backend server):
   If the backend allows CORS for the origin `https://frontend.com`, the response headers might look like this:

   ```http
   HTTP/1.1 200 OK
   Access-Control-Allow-Origin: https://frontend.com
   Access-Control-Allow-Methods: GET, POST
   Access-Control-Allow-Headers: Content-Type
   ```

The browser checks these headers and, if they permit the request, allows the frontend to access the resource.

### Preflight Request:

For non-simple requests (e.g., requests with methods like `PUT` or `DELETE` or requests that include custom headers), the browser will send an **OPTIONS** preflight request first.

1. **Preflight Request (OPTIONS)**:
   ```http
   OPTIONS /some-resource HTTP/1.1
   Origin: https://frontend.com
   Access-Control-Request-Method: PUT
   Access-Control-Request-Headers: Content-Type
   ```

2. **Preflight Response (from backend)**:
   ```http
   HTTP/1.1 204 No Content
   Access-Control-Allow-Origin: https://frontend.com
   Access-Control-Allow-Methods: PUT, GET, POST
   Access-Control-Allow-Headers: Content-Type
   ```

If the preflight request succeeds, the actual `PUT` request is then sent.

### Common Use Cases:

- **Web APIs**: When you have a frontend (React, Angular, etc.) hosted on a different domain than your backend (Node.js, Django, etc.), CORS must be configured to allow the frontend to make requests to the backend.
- **Single Page Applications (SPA)**: SPAs often make AJAX requests to REST APIs hosted on different domains, requiring CORS setup.

### Handling CORS in FastAPI:

In FastAPI, you can easily enable CORS using the `CORSMiddleware`:
```

[[HTTP]]
```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://frontend.com"],  # Can also use ["*"] to allow all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all HTTP methods
    allow_headers=["*"],  # Allows all headers
)

@app.get("/")
async def read_root():
    return {"message": "Hello, World!"}
```


### Summary:

- **CORS** enables web applications to make requests to domains other than the one serving the application.
- **CORS Headers** are set by the server to specify which origins, methods, and headers are allowed.
- FastAPI and other frameworks provide easy ways to configure CORS policies to allow or restrict cross-origin requests.