
`sudo ufw status` to see if firewall is enabled.
`sudo ufw allow http`
`sudo ufw allow https`
`sudo ufw allow ssh`
`sudo ufw allow 5432` # this is not required. Because your database is hosted in system itself. But pgadmin is set up in your machine so you need this.
`sudo ufw enable`
