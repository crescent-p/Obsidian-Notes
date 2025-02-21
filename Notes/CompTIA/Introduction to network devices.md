
# OSI Model
	- 7 layers
	

	A device may operate at many levels but in formal terms it is deifined as the highest level it operates.

# Layer 1 devices

## Analog Modem
	- modulator/demodulator
	- used to take the digital signal from computer and convert it into a analog signal into the wire.
	- modem provide a single connection to a network
## Hub
	- acts as a concentrator/repeater 
	- it takes the signal coming from a single port and replicates it in all the outgoing port
	- doesn't care about destination or source.
	- not very common in modern network
# Layer 2 devices
## Switch
	- Uses ASIC chip (application specific integrated circuti)
	- ASIC chip has programming that allows it know when a devices is on the network and which port it is connected to by the device's layer 2 MAC address
	- will only communicate with local network devices.
	- may have few or many ports, may be simple or may be very complex/programmable
	- some switches have layer 3 capabilies like routing. (Network layer)
	- managed switch :- allows network configuration, monitoring, VLAN's, QoS etc.

## WAP (wireless access point)
	- only communicates with local devices
	- mostly provides wifi capabilities
# Layer 3 devices
## Multilayer Switch
	- Layer 3 switch
	- ASIC chip not only allows switching but allows routing. This allows layer 3 switches to pass data to non-local devices.
	- An MLS is complex, programmable device.
### Difference Between Switching and Routing

| Feature                   | **Switching**                                                                       | **Routing**                                                                      |
| ------------------------- | ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| **Definition**            | The process of forwarding data within a local network (LAN) based on MAC addresses. | The process of forwarding data between different networks based on IP addresses. |
| **OSI Layer**             | Layer 2 (Data Link Layer)                                                           | Layer 3 (Network Layer)                                                          |
| **Device Used**           | Switch                                                                              | Router                                                                           |
| **Identification Method** | Uses **MAC addresses** to forward frames.                                           | Uses **IP addresses** to route packets.                                          |
| **Scope**                 | Works within a LAN (Local Area Network).                                            | Works across different networks (LAN to WAN, WAN to WAN).                        |
| **Table Used**            | **MAC Address Table** (stores device MAC addresses).                                | **Routing Table** (stores network destinations and paths).                       |
| **Packet Handling**       | Switches forward frames only to the destination device within the LAN.              | Routers determine the best path for forwarding packets between networks.         |
| **Collision Domains**     | Each port of a switch has its own collision domain, improving efficiency.           | Each router interface creates a new broadcast domain, isolating traffic.         |
| **Example**               | Connecting computers, printers, and access points in an office LAN.                 | Connecting different branch offices via the internet (WAN).                      |
## Router 
	- can communicate between local and non-local devices
	- doesn't use an ASIC chip, but rather use software programming for decision making
		- it keeps information about various networks and what it considers to be the best possible route to reach those destinations.
	- connects different routers together.
	- has fewer ports than a switch.
### **Difference Between a Layer 3 (L3) Switch and a Router**

| Feature                               | **Layer 3 (L3) Switch**                                                   | **Router**                                                                               |
| ------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Function**                          | Combines switching (Layer 2) and routing (Layer 3) in one device.         | Routes traffic between different networks (LAN to WAN, WAN to WAN).                      |
| **Primary Use Case**                  | High-speed inter-VLAN routing within a LAN.                               | Connecting different networks (e.g., LAN to the internet).                               |
| **Packet Forwarding**                 | Uses **hardware-based switching** (ASICs) for fast routing.               | Uses **software-based routing**, which is slower but more feature-rich.                  |
| **Performance**                       | Faster because it processes routing at hardware speed.                    | Slower compared to L3 switches but offers more control and security.                     |
| **Interfaces**                        | Primarily **Ethernet ports** (fixed or modular).                          | Has **Ethernet ports**, but also supports **WAN interfaces** (e.g., DSL, fiber, serial). |
| **NAT (Network Address Translation)** | Typically **not supported** (L3 switches are meant for internal routing). | **Supports NAT** for translating private IPs to public IPs (used in internet access).    |
| **WAN Connectivity**                  | **Not designed for WAN**; works within a LAN.                             | **Designed for WAN** connections (connects to ISPs via DSL, fiber, etc.).                |
| **Security Features**                 | Basic ACLs (Access Control Lists).                                        | Advanced security features like **firewall, VPN, NAT, QoS, and deep packet inspection**. |
	So basically a switch connects together LAN's while a router connects these LAN's to the internet. L3 switches can't be used to connect to the internet because they lack NAT capabilities.  

	Firewall dont have routing capability but have NAT.
	L3 switches have routing capability but dont have NAT.
	Routers have both NAT and routing hence making it possible to connect to WAN.

|**Device**|**Routing Capability**|**NAT Capability**|**WAN Access**|**Explanation**|
|---|---|---|---|---|
|**Firewall**|❌ Limited or No Routing|✅ Yes|❌ Not for WAN access (unless a **Next-Generation Firewall** with routing and NAT capabilities)|Firewalls are primarily used for **security**, but most **traditional firewalls** don't handle routing. They can perform **NAT** to allow multiple internal devices to share a single public IP, but they don’t typically route traffic to different networks or the internet. **NGFWs** (Next-Generation Firewalls) may have limited routing and NAT, but are not as flexible as dedicated routers.|
|**L3 Switch**|✅ Yes (Inter-VLAN Routing)|❌ No|❌ Not for WAN access|L3 switches perform **inter-VLAN routing** (routing between different VLANs within a LAN). However, they **don’t handle NAT**, which means they can route traffic within a **local network**, but they cannot provide access to external networks like the WAN (internet) unless paired with a device like a router.|
|**Router**|✅ Yes|✅ Yes|✅ Yes|**Routers** perform both **routing** and **NAT**. They are designed to route traffic between different networks (e.g., LAN and WAN) and can **translate** private IP addresses to public ones (via NAT). This is what allows **WAN access** (internet) from a local network.|


```lua
                 +---------------------+
                 |      Internet       |
                 +---------|-----------+
                           |
                 +---------|-----------+
                 |      Router (WAN)   |
                 |  NAT, Firewall, VPN |
                 +---------|-----------+
                           |
                 +---------|-----------+
                 |  L3 Switch (LAN)    |
                 |  Inter-VLAN Routing |
      +---------+---------+-----------+---------+
      |                   |                     |
 +----+----+        +----+----+           +----+----+
 | VLAN 10 |        | VLAN 20 |           | VLAN 30 |
 |   HR    |        |   IT    |           |  Sales  |
 +---------+        +---------+           +---------+

```

	But if you are outside the network you can use 
	1) a VPN
		1) A VPN server is set up inside a router,firewall, or a dedicated VPN device inside the LAN
		2) Your computer connects to the VPN over the internet 
		3) Once connected your devices is given an internal LAN IP address
	2) port forwarding
		1) You configure the router to forward connection coming in at a particular port to a specific ip + port
		2) router_ip:select_port -> some_computer_ip_inside_network:port 

# Security Devices
## Firewall
	- Can be placed in routers or in host (software based) or be its own device
	- fucntions at multiple levels (2, 3, 4, 7) 
	- it restricts packets entering or leaving the network
		- stateless inscpection : examines each and every packet
		- stateful inscpection : only examines the state of the connection, doesnt examine individual packet
## Intrusion detection system (IDS)
	- Passive sysmte designed to identify admins about network breach. 
	- Can't prevent or stop an attack on its own.
	- Receives all the traffic and determines based on access patterns.
		- signature based
		- policy based
		- anomaly based
	- may be deployed at host level
		- HIDS (host based instrusion detection system)
## Intrusion prevention system (IPS)
	- active system
	- designed to prefom a set of actions to prevent attacks
	- also notifies admin about status
	- programmed to defend against attacks
		- block the offending IP
		- close down vulneralble interfaces
		- redirect the attack 
	- placed between the network and the router so that all the traffic flows through the IPS

## VPN Concentrator
	- allows for more secure connections to a VPN
	- concentrator provides proper tunneling and encryption.
	- usually works in layer 2, 3 and 7. data link, network and application
# Optimization and performance devices
## Load balancer
	- content switch or content balancer
	- to distribute request among servers so that servers dont get overloaded
## Proxy server
	- An appliance that reqeust data on behalf of its clients for securtiy purposes.
	- used to gather data from untrusted sources
	- increases network perfomance by caching
	- can also be used to filter content

# Networking services and applications
## VPN (Virtual Private Network)
	- used by remote hosts to access private network.
	- once connected the network sees the host as a local connection
	- even though the connection may pass through outside routers it is seen as a direct/private connection by both sides.
	- doesn't require a dedicated lease line to establish connection. Making it cheaper.
#### VPN types
	1) site to site VPN
		1) allows remote site's VPN to connect to main site's VPN
	2) remote-access VPN (host to site VPN)
	3) host to host VPN (SSL VPN) between two client machines.
##### What is a VPN concentrator
	- Establish secure VPN tunnels : encrypts and decrypts the data
	- handles multiple connections
## Protocols used by VPN
### IPsec
	- Works at layer 3 of the internet protocol
	- most common to secure a VPN connection
	- can be used with Authentication Header (AH) protocol which doesn't provide encryption though!
	- can be used with Encapsulation Security Payload (ESP) which both authenticates and encrypt the data making it the most common.
	- AH and ESP can be used in two modes
		- transport mode
			- tunnel mode
### Generic Routing Encapsulation (GRE)
	- It is used to create a sub-tunnel within an IPsec connection.
	- IPsec transmits only one to one connections. But sometimes you need multicast or broadcast services. GRE is used for this.
### Point to Point tunneling protocol (PPTP)
	- Older VPN tech that supports dial up VPN connections.
	- on it own it lacked security, but microsoft's implementation added GRE 
### Transport Layer Security (TLS)
	- works at layer 5 and above of the OSI 
	- encyrpts communication between two end devices
	- replacement for SSL
### Secure Socket Layer (SSL)
	- SSL V.3 is address the weakness of the earlier SSL standard
	- Used in internet transcations
	- similar to TLS
## Network Interface Controller (NIC)
	- Also called netwrok interface card
	- NIC is through which a computer connects to a network
	- works at data link layer and physical layer (layer 2 and 1)
		- at layer 2 decides which network protocol should be used. Also provides the local network node address through its burned in MAC address
		- at layer 1 convets the bits of incoming data into electrical signals.
## RADIUS (Remote Authentication Dial In User Service)
	- Used to authenticate remote users and provide them remote resources
	- it is a popoular AAA (authentication authorization accounting) protocol.
	- only the requesters password is encrypted.
# Other services and applications
## RAS (Remote Access Services)
	- a description of the hardware and software required for remote access.
## Web services
	- provides mean for communication between applications packages or disparate platforms
	- usually achieved by translating the communication into XML (extensible markup language)
## Unified voice services
	- voice over internet
	- set of description to achive this (both software and hardware)

# DHCP in the network
## Static vs IP Address
	- a computer recieves its ip config from a DHCP server
	- DHCP also probably told the compute what the default gateway is and also the DNS server.
	- There are two ways to get an IP for a computer 
		- static (manually set)
		- dynamic (provided by DHCP server)
### Static IP addressing 
	- administrator assigns and IP address and a subnet mask to each host in the network
	- also allocates a default gateway and a DNS location to each host 
### Dynamic IP adderssing
	- configured by the adiministrator
	- listens on a specific port for IP infromation requests
	- once a request is recieved it responds with a message
## How DHCP works
	- Upon boot up a PC sends out a DHCP discovery packet.
	- discovery packet is send on the broadcast ip (255.255.255.255:67 port 67)
	- DHCP server recieves this packet and sends and offer packet
		- the offer packet is send using the PC's MAC addrress on port 68
	- The PC accepts the offer packet and sends out a request packet for IP config
	- The DHCP server receives the packet and sends out an acknoledgement packet that contains the IP info.

![[Pasted image 20250131170942.png]]

## Component and process of DHCP
	1) ports used 
		1) port 67 to receive incoming broadcast messages
		2) port 68 to send messages
	2) address scope
		1) a range of IP address that can be send out by the DHCP server
		2) to be set by the administrator
	3) Address reservation
		1) some address are statically allocated to some users  (eg: servers, routers)
		2) you need to do this otherwise ip's like default gateway might change.
	4) Leases
		1) configuration parameters are good for only a limited amout of time, that is the lease time.
		2) configured by admin
	5) options
		1) change default gateway location
		2) DNS server address
		3) time server address
	6) preferred IP address
		1) the DHCP server can honor the request from the host machine or to ignore it.

	Under optimal circumstances the DHCP server need not be on the local network. A router could see a discovery packet and route it to a network that has a DHCP server. This significantly reduces admin's job of configuring DHCP server and also aids in easier maintenanace.

# DNS Services

![[Pasted image 20250131210835.png]]
## DNS servers
	- DNS is the process that transalates readable name to their corresponding ip address. 
	- If the local DNS server doesn't contain a required domain -> ip map, then it asks up the DNS hierarchy until a positive match is found.
	- DNS requires an FQDN (fully qualified domain name) to work properly. 

![[Pasted image 20250131211124.png]]
	
	-  Even before sending a DNS request your browser checks the cache to see if its already resolved.
		- If a cache is not found in the browser, it checks the OS DNS cache.


#### **How a URL like `www.nitc.ac.in` is Resolved by a DNS Service (Step-by-Step)**

When you enter `www.nitc.ac.in` in your browser, the **Domain Name System (DNS)** translates it into an **IP address** so your device can communicate with the correct server. The resolution process follows these steps:

---

##### **Step 1: Browser Cache Check**

Before making a DNS query, your browser checks its **cache** for a previously resolved IP address of `www.nitc.ac.in`.

- If found, it uses that IP address immediately.
- If not found, it proceeds to the next step.

---

##### **Step 2: Operating System Cache Check**

If the browser doesn’t have the record, the **Operating System (OS)** checks its DNS cache.

- On Windows, this cache can be viewed using:
    
    ```sh
    ipconfig /displaydns
    ```
    
- If found, the OS provides the IP address to the browser.
- If not found, it queries a **DNS Resolver**.

---

##### **Step 3: Query Sent to Local DNS Resolver (ISP DNS)**

If the IP is not cached, the request is sent to a **DNS Resolver**, typically provided by your **Internet Service Provider (ISP)**.

- Example: Google’s **public resolver** at `8.8.8.8` can also be used.
- If the resolver has the IP cached, it returns it; otherwise, it starts a recursive DNS lookup.

---

##### **Step 4: Root DNS Server Lookup**

If the resolver doesn’t have the IP cached, it **asks a Root DNS Server**.

- The root servers know where to find the **Top-Level Domain (TLD) servers** (like `.com`, `.in`, `.org`).
- There are **13 sets of root servers** globally, operated by organizations like ICANN, Verisign, and others.

For `www.nitc.ac.in`, the resolver asks a **Root DNS Server**, which directs it to the **“.in” TLD server**.

---

##### **Step 5: Top-Level Domain (TLD) Server Lookup**

The **“.in” TLD server** does not know the exact IP but knows the **Authoritative Name Server** for `nitc.ac.in`.

It responds with the **Authoritative Name Server’s IP**.

---

##### **Step 6: Authoritative DNS Server Lookup**

The resolver then queries the **Authoritative Name Server** for `nitc.ac.in`, which stores the actual **DNS records** (A record, CNAME, MX, etc.).

- The **A record** (Address Record) holds the IP address mapping for `www.nitc.ac.in`.
- This server responds with the IP address, e.g., `103.21.127.42`.

---

##### **Step 7: Response Sent to User’s Device**

The resolver caches this IP (to speed up future lookups) and returns it to the user’s browser.

---

##### **Step 8: Browser Connects to the IP**

Now, the browser establishes a **TCP connection** (via **HTTPS or HTTP**) to `103.21.127.42` and **sends an HTTP request**.

- If **HTTPS** is used, an **SSL/TLS handshake** happens.
- The web server at `103.21.127.42` responds with the webpage.

### Levels of DNS Servers
#### Local DNS Server
	Answers query in the local network.
#### Top  Level Domain (TLD) Server
	- contains mapping of top level domains
	- example : com, org, net, edu, gov, mil, int
#### Authoritative Server
	- An authoritative server is one that has been specifically configured to return that mapping. 
	- An authoritative response is send by a server that contains original information. Meaning it was not passed down by some other DNS server. 
	- Holds original record
#### Non-Authoritative Server
	- Responds with DNS information that it received from some other DNS server 
	- Second hand or third hand response
#### Root Server
	- the server that contains the data for the TLD server.
**A default gateway is the location you sent data if you want to access the internet**
## DNS Records
	1) A record
		- maps hostnames to IPv4 address
	2) AAAA record
		- maps hostnames to IPv6 address
	3) CNAME record
		- maps canonical(alias) name to hostname
	4) PTR Record
		- pointer record that point to a cononical name
	5) MX Record
		- maps to the email server that is specified for a specific domain. It is the record that determines how a email travels from sender to recepient.


## Dynamic DNS
	- permits quick updates to DNS server
	- this is useful when the FQDN (fully qualified domain name) changes on a daily basis.
	- added as an addition to normal DNS
## DDNS updating
	- a method of updating name servers without manual intervention
	- A DDNS provides a software that monitors the IP address and sends out a message when the ip changes to the DNS server.
# Sending an Email

## **Step 1: Composing and Sending the Email**

- The sender writes an email using an email client (e.g., **Gmail, Outlook, Thunderbird**).
- When they hit **send**, the email is formatted using **SMTP (Simple Mail Transfer Protocol)**.
- The email contains:
    - **From:** Sender's email address.
    - **To:** Recipient's email address.
    - **Subject:** Email subject.
    - **Body:** The message content.
    - **Attachments (optional):** Any files sent with the email.

---

## **Step 2: Sending Email to the Outgoing Mail Server (SMTP Server)**

- The email client connects to the sender’s **SMTP server** (e.g., `smtp.gmail.com`).
- The SMTP server **authenticates the sender** using their credentials.
- The email is **queued for delivery**.

---

## **Step 3: DNS Lookup for the Recipient’s Mail Server**

- The SMTP server needs to find out **where to send the email**.
- It performs a **DNS lookup** to find the **MX (Mail Exchange) records** for the recipient’s domain.
    - Example: If sending to `john@example.com`, the SMTP server queries the DNS for `example.com`'s **MX records**.
    - The MX record might point to `mail.example.com`.

---

## **Step 4: Email is Sent to the Recipient’s Mail Server**

- The sender’s **SMTP server** establishes a connection with the recipient’s **mail server** using **SMTP (port 25 or 587)**.
- It transfers the email to the recipient’s **Mail Transfer Agent (MTA)** (e.g., Gmail’s or Outlook’s mail servers).
- The receiving mail server **stores** the email in the recipient’s mailbox.

---

## **Step 5: Storing the Email in the Recipient’s Inbox**

- The recipient’s mail server places the email into their inbox.
- It uses **POP3 (Post Office Protocol 3) or IMAP (Internet Message Access Protocol)** for mailbox management:
    - **IMAP (Internet Message Access Protocol) – Modern Method**
        - Email stays on the **server** (used by Gmail, Outlook, etc.).
        - The recipient can access it from multiple devices.
    - **POP3 (Post Office Protocol) – Older Method**
        - Email is **downloaded** to the recipient’s device and usually deleted from the server.

---

## **Step 6: Recipient Reads the Email**

- The recipient logs into their email client (e.g., Gmail, Outlook).
- The email client **fetches emails** from the mail server using **IMAP or POP3**.
- The email appears in their inbox, ready to be read.

---

### **What Happens If the Email Can't Be Delivered?**

- If the recipient’s mail server is **down**, the sending server **retries** for a certain period.
- If delivery **fails permanently**, the sender gets a **bounce-back email** with an error message like:
    - `550 No such user` (Invalid email address).
    - `554 Message rejected due to spam filter`.

# NAT (Network Address Translation)
	- Solves the problem of how to route non-routable IP addresses
	- As part of conserving IP address, private IP addresses where introduced.
	- These IP addresss can't be accessed outside the network and are reserved for private use.
	- A router with NAT enabled will translate a private IP address to a routable public IP address. 
	- when a response is recieved by the router it is forwareded to the correct host machine.
## Static NAT (SNAT) 
	- A private IP is translated to the same public IP. 
	- if you have 10 private IP's then you need 10 public IP's
	- used for servers that needs to be publicily accessible
	- A public IP is assigned to a private IP
	- not very scalable
## Dynamic NAT (DNAT)
	- private IP is transalted to a public IP selected from a pool of public IP's
	- scalable
## PAT ( Port address translation)
	- a type of DNAT
	- a single IP is used for multiple private IP's
	- different ports are used for distinguishing private IP's
	- in cisco terms called as PAT with NAT
	- still requires a pool of public IP's, but way fewer is required

### NAT Terminology
	1) Inside Local address
		- the private IP of a host machine
	2) Inside Global address
		- a public IP address referencing an inside device.
		- the public IP assigned to an inside machine by the NAT
	3) Outside Global address
		- public IP of a machine outside the network
	4) Outside Local address
		- the private ip address assigned to an outside device on the interior of the local network

# WAN 
## Public Switched Telephone Network (PSTN)
	- If you own the network you are using, then you are on LAN
	- If you lease or rent out the network then it is the WAN
	
💡 **PSTN uses circuit switching, meaning a dedicated path is established for the entire call duration.**
	You can think of it as a temporary leased line with actual dedicated circuit between caller and calee.
### Dial up
	- Utilizes PSTN to transmit network traffic as an analog signal
	- requires an anlog modem to format the traffic
	- max speed is 56kb/s
### ISDN (Integrated Services Digital Network)
	- Digital point to point WAN tech using PSTN
	- Compleletely digital
	- requires a Terminal Adapter (TA)
	- Achieves 1.5Mbps
	
==*DSL (Digital Subscriber Line)** is a technology that provides **high-speed internet access** using **telephone lines**. It allows data transmission over traditional copper telephone wires **without interfering with voice calls*==
### xDSL
	- digital WAN tech using PSTN
	- requires use of a digital modem
	- carries voice and data (filters are used for voice)
### SDSL
	- symmetric
	- same upload/download speed
	- used by businesses that don't require a T1 lease line, but need symmetrical upload-download speed
### ADSL
	- asymmetric
	- upload is slower than download
	- only possible within 4000 feet within a PO

## Broadband Cable
	- coaxial cable networking
	- it can deliver voice, data and television through the same cable.
	- Headend: all cable signals are recieved at this point. Then it is formatted and send to the distribution network
	- Distribution network : smaller service areas served by the cable company. Can be composed of optical/coaxial or mixture of both
	- Final distribution to the premise is through a coaxial cable.
	- DOCSIS standart is needed for data over cable (data over cable service interface specifications)
## Fiber
	- more expensive to install, but less susceptible to line noise.
	- SONET (synchronous optical network).
	- DWDM (dense wavelength division multiplexing) uses a single fibre cable with upto 32 channels, increasing bandwidth.
	- CWDM (coarse wavelength division multiplexing) for upto 8 channels per fibre cable.
	- PON (passive optical network) is a point to multipoint technology that uses a single optical fibre to connect multiple locations on the internet. Uses an unpowered optical splitter.

|**Feature**|**Single-Mode Fiber (SMF)**|**Multi-Mode Fiber (MMF)**|
|---|---|---|
|**Core Size**|Small (~9 μm)|Large (~50–62.5 μm)|
|**Distance**|100+ km|< 2 km|
|**Speed**|**Up to 100+ Tbps**|**Up to 100 Gbps**|
|**Use Case**|Internet backbone, long-distance links|Data centers, LANs|

💡 **Single-mode fiber (SMF) is used in undersea cables, ISP networks, and high-speed internet backbones.**
## GSM/CDMA WAN 
	- all cellular carrier use one of the two methods for connecting mobile devices to the internet
	- GSM (Global Systme for Mobile)
	- CDMA (code division multiple access)
	- the two are not compatible, most of the world use GSM
## Cellular networking
	- 1G was only available for voice 
	- 2G offered messaging on top
	- 3G offered data, beginning of WAN
	- 4G offers LTE and WiMAX
	- LTE (long term evolution), uses and all-IP based core with high data rates.

## WiMAX WAN connections
	- Worldwide Interopability for microwave access networking.
	- uses microwaves. Requires a line of sight to propagate data.
	- can cover a lot of area
	- a type of 4G technology, compatible with LTE
## Satellite WAN connections
	- Uses microwave signalt for over the air communications
	- used for hard to reach locations.
	- very high latency is expected.
	- A communication satellite (comsat) forms part of the relay network.
## Metro Ethernet WAN
	- A metro Ethernet connection is when the service provider connects to the customer's site through an RJ45 connector.
	- The provider may use many WAN technologies behind the scene but the customer will see it as an ethernet connection.
## Leased Line WAN 
	- dedicated circuit (connection) between two endpoints
	- very expensive
	- multiplexing tech can be used to improve number of channels on the line.
#### Point to Point 
	- a type of leased line network
	- Layer 2 protocol, data link layer
	- PPP includes multiple PPP which allow multiple physical connections to act as a single logical interface increasing bandwidth
### Types of leased lines
	1) T-Carrier
		1) 1.5 Mbps
		2) T3 composed of 28 T1 lines. effectiviely multiplying bandwidth
	2) E-Carrier (E1, E3)
	3) Optical Carrier (OC)
		1) can go from 50Mbps to 10Gbps (OC1 to OC 192)


## Circuit switched vs Packet Switched networks
	- Circuit swtiched networks have a dedicated circuit from source to destination
	- while active only these two parties can send data through this line.
	- circuit switched is common in leased line connections
	- useful when there is fair amount of data traffic between two endpoints

	- packet swithing is cheaper and used in modern networks
	- the data is cut up into chunks and send separately.
	- data packets might take differnt routes and differnt times to reach location
	- final data is obtained by combining the packets.
	- There is no need for dedicated lines

## Frame relay vs Asynchronous relay transfer mode
	#FRAME RELAY
	- WAN technology in which variable length packets are switched across a network
	- less expensive than leased line
	- can be made to look like a lease line through virtual circuit (VC) tracked with (DLCI data link connection identifier)
	- CIR (commited information rate) : customer recieves atleast this, but may go higher

	#ATM 
	- Fixed length packets are switched
	- handles real time video and audio
	- speeds is mostly 54Mbps / 155.52 Mbps

## MPLS Multiprotocol label Switching
	- it is scalable and protocol independent
	- can be used to repalce frame switching and ATM relay switching
	- Used to improve QoS and flow of network traffic
	- Label edge router : scan packets without MPLS label and labels them
	- Label switching router : routes packets based on MPL label
	
![[Pasted image 20250201153503.png]]

# Network Cabling 
## Twisted pair network cabling
	- used in standard LAN
	- composed of four PAIRS of wires. 
	- twisted together to reduce Electomagnetic interference
	- brown - orange - blue - green and their white twisted wire
### Shielded vs Unshielded
![[Pasted image 20250201154629.png]]

	 sheilding Reduces crosstalk
### Plenum vs Non plenum
	- most twisted pair wires are non-plenum grade
	- coverd in a fire resistant cover or low smoke PVC
	- often has a nylon cover woven on top to take weight off the hanging wire
## Twisted pair network cable
	- either a straight through cable (to connect different type of devices; PC to a switch) or a crossover cable (between same kind of device), but it can be used to create a rollover(console) cable.
## Twisted pair network connectors
	#RJ11
	- uses a 6 position 4 contact (6P4C) modular connector
	- can carry data or voice, common use is voice, telephony
	#RJ45
	- uses a 8 position 8 contact (8P8C) modular connector
	- can carry data, voice; common use is data
	#RJ48C
	- uses a 8P8C connector
	- used as terminating connector at the demarc for T1 lines
	- often confused with RJ45, but the active points are different
	#UTP coupler
	- to connect utp cable together
	#66 block
	- used to terminate and distribute telephone lines in an enterprise environment.
	#DB9 (RS22)
	#DB25 (EIA-232/RS-232 serial)

**all twisted pair cables have a range of 100m**

	#CAT 3
	- rated for upto 10Mbps speed. max distance 100m
	#CAT 6
	- 55 m for 10Gbps
	#CAT 6a
	- 100m for 10Gbps

## Coaxial Cabling
	- oldest cabling standard
	- been used for broadband(multiple digital signal), baseband(single digital signal)
	- eg: RG58, RG59, RG6
## Fiber Optic Cabling
	- very hard to work with and install
	- can cover long distance
	- could be run in pairs (a recieve one and a send one)
	- 2 types
		- UPC (ultra physical contact)
		- APC (Angled physical contact)
	- mutlimode fiber
		- uses and infrared LED system to send light 
		- less expensive than singlemode fibre
		- multiple rays of light used
		- can conver <2km
	- single mode fiber
		- uses a single ray of light
		- uses laser diode arrangment to send data
		- can cover 40+km
### Fiber connectors
	- SC 
		- standard connector (stick and click)
		- push pull type connector
		
![[Pasted image 20250201213520.png]]

	- ST
		- stick and twist
		
![[Pasted image 20250201213547.png]]

	- LC 
		- local connector, loosened connector 

![[Pasted image 20250201213602.png]]


	- MTRJ 
		- mechanical transfer registered jack
		- uses a locking tab to secure the connection

![[Pasted image 20250201213749.png]]

### Media converters
	- A network might contain differnt types of cables.
	- media converts do just that
	- fibre to coaxial, SMF to ethernet, MMF to ETherenet (single/multi mode fibre)
### Cabling tools
	#Crimpers
	- used to place cable ends on cables

![[Pasted image 20250201215939.png]]
	
	#Wire strippers
	- used to remove insulating cover on wires
	- most are designed to cut without damaging the inner part of the wire

![[Pasted image 20250201220151.png]]

	#The puchdown tool
	- used to secure cable wires into punchdown blocks.
	# Cable testers
	- misconfiguration of the pinouts
	- shorts or breaks in the cable

![[Pasted image 20250201220324.png]]

	#TDR (time-domain reflectometer)
	- can determine the length of the wire and electrical properties

![[Pasted image 20250201220419.png]]

	#OTDR (optical time-domain reflectometer)
	- used for fiber optical
	- same as TDR


# Network Topologies
## What is ?
	- A map used to describe how a network is layed down.
	- could be logical or physical. 
	- logical speaks about theoretical signal path while physical talks about the actual wires layed down.
## Peer to Peer
	- not really topologies, they dont describe the signal path or wire layout, but descibes the fucntions of the network.
	- no single computer determines what is accesible or not, each server decides what it wants to share
## Client/Server 
	- resources controlled by a central server
## Bus 
	- first topology
	- so to maintain backwards compatibility all the subsequent topologies were based on bus and the logical topology is alwysa bus, the physical topology might change.
	- the signal traverses from one end of the line to other end.
	- the end must be terminated to prevent bounce
	- network cable is the central point
	- data is sent to all the recepients
	- data collision if multiple users send at same time
	- a single cable brings down whole network
## Ring
	- a bus line with endpoints connected together (circle)
	- a break in the line breaks the ring
	- avoids collison with token-passing method
## Star
	- all devices connected to a central switch or hub
	- avoids collition with switching
	- requires more cables
	- hub failure brings down whole network
## Mesh
	- complete graphs
	- each device connected to all the other devices
	- super expensive
## Tree Topology
	- hierarcy using multiple switches, hubs
	- no single point of failure, except main hub :(

## point to point
	- two PC's connected together with a crossover cable.
## point to multipoint
	- a central device to which all the devices are connected
	- central device is intelligent
	- only forwards to intended recepient
	- wireless networks often employ this
	- common topology when implementing WAN
	- when a device sends it messages is only passed along the destination

# Network infrastructure implementation
## Design vs Functions
	#DESIGN
	- topology
	#FUNCTION
		- category or infrastructure implementation
		- LAN
			- encomapassed by a single adderss space
			- a single room to a group of building
			- fastest speeds
			- ETHERNET (802.3) and WLAN(wireless LAN) (802.11)
		- MAN
			- metropolitian area network
		- WAN
			- spans significant geographic area, aka an internet
			- if its private and large its a WAN or CAN(campus area network)
			- if its large and not owned by a signle organization its a WAN
		- PAN
			- personal area network
			- between two devices
			- bluetooth, IR from smartphone and a printer
			- NFC (near field communication)
		- SCADA (supervisory control and data acquisations)
			- to control distributed equipments remotelly from a single central location
		- Medianet
			- to improve voice and video in a network
			- increases QoS
			- a VTC (video teleconference) is an example
# IPv4
## Purpose
	- to send information from network A to network B
	- if IPv4 or IPv6 address is known this can be done
	- IP address is logical means it can be changed multiple times, unlike MAC address
## Properties
	- 32 bit binary number
	- pow(2, 32) addresses, a proces needs to there to find all the address, aka subnet mask
	- divided into 4 parts with 8 bits each
	- it is also divided into network part and node part, this is called the subnet mask
	- subnet mask has the same format as IPv4

## Subnet mask
	let the ip be 192.168.1.9 255.255.255.0
	IP = 192.168.1.9
	subnet = 255.255.255.0
	anything other than 1 (ie 0) in subnet mask means it is part of the node. and the 1 part means it is the network part.

192.168.1.9  
255.255.255.0
 11000000.10101000.00000001.00001001
							-
 11111111.11111111.11111111.00000000
							=	
					00001001
	only take the zero part of subnet as the node

	255.255.255.0 is \24 means the first 24 bits are for network and the rest 8 are for host.
	If a device wants to send some information and the first 24 bits are same, then it can be send without reaching the internet.
	if we want to divide the network again into 2 parts we can add one more bit to network part and take one from host bit
	making it \25.
	so the network range would be 
	192.168.1.1 - 192.168.1.126
	(192.168.1.0 is networkID and 192.168.1.127 is broadcast address)
	192.168.1.129 - 192.168.1.254
	(192.168.1.128 is networkID and 192.168.1.255 is broadcast address)

## Classes of IPv4
	- CLASS A
		- address range 0.0.0.0 to 127.255.255.255
		- subnet mask 255.0.0.0
	- CLASS B
		- subnet mask 255.255.0.0
		- address range 128.0.0.0 to 191.255.255.255

	- APIPA (automatic private IP addressing)
		- when the DHCP server fails the host will self configure APIPA 
		- address range 168.254

### **1️⃣ Classes of IP Addresses**

| Class | First Octet Range | Default Subnet Mask | Network Bits | Host Bits | Max Networks    | Max Hosts per Network |
| ----- | ----------------- | ------------------- | ------------ | --------- | --------------- | --------------------- |
| **A** | 1 - 126           | 255.0.0.0           | 8            | 24        | 128 (2⁷)        | 16,777,214 (2²⁴ - 2)  |
| **B** | 128 - 191         | 255.255.0.0         | 16           | 16        | 16,384 (2¹⁴)    | 65,534 (2¹⁶ - 2)      |
| **C** | 192 - 223         | 255.255.255.0       | 24           | 8         | 2,097,152 (2²¹) | 254 (2⁸ - 2)          |
| **D** | 224 - 239         | **Multicast**       | N/A          | N/A       | N/A             | N/A                   |
| **E** | 240 - 255         | **Reserved**        | N/A          | N/A       | N/A             | N/A                   |

- **Class D**: Used for **multicasting** (not for host assignment).
- **Class E**: **Reserved** for experimental use.

> **Note:** The **127.x.x.x** range is reserved for **loopback addresses**.

	- PRIVATE IP
		- class A (10.0.0.0 to 10.255.255.255)
		- class B (172.16.0.0 to 172.31.255.255)
		- class C (192.168.0.0 to 192.168.255.255)

### Classless Addressing
	- CIDR (classless interdomain routing)
	- to create more flexibility
		- subnet mask becomes fluid
### CIDR notation
		192.168.0.9 255.255.255.0 becomes 192.168.0.9/24
	basically similar to subnetting. give number of bits in network address after /
