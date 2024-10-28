
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

### DockerCompose

