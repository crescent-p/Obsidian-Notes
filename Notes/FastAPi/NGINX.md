
**Nginx** (pronounced "engine-x") is a high-performance web server and reverse proxy server. It is widely used for serving static content, handling concurrent connections, and acting as a load balancer or proxy for applications. Here are some key features and functions of Nginx:

### Key Features of Nginx:

1. **Reverse Proxy and Load Balancer**:
   - Nginx can serve as a reverse proxy, distributing client requests to various backend servers. This helps balance the load and improve performance and reliability.
   - It supports various load-balancing methods, including round-robin, least connections, and IP hash.

2. **Serving Static Content**:
   - Nginx is highly efficient at serving static files, such as HTML, CSS, JavaScript, and images, directly to clients.
   - It can handle a large number of simultaneous connections with low memory consumption.

3. **Fast and Efficient**:
   - Nginx is designed to handle high traffic and can serve thousands of simultaneous connections without significant resource usage.
   - It uses an asynchronous event-driven architecture, which enables it to be more efficient than traditional web servers that use a multi-threaded or process-based approach.

4. **SSL/TLS Support**:
   - Nginx provides built-in support for SSL/TLS, allowing secure HTTPS connections.
   - It can manage SSL termination, which means it can handle the encryption and decryption of HTTPS traffic.

5. **URL Rewriting and Redirection**:
   - Nginx supports URL rewriting and redirection, allowing you to manipulate incoming requests and manage routing effectively.

6. **WebSocket and HTTP/2 Support**:
   - Nginx supports WebSocket connections, enabling real-time communication between clients and servers.
   - It also supports HTTP/2, providing improved performance for web applications.

7. **Caching**:
   - Nginx can be configured to cache responses from backend servers, improving performance and reducing load on those servers.

8. **Logging and Monitoring**:
   - Nginx provides extensive logging capabilities, allowing administrators to monitor server performance and diagnose issues.

9. **Modular Architecture**:
   - Nginx has a modular architecture, allowing you to extend its functionality with various third-party modules.

### Common Use Cases for Nginx:

- **Web Server**: Serving static files and content for websites.
- **Reverse Proxy**: Forwarding requests to backend applications, such as web applications running on Node.js, Python, or PHP.
- **Load Balancer**: Distributing traffic among multiple servers to ensure availability and reliability.
- **API Gateway**: Managing and routing requests for microservices architectures.
- **SSL Termination**: Handling HTTPS traffic and improving security for web applications.

### Installation and Configuration:

Nginx can be installed on various operating systems, including Linux, Windows, and macOS. It is typically configured through a plain text file (`nginx.conf`), where you can specify server blocks, routing rules, and various settings.

### Example Configuration:

A simple example of an Nginx configuration to serve a static website might look like this:

```nginx
server {
    listen 80;  # Listen on port 80 for HTTP
    server_name example.com;  # Your domain name

    location / {
        root /var/www/html;  # Directory to serve files from
        index index.html index.htm;  # Default index file
    }

    error_page 404 /404.html;  # Custom error page
    location = /404.html {
        internal;
    }
}
```

### Conclusion:

Nginx is a powerful and flexible tool widely used in modern web architecture due to its speed, efficiency, and ability to handle a large number of connections simultaneously. Its versatility makes it suitable for various roles, from a simple web server to a complex load balancer and API gateway.


# Installation

`sudo apt install nginx -y`

`sudo systemctl start nginx`

For azure setup`
##### **Allow Traffic on HTTP/HTTPS Ports:**

By default, Azure blocks traffic to your VM except through SSH (port 22). You need to open the necessary ports for web traffic.

- **Open Port 80 (HTTP)** and **Port 443 (HTTPS)** in the Azure portal:

1. Go to your VM's **Networking** section.
2. Under **Inbound port rules**, click **Add inbound port rule**.
3. Configure the rule:
    - **Destination port ranges**: `80` for HTTP and `443` for HTTPS.
    - **Protocol**: TCP.
    - **Action**: Allow.
    - **Priority**: Lower number (higher priority).
    - **Name**: Name the rule, e.g., `AllowHTTP` or `AllowHTTPS`.

#### To go to default config

` cd /etc/nginx/sites-available/`

```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        server_name _; # replace with specific domain name like sanjeev.com
        
        location / {
                proxy_pass http://localhost:8000; #any url that matches / or beyond is proxied to localhost:8000
                proxy_http_version 1.1;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;
                proxy_redirect off;
        }

}
```

# Setting up for https

1) use .tech to get a free domain name using GitHub account. 
2) after that add your ip address to the A record and CNAME record.
3) Next get a SSL certificate. 
## How to use certbot

1. SSH into the server
    
    SSH into the server running your HTTP website as a user with sudo privileges.
    
2. Install snapd
    
    You'll need to install snapd and make sure you follow any instructions to enable classic snap support.
    
    Follow these instructions on [snapcraft's site to install snapd](https://snapcraft.io/docs/installing-snapd/).
    
    [install snapd](https://snapcraft.io/docs/installing-snapd/)
    
3. Remove certbot-auto and any Certbot OS packages
    
    If you have any Certbot packages installed using an OS package manager like `apt`, `dnf`, or `yum`, you should remove them before installing the Certbot snap to ensure that when you run the command `certbot` the snap is used rather than the installation from your OS package manager. The exact command to do this depends on your OS, but common examples are `sudo apt-get remove certbot`, `sudo dnf remove certbot`, or `sudo yum remove certbot`.
    
4. Install Certbot
    
    Run this command on the command line on the machine to install Certbot.
    
    sudo snap install --classic certbot
    
5. Prepare the Certbot command
    
    Execute the following instruction on the command line on the machine to ensure that the `certbot` command can be run.
    
    sudo ln -s /snap/bin/certbot /usr/bin/certbot
    
6. Choose how you'd like to run Certbot
    
    ### Either get and install your certificates...
    
    Run this command to get a certificate and have Certbot edit your nginx configuration automatically to serve it, turning on HTTPS access in a single step.
    
    sudo certbot --nginx
    
    ### Or, just get a certificate
    
    If you're feeling more conservative and would like to make the changes to your nginx configuration by hand, run this command.
    
    sudo certbot certonly --nginx
    
7. Test automatic renewal
    
    The Certbot packages on your system come with a cron job or systemd timer that will renew your certificates automatically before they expire. You will not need to run Certbot again, unless you change your configuration. You can test automatic renewal for your certificates by running this command:
    
    sudo certbot renew --dry-run
    
    The command to renew certbot is installed in one of the following locations:
    
    - `/etc/crontab/`
    - `/etc/cron.*/*`
    - `systemctl list-timers`
8. Confirm that Certbot worked
    
    To confirm that your site is set up properly, visit `https://yourwebsite.com/` in your browser and look for the lock icon in the URL bar.