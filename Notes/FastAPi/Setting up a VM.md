`ssh crescent@20.2.137.242
`1aA@GOODFORME`
```
sudo apt update
sudo apt upgrade -y
sudo apt install python3
sudo apt install python3-pip
sudo apt install python3.12-venv
python3 -m venv venv
source venv/bin/activate
sudo apt install postgresql postgresql-contrib -y
```

Connecting to postgres

`psql -U root`

```
   sudo -i -u postgres
   psql

	#after going to psql terminal
	type in /password to set password.
	
	\password postgres;
```

Change the postgres.config file change the listen_addresses= '*'

change pg_hba.config 
update `local   all postgres    md5 (this was peer, peer authentication is anoying)`
update
```
# Database administrative login by Unix domain socket
local   all             postgres                                md5

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             0.0.0.0/0               md5
# IPv6 local connections:
host    all             all             ::/0                    md5 (means password)
```

`systemctl restart postgresql`

`psql -U postgres` to login to postgres database as postgres user.

Creating user in VM
- by default azure will create a user for you, depending on what you provide when you login.
- `git clone https://github.com/crescent-p/FastAPI.git .` to clone.

### Setting up environment variables in VM

`export <name>=value` to set a ENV_VAR
`unset <name>` to delete a ENV_VAR

put all your var->key pairs in a .env file

and run this cmd
`set -o allexport; source /home/crescent.env; set +o allexport`

But after reboot env_var are lost.

Got to your .profile in home directory and add the above cmd to the bottom. So that after bootup it is run.,

set user to postgres if you run into privileges problems.

### How to expose your API to public network?

`uvicorn --host 0.0.0.0/0 apps.main:app --port <portnum>`

by deafault its port 8000. So go to azure portal and create an inbound port rule for 8000.


### Gunicorn

`pip install gunicorn`

`gunicorn -w <numberOfWorkers> -k uvicorn.workers.UvicornWorker apps.main:app --bind 0.0.0.0:8000`

Number of workers = set to number of cpu cores you have to balance load across cpu cores.
