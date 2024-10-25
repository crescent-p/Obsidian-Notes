
`cd /etc/systemd/system` contains all the services

Create a guicorn-service file.
The name should be what you type after `systemctl start <name>'.
filtename = [name].service



```
[Unit]
Description=fastapi service
After=network.target

[Service]
User=crescent
Group=crescent
WorkingDirectory=/home/crescent/FastAPI/src
Environment="PATH=/home/crescent/FastAPI/src/venv/bin"
EnvironmentFile=/home/crescent/FastAPI/.env
ExecStart=/home/crescent/FastAPI/src/venv/bin/gunicorn -w 1 -k uvicorn.workers.UvicornWorker apps.main:app --bind 0.0.0.0:8000

[Install]
WantedBy=multi-user.target

```

-----------------------------------------------------------------------------------------------------------------------------------------
### Explanation
The provided file is a systemd service unit file named [gunicorn.service](vscode-file://vscode-app/c:/Users/cresc/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.esm.html). This file is used to configure and manage the FastAPI application as a service on a Linux system. Let's break down each section of the file:

### [Unit] Section

The `[Unit]` section contains metadata and dependencies for the service.

- `Description=fastapi service`: This line provides a brief description of the service, indicating that it is a FastAPI service.
- `After=network.target`: This line specifies that the service should start only after the network has been initialized.

### [Service] Section

The `[Service]` section defines how the service should be run.

- `User=crescent` and `Group=crescent`: These lines specify the user and group under which the service will run. Running services under a specific user and group can enhance security by limiting permissions.
- `WorkingDirectory=/home/crescent/FastAPI/src`: This line sets the working directory for the service. It ensures that the service runs from the specified directory, which is where the FastAPI application code resides.
- `Environment="PATH=/home/crescent/FastAPI/src/venv/bin"`: This line sets the environment variable [`PATH`](vscode-file://vscode-app/c:/Users/cresc/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.esm.html) to include the virtual environment's binary directory. This ensures that the service uses the correct Python interpreter and dependencies from the virtual environment.
- `ExecStart=/home/crescent/FastAPI/venv/bin/gunicorn -w 1 -k uvicorn.workers.UvicornWorker apps.main:app --bind 0.0.0.0:8000`: This line specifies the command to start the service. It uses Gunicorn with Uvicorn workers to serve the FastAPI application. The `-w 1` option specifies that one worker process should be used, and `--bind 0.0.0.0:8000` binds the service to all network interfaces on port 8000. The `apps.main:app` part points to the FastAPI application instance.

### [Install] Section

The `[Install]` section defines how the service should be installed and started.

- `WantedBy=multi-user.target`: This line specifies that the service should be started in the `multi-user` runlevel, which is a common runlevel for non-graphical multi-user systems. This ensures that the service is started automatically when the system reaches this runlevel.

In summary, this [gunicorn.service](vscode-file://vscode-app/c:/Users/cresc/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.esm.html) file configures a FastAPI application to run as a systemd service, ensuring it starts after the network is available, runs under a specific user and group, uses a virtual environment, and is served by Gunicorn with Uvicorn workers.

-----------------------------------------------------------------------------------------------------------------------------------------

## Setting up service to start on reboot.

`sudo systemctl enable <nameofservice>`

