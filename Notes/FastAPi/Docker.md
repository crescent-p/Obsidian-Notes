
Create an Image that contains everything to run our application. 

Docker is a platform designed to make it easier to create, deploy, and run applications by using containers. Containers allow developers to package up an application with all parts it needs, such as libraries and other dependencies, and ship it all out as one package. This ensures that the application will run on any other Linux machine regardless of any customized settings that machine might have that could differ from the machine used for writing and testing the code.

### Basic Concepts

- **Docker Engine**: The runtime that manages containers.
- **Images**: Read-only templates that are used to create containers. Images are typically built from a Dockerfile.
- **Containers**: Instances of Docker images. They are lightweight and portable encapsulations of an environment in which to run applications.
- **Dockerfile**: A script containing a series of commands to build a Docker image.
- **Docker Hub**: A cloud-based registry service which allows you to link to code repositories, build your images, and test them. It provides a centralized resource for container image discovery, distribution, and change management.

### Basic Commands

1. **Install Docker**:
   - [Install Docker](https://docs.docker.com/get-docker/) from the official Docker website.

2. **Check Docker Version**:
   ```sh
   docker --version
   ```

3. **Run a Docker Container**:
   ```sh
   docker run hello-world
   ```

4. **List Docker Containers**:
   ```sh
   docker ps -a
   ```

5. **Build an Image from a Dockerfile**:
   ```sh
   docker build -t my-image:tag .
   ```

6. **List Docker Images**:
   ```sh
   docker images
   ```

7. **Stop a Running Container**:
   ```sh
   docker stop <container_id>
   ```

8. **Remove a Docker Container**:
   ```sh
   docker rm <container_id>
   ```

9. **Remove a Docker Image**:
   ```sh
   docker rmi <image_id>
   ```

10. **Docker Compose**:
    Docker Compose is a tool for defining and running multi-container Docker applications. A `docker-compose.yml` file is used to configure your application's services.
    - **Starting Services**:
      ```sh
      docker-compose up
      ```
    - **Stopping Services**:
      ```sh
      docker-compose down
      ```

### Example Dockerfile

Here's an example Dockerfile for a simple Node.js application:

```Dockerfile
# Use the official Node.js image from the Docker Hub
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Command to run the application
CMD ["node", "app.js"]
```

### Example `docker-compose.yml`

Here’s an example `docker-compose.yml` for a Node.js application and a MongoDB service:

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db

  db:
    image: mongo:4.2
    ports:
      - "27017:27017"
```

### Using Docker in Development

Docker is particularly useful in development for creating a consistent environment across different stages of development, testing, and production. It helps in:

- Simplifying dependency management.
- Providing environment parity.
- Scaling applications seamlessly.

For any specific use cases or advanced configurations, referring to the [official Docker documentation](https://docs.docker.com/) would be highly beneficial.

```Dockerfile
FROM python:3.9.7

#changes the dir to this
WORKDIR /usr/src/app

#to optimise for docker caching. if requirements didnt change then the dockerfile woudlnt be rebuild

COPY requirements.txt ./

RUN pip3 install -r requirements.txt

#copy all source files from current directory to image
COPY . .

#any command you wanna run, put it inside CMD, spaces = new word, weird.

CMD [ "uvicorn", "apps.main:app", "--host", "0.0.0.0", "--port", "8000" ]

#To build the image
#docker build -t <nameOfImage> <whereTheDockerFileis>
```

# DockerCompose

Docker Compose is a tool that allows you to define and manage multi-container Docker applications. Using a `docker-compose.yml` file, you can specify the services, networks, and volumes needed for your application.

Here’s a step-by-step guide to setting up Nginx with Docker Compose:

1. **Create a Project Directory**:
   Create a new directory for your project and navigate into it.

   ```sh
   mkdir nginx-docker-compose
   cd nginx-docker-compose
   ```

2. **Create a Dockerfile for Nginx**:
   In this directory, create a file named `Dockerfile`.

   ```sh
   touch Dockerfile
   ```

3. **Write the Dockerfile**:
   Open the `Dockerfile` in a text editor and add the following content:

   ```Dockerfile
   # Use the official Nginx image from Docker Hub
   FROM nginx:latest

   # Copy custom configuration file from the current directory
   # to the /etc/nginx/conf.d/ directory in the container
   COPY nginx.conf /etc/nginx/conf.d/default.conf

   # Copy static website files (if any)
   COPY . /usr/share/nginx/html

   # Expose port 80 to the outside world
   EXPOSE 80
   ```

4. **Create a Custom Nginx Configuration File**:
   Create a file named `nginx.conf` in the same directory. This file will contain your custom Nginx configuration. Here's an example configuration:

   ```nginx
   server {
       listen 80;
       server_name localhost;

       location / {
           root /usr/share/nginx/html;
           index index.html;
       }

       error_page 500 502 503 504 /50x.html;
       location = /50x.html {
           root /usr/share/nginx/html;
       }
   }
   ```

5. **Create Static Files (Optional)**:
   If you have static files (like an `index.html` file), place them in the same directory. For example, create a simple `index.html` file:

   ```html
   <!DOCTYPE html>
   <html>
   <head>
       <title>Welcome to Nginx!</title>
   </head>
   <body>
       <h1>Hello, Docker with Nginx and Docker Compose!</h1>
   </body>
   </html>
   ```

6. **Create a `docker-compose.yml` File**:
   Create a file named `docker-compose.yml` in the same directory. This file defines your services and their configurations. Add the following content:

   ```yaml
   version: '3.8'

   services:
     web:
       build: .
       ports:
         - "80:80"
   ```

   This configuration defines a service named `web` that builds the Docker image from the current directory and maps port 80 of the host to port 80 of the container.

7. **Build and Start the Services**:
   Use Docker Compose to build and start your services:

   ```sh
   docker-compose up --build
   ```

   The `--build` flag ensures that Docker Compose rebuilds the image if there are any changes.

8. **Test the Setup**:
   Open a web browser and navigate to `http://localhost`. You should see the "Hello, Docker with Nginx and Docker Compose!" message from your `index.html` file.

Docker Compose is a tool that allows you to define and manage multi-container Docker applications. Using a `docker-compose.yml` file, you can specify the services, networks, and volumes needed for your application.

Here’s a step-by-step guide to setting up Nginx with Docker Compose:

1. **Create a Project Directory**:
   Create a new directory for your project and navigate into it.

   ```sh
   mkdir nginx-docker-compose
   cd nginx-docker-compose
   ```

2. **Create a Dockerfile for Nginx**:
   In this directory, create a file named `Dockerfile`.

   ```sh
   touch Dockerfile
   ```

3. **Write the Dockerfile**:
   Open the `Dockerfile` in a text editor and add the following content:

   ```Dockerfile
   # Use the official Nginx image from Docker Hub
   FROM nginx:latest

   # Copy custom configuration file from the current directory
   # to the /etc/nginx/conf.d/ directory in the container
   COPY nginx.conf /etc/nginx/conf.d/default.conf

   # Copy static website files (if any)
   COPY . /usr/share/nginx/html

   # Expose port 80 to the outside world
   EXPOSE 80
   ```

4. **Create a Custom Nginx Configuration File**:
   Create a file named `nginx.conf` in the same directory. This file will contain your custom Nginx configuration. Here's an example configuration:

   ```nginx
   server {
       listen 80;
       server_name localhost;

       location / {
           root /usr/share/nginx/html;
           index index.html;
       }

       error_page 500 502 503 504 /50x.html;
       location = /50x.html {
           root /usr/share/nginx/html;
       }
   }
   ```

5. **Create Static Files (Optional)**:
   If you have static files (like an `index.html` file), place them in the same directory. For example, create a simple `index.html` file:

   ```html
   <!DOCTYPE html>
   <html>
   <head>
       <title>Welcome to Nginx!</title>
   </head>
   <body>
       <h1>Hello, Docker with Nginx and Docker Compose!</h1>
   </body>
   </html>
   ```

6. **Create a `docker-compose.yml` File**:
   Create a file named `docker-compose.yml` in the same directory. This file defines your services and their configurations. Add the following content:

   ```yaml
   version: '3.8'

   services:
     web:
       build: .
       ports:
         - "80:80"
   ```

   This configuration defines a service named `web` that builds the Docker image from the current directory and maps port 80 of the host to port 80 of the container.

7. **Build and Start the Services**:
   Use Docker Compose to build and start your services:

   ```sh
   docker-compose up --build
   ```

   The `--build` flag ensures that Docker Compose rebuilds the image if there are any changes.

8. **Test the Setup**:
   Open a web browser and navigate to `http://localhost`. You should see the "Hello, Docker with Nginx and Docker Compose!" message from your `index.html` file.

### Full Directory Structure

Your project directory should look like this:

```
nginx-docker-compose/
├── Dockerfile
├── docker-compose.yml
├── nginx.conf
└── index.html
```

### Managing the Application

- **To stop the services**:

  ```sh
  docker-compose down
  ```

- **To view logs**:

  ```sh
  docker-compose logs
  ```

- **To run the services in detached mode**:

  ```sh
  docker-compose up -d
  ```

Using Docker Compose simplifies the process of setting up and managing multi-container Docker applications, allowing you to define everything in a single `docker-compose.yml` file. This approach ensures consistency and makes it easy to share your setup with others.