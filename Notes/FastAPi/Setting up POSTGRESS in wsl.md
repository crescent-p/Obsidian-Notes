To install PostgreSQL on a Linux system, you can follow these steps. The process may vary slightly depending on your Linux distribution, but the following instructions cover popular distributions like Ubuntu, Debian, and CentOS.

### For Ubuntu/Debian-based Systems

1. **Update the package list**:
   Open a terminal and run the following command to update your package list:
   ```bash
   sudo apt update
   ```

2. **Install PostgreSQL**:
   Install PostgreSQL along with its `contrib` package, which provides additional functionality:
   ```bash
   sudo apt install postgresql postgresql-contrib
   ```

3. **Start PostgreSQL service**:
   Once installed, PostgreSQL starts automatically. If it doesn't, start the service manually:
   ```bash
   sudo systemctl start postgresql
   ```

4. **Enable PostgreSQL service to start on boot**:
   To ensure that PostgreSQL starts on boot:
   ```bash
   sudo systemctl enable postgresql
   ```

5. **Verify installation**:
   Check if PostgreSQL is running by executing:
   ```bash
   sudo systemctl status postgresql
   ```

# 6. **Access the PostgreSQL prompt**:
   PostgreSQL creates a default user named `postgres`. To access the PostgreSQL prompt, you need to switch to the `postgres` user and then launch the PostgreSQL shell (`psql`):
   ```bash
   sudo -i -u postgres
   psql
   ```

7. **Exit the PostgreSQL prompt**:
   After you are done, type `\q` to exit the PostgreSQL prompt.

### Post-Installation Setup

1. **Set a password for the `postgres` user**:
   In the `psql` shell, run:
   ```sql
   ALTER USER postgres PASSWORD 'your_password';
   ```

2. **Create a new user or database**:
   You can create a new database and user by executing:
   ```sql
   CREATE DATABASE mydatabase;
   CREATE USER crescentp WITH ENCRYPTED PASSWORD 'yourhonor';
   GRANT ALL PRIVILEGES ON DATABASE OGS_DB TO crescentp;
   ```

3. **Configure remote access (optional)**:
   To allow remote connections, you need to edit the `postgresql.conf` and `pg_hba.conf` files, typically located in `/etc/postgresql/<version>/main/` (for Ubuntu/Debian) or `/var/lib/pgsql/<version>/data/` (for CentOS/RHEL).

   In `postgresql.conf`, update the `listen_addresses` setting:
   ```conf
   listen_addresses = '*'
   ```

   In `pg_hba.conf`, add a rule to allow remote access:
   ```conf
   host    all             all             0.0.0.0/0               md5
   ```

   Restart PostgreSQL after making these changes:
   ```bash
   sudo systemctl restart postgresql
   ```

You now have PostgreSQL installed and running on your Linux system!

### default port = 5432

# Setting up pgAdmin
To install **pgAdmin** (a popular PostgreSQL GUI) on Linux, follow the steps below based on your Linux distribution.

### For Ubuntu/Debian-based Systems:

1. **Install the required dependencies**:
   First, update your package list and install the required packages:

   ```bash
   sudo apt update
   sudo apt install curl ca-certificates gnupg
   ```

2. **Add the pgAdmin repository**:
   Add the pgAdmin APT repository to your system:

   ```bash
   curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo tee /etc/apt/trusted.gpg.d/pgadmin.asc
   ```

   Then, create a new source list file for the repository:

   ```bash
   sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
   ```

3. **Install pgAdmin**:
   Install `pgAdmin4` using the following command:

   ```bash
   sudo apt install pgadmin4
   ```

4. **Configure pgAdmin**:
   After installation, pgAdmin can be run in two modes: Desktop mode (for running as a native application) or Web mode (for running in a web browser).

   - **For Desktop Mode** (use pgAdmin as a desktop application):

     ```bash
     sudo apt install pgadmin4-desktop
     ```

5. **Start pgAdmin**:
   - If you installed the desktop mode, you can start pgAdmin from your applications menu.

### Conclusion:
After completing the steps, pgAdmin will be installed, and you can manage your PostgreSQL databases using its user-friendly GUI interface. Whether in desktop or web mode, pgAdmin makes it easier to interact with PostgreSQL.


# Setting up postgress with WSL

install pgAdmin in windows. 
create a user in wsl with name and password. 
Connect to the database with 
	-> create new server with name as localhost.
	-> go to connection 
		-> set hostname/address as localhost
		-> username as the same as you set up in wsl
		-> password the same. 
		i used crescent and password.
#### Use wsl cmd line to create a user and password.
Use create new server to connect to that user and password. Keep the maintenance server as postgres.


# Connecting python to database.
[[Database]] [[Postgress]]
1) install library `pip install psycopg2-binary`
```python
import time
import psycopg2
from psycopg2.extras import RealDictCursor

while True:
    try:
        conn = psycopg2.connect(host="localhost", database='fastapi',user='crescent', 
                                password='password', cursor_factory=RealDictCursor)
        cursor = conn.cursor
        print("Connected Succesfully")
        break
    except Exception as error:
        print(str(error))
        time.sleep(2)

```

## Querying using the cursor
```python
@app.get('/')
async def root():
    posts = cursor.execute("""SELECT * FROM products""")
    print(posts)
    return {'message': my_posts}
```

## Inserting something into a database and commiting it

```python
@app.post('/createposts', status_code=status.HTTP_201_CREATED)
async def create_post(posts: Posts):
    cursor.execute("""INSERT INTO posts (title, content, published) VALUES (%s, %s, %s) RETURNING *""", (posts.title, posts.content, posts.published))
    new_post = cursor.fetchone()
    conn.commit()
    return {"body": new_post}
```


## Querying by condition.

~ Notice that all the inputs need to be converted to a string before passing into the query 
```python
@app.get('/posts/{id}')
async def get_post(id: int, response: Response):
    cursor.execute("""SELECT * FROM posts WHERE id = %s """, (str(id),)) #notice the comma after str(id) is important
    post = cursor.fetchone()
    if not post:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="The given id doesn't exist!")
    return {"result": post}


```

###### This expression `(str(id))` is just a string in parentheses, not a tuple. For a tuple with a single element, you need to include a comma, like this: `(str(id),)`.

