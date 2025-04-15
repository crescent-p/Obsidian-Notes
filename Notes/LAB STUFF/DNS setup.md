	sudo apt install bind9 bind9utils -y

# Theory
## What are forward zones
	- maps domain names to their corresponding IP addresses.
	- converts human readable to IP address
	- Example: When a user types "www.example.com" into a browser, the DNS resolver queries the forward lookup zone to retrieve the associated IP address. For instance, "example.com" might resolve to "192.168.1.1"
	- usese A records for IPv4 and AAAA records for IPv6
## What are reverse lookup zones
	- maps ip address to domain names
	- used for network diagnostics, email server lookup, security monitoring
	- an email server might do a reverse lookup to prevent spoofing or spam
	- uses PTR (pointer records)
	- For IPv4, the zone name is based on the reversed octets of the IP address appended with .in-addr.arpa. For IPv6, it uses .ip6.arpa
	- Example: For the subnet 2001:db8:1000::/64, expand it to 2001:0db8:1000:0000::. Reverse each nibble to form 0.0.0.0.0.0.1.0.b.d.8.b.d.0.1.0.0.2 and append .ip6.arpa
	- Example: For the subnet `192.0.2.0/24`, reverse the network prefix `192.0.2` to `2.0.192` and append `.in-addr.arpa`. The reverse zone name becomes `2.0.192.in-addr.arpa`

## How to write a zone file
	1) SOA (start of authoritative) Record : defines administritative details for the zone
	2) Name Server (NS) records : lists authoritative name servers  for the domain
	3) Resource Records (RR)
		1) A records : domain to IPv4
		2) AAAA records : domain to IPv6
		3) CNAME records : defines aliases for domain records
		4) MX records : specifies mail servers for the domain
	- Increment the serial number each time you modify the file to notify secondary DNS servers of updates

- Master running on 192.168.2.2
- Slave running on 192.168.2.3

==nwlab.cse.nitc.ac.in mapped to IP address 192.168.2.19/24==

	sudo nano /etc/bind/named.conf.options

```C
acl "trusted" {
    192.168.2.0/24;  # Replace with your subnet
    localhost;
};

options {
    directory "/var/cache/bind";
    recursion no;
    
    allow-query { trusted; };
    allow-transfer { 192.168.2.2; };  # Slave server IP
    dnssec-validation auto;
    listen-on { 192.168.2.1; };  # Master server IP
};

```

	sudo nano /etc/bind/named.conf.local

```C
zone "nwlab.cse.nitc.ac.in" {
    type master;
    file "/etc/bind/zones/nwlab.forward.db";
    allow-transfer { 192.168.2.2; };  # Slave IP
};

zone "2.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/nwlab.reverse.db";
    allow-transfer { 192.168.2.2; };
};


```

**admin.nwlab.nitc.ac.in.**: The email address of the domain administrator. In DNS zone files, the `@` in email addresses is replaced with a dot (`.`). So, this represents `admin@nwlab.nitc.ac.in`

	sudo mkdir /etc/bind/zones
	# Forward Zone File
	sudo nano /etc/bind/zones/nwlab.forward.db


```C
$TTL 86400
@    IN    SOA    ns1.nwlab.cse.nitc.ac.in. admin.nwlab.nitc.ac.in. (
            2025040701 ; Serial (increment this with every update)
            3600       ; Refresh
            1800       ; Retry
            1209600    ; Expire
            86400 )    ; Minimum TTL

     IN    NS     ns1.nwlab.nitc.ac.in.
     IN    NS     ns2.nwlab.nitc.ac.in.

ns1  IN    A      192.168.2.2
ns2  IN    A      192.168.2.3
www  IN    A      192.168.2.7

```

	sudo nano /etc/bind/zones/nwlab.reverse.db

```C
$TTL 86400
@       IN      SOA     ns1.nwlab.cse.nitc.ac.in. admin.nwlab.cse.nitc.ac.in. (
                          2025040701  ; Serial
                          3600        ; Refresh
                          1800        ; Retry
                          604800      ; Expire
                          86400       ; Minimum TTL
)
                  IN      NS      ns1.nwlab.cse.nitc.ac.in.
                  IN      NS      ns2.nwlab.cse.nitc.ac.in.
1                IN      PTR     ns1.nwlab.cse.nitc.ac.in.
2                IN      PTR     ns2.nwlab.cse.nitc.ac.in.
100              IN      PTR     www.nwlab.cse.nitc.ac.in.

```


`sudo systemctl restart bind9` restart after setup



# Slave setup
	
	sudo nano /etc/bind/named.conf.options

```C
acl "trusted" {
    192.168.2.0/24;
    localhost;
};

options {
    directory "/var/cache/bind";
    recursion yes;
    allow-query { trusted; };
    dnssec-validation auto;
    listen-on { 192.168.2.2; };  # Slave server IP
};

```

	sudo nano /etc/bind/named.conf.local


```C
zone "nwlab.cse.nitc.ac.in" {
    type slave;
    file "/etc/bind/zones/nwlab.forward.db";
    masters { 192.168.2.1; };  # Master IP
};

zone "2.168.192.in-addr.arpa" {
    type slave;
    file "/etc/bind/zones/nwlab.reverse.db";
    masters { 192.168.2.1; };
};

```

	sudo mkdir /etc/bind/zones && sudo chown bind:bind /etc/bind/zones 
	

	sudo named-checkconf 
	sudo systemctl restart bind9 


```C
//flushing dns cache
sudo resolvectl flush-caches
//to view all domain entries
grep -R "zone" /etc/bind/
//to check if address resolution works
dig @192.168.2.2 dbmslab.nitc.ac.in
```

## How to add another entry ?
	add another zone
	create a new file in zones folder and voila