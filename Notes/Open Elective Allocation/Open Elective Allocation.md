

## Changing MySQL password
	login as root.
		sudo mysql -u root -p
		-> type in system password
	Then proceed to use mysql db.
	-- USE mysql;
	-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
	-- FLUSH PRIVILEGES;
### Problem
	My mysql was using auth_socket method of login for root user. So only sudo mysql will work.
	
	ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; 

		to change it.


# Running a Flask Application
	python main.py to run the flask application

## Running MySQL in WSL and connecting to MySQL workbench

	First go and change config file to bind to all addresses.

	sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

	Then go to advanced settings in windows to allow inbound port of 3306 from WSL ip.