A REST API (Representational State Transfer Application Programming Interface) is a set of rules and conventions for building and interacting with web services. It uses standard HTTP methods and follows a stateless, client-server architecture.

### Key Concepts of REST API

1. **Resources**:
   - Resources are the fundamental units in REST architecture. Each resource is identified by a unique URL.
   - Resources can be any kind of object, data, or service that can be accessed and manipulated via a unique URL.

2. **HTTP Methods**:
   - REST APIs use standard HTTP methods to perform operations on resources. The main methods are:
     - `GET`: Retrieve data from a resource.
     - `POST`: Create a new resource.
     - `PUT`: Update an existing resource.
     - `DELETE`: Remove a resource.
     - `PATCH`: Partially update an existing resource.

3. **Statelessness**:
   - Each request from a client to the server must contain all the information the server needs to fulfill that request. The server does not store any client context between requests.

4. **Client-Server Architecture**:
   - The client handles the user interface and user state, while the server handles data storage and processing. This separation allows each to evolve independently.

5. **Uniform Interface**:
   - REST APIs follow a uniform interface, simplifying and decoupling the architecture. This interface includes:
     - Resource identification via URLs.
     - Manipulation of resources through representations.
     - Self-descriptive messages that include enough information to process the request.
     - Hypermedia as the engine of application state (HATEOAS), where clients interact with the application entirely through provided links.

6. **Layered System**:
   - A REST API can have multiple layers, such as security, load balancing, and caching layers, which are transparent to the client.

### Example REST API

Let's consider a REST API for a simple task management system with tasks as resources.

#### URL Structure:
- Base URL: `https://api.example.com/`
- Resource: `tasks`

#### HTTP Methods and Endpoints:
1. **GET /tasks**:
   - Retrieve a list of all tasks.
   - Example: `GET https://api.example.com/tasks`
   - Response:
     ```json
     [
       { "id": 1, "title": "Task 1", "completed": false },
       { "id": 2, "title": "Task 2", "completed": true }
     ]
     ```

2. **GET /tasks/{id}**:
   - Retrieve a specific task by its ID.
   - Example: `GET https://api.example.com/tasks/1`
   - Response:
     ```json
     { "id": 1, "title": "Task 1", "completed": false }
     ```

3. **POST /tasks**:
   - Create a new task.
   - Example: `POST https://api.example.com/tasks`
   - Request Body:
     ```json
     { "title": "New Task", "completed": false }
     ```
   - Response:
     ```json
     { "id": 3, "title": "New Task", "completed": false }
     ```

4. **PUT /tasks/{id}**:
   - Update an existing task.
   - Example: `PUT https://api.example.com/tasks/1`
   - Request Body:
     ```json
     { "title": "Updated Task", "completed": true }
     ```
   - Response:
     ```json
     { "id": 1, "title": "Updated Task", "completed": true }
     ```

5. **DELETE /tasks/{id}**:
   - Delete a specific task by its ID.
   - Example: `DELETE https://api.example.com/tasks/1`
   - Response:
     ```json
     { "message": "Task deleted" }
     ```

### Example Code

Here's an example implementation of a simple REST API using Flask in Python:

```python
from flask import Flask, request, jsonify

app = Flask(__name__)

tasks = [
    { "id": 1, "title": "Task 1", "completed": False },
    { "id": 2, "title": "Task 2", "completed": True }
]

@app.route('/tasks', methods=['GET'])
def get_tasks():
    return jsonify(tasks)

@app.route('/tasks/<int:task_id>', methods=['GET'])
def get_task(task_id):
    task = next((task for task in tasks if task['id'] == task_id), None)
    if task:
        return jsonify(task)
    return jsonify({'message': 'Task not found'}), 404

@app.route('/tasks', methods=['POST'])
def create_task():
    new_task = request.json
    new_task['id'] = len(tasks) + 1
    tasks.append(new_task)
    return jsonify(new_task), 201

@app.route('/tasks/<int:task_id>', methods=['PUT'])
def update_task(task_id):
    task = next((task for task in tasks if task['id'] == task_id), None)
    if task:
        task.update(request.json)
        return jsonify(task)
    return jsonify({'message': 'Task not found'}), 404

@app.route('/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    global tasks
    tasks = [task for task in tasks if task['id'] != task_id]
    return jsonify({'message': 'Task deleted'})

if __name__ == '__main__':
    app.run(debug=True)
```

### Summary
- **REST API**: A set of rules for building web services that use HTTP methods to manipulate resources identified by URLs.
- **HTTP Methods**: `GET`, `POST`, `PUT`, `DELETE`, `PATCH`.
- **Statelessness**: Each request contains all necessary information.
- **Client-Server Architecture**: Separation of client and server concerns.
- **Uniform Interface**: Standardized way to interact with resources.
- **Layered System**: Ability to have multiple layers in the architecture.

REST APIs are widely used due to their simplicity, scalability, and flexibility, making them a fundamental part of modern web development.