	- Install 6 VM's
	- INSTALL [traceroute, net-tools, wireshark, frr] (remeber to run sudo apt update to refresh packages)
	- In 3 VM's you need to add an additional network card
	- we need to use IP ranges 172.16.20.64/26 
		- This is 32 - 26 = 6 bits
		- we need to create 4 subnets so log(4) = 2 bits
		
	
	A [1010 1100.0001 0000.0001 0100.01] {00} 0000 : 172.16.20.64
																	 in this first 2 bits can be further used to create 4 subnets
	B [1010 1100.0001 0000.0001 0100.01] {01} 0000 : 172.16.20.80/28 
	C [1010 1100.0001 0000.0001 0100.01] {10} 0000 : 172.16.20.96/28
	D [1010 1100.0001 0000.0001 0100.01] {11} 0000 : 172.16.20.112/28
	 - set the ip address to these (for 172.16.20.80 set it as 172.16.20.82, because 81 is gateway) with mask as 26 and 
	 - gateway as base ip + 1 (172.16.20.80 becomes 172.16.20.81)
Network Diagram
```mermaid 
flowchart LR
network1 <--> router1
router1 <--> network2
network2 <--> router2
router2 <--> network3
network3 <--> router3
router3 <--> network4
network1[/network1/]
network2[/network2/]
network3[/network3/]
network4[/network4/]

```

## My configuration
### Router 1a
	- mac_address : ...d2, ...02
	- network : intnet1, intnet2
### Router 2
	- mac_address : ...d0, ...06
	- network : intnet2, intnet3
### Router 3
	- mac_address : ...a9, ...9e
	- network : intnet3, intnet4
### NETWORKS
	- intnet1 : 172.16.20.64
	- intnet2 : 172.16.20.80
	- intnet3 : 172.16.20.96
	- intnet4 : 172.16.20.112
	- WHILE ASSIGNING NETWORKS I FOLLWED THE ORDER THAT enp0s3 then enp0s8
## How to create internal network
	- go to each indivual VM in virtualbox and set the network to internal network, 
	- with the name as intnet1, intnet2 for the first VM, first NIC gets intnet1 and second gets intnet2 etc.
	- do it for all the VM's
	- router1 : intnet1, intnet2
	- router2 : intnet2, intnet3
	- router3 : intnet3, intnet4
### Adding routes
	- at this stage you should be able to ping 172.16.20.83 from routera and vice versa (with ip 172.16.20.82)
	- this means everything is working properly

```c
'To add a route'
ip route add <network_ip>/<cidr> via <gateway_ip>
example : ip route add 10.0.3.0/24 via 10.0.3.1

'To delete a route'
ip route del <network_ip>/<cidr>
```
	- HOW SHOULD YOU SET THE ROUTE
		- Go to machine1
		- this machine is connected to network1 and network2. 
		- It has no access to network3
		- But machine2 has access to network2 and network3
		- So in theory we can access network3 via machine2
		- So now we need to add a gateway such that whenever a request comes to address of network 3 in machine 2 it need to be redirected to a network that is common to both the networks
		- Our setup will be a linear one
		- So if I ping network4 from machine1 it should go through machine2 and reach machine3
		- also note that the gateway address should be set as the address of the neighbour machine (we are using the machines as routers, so routers address should be the gateway address)
		- gateway meaning if we can't find the address in our network forward it to this address (it works by looking for the best matching prefix if multiple gateways are present)

```C
sudo sysctl -w net.ipv4.ip_forward=1
add this to all 3 VMs to enable forwarding, basically enabling to act as routers.
```
IF everything is done properly your routing table (shown with `route -n` will look as follows)
![[Pasted image 20250326151252.png]] 
![[Pasted image 20250326151348.png]]
![[Pasted image 20250326151307.png]]
# What is RIP protocol
	- Routing Information Protocol (RIP)
	- One of the oldest distance vector routing protocol used in small to medium sized networks.
	- RIP uses UDP port 520 for communication
	- operates at layer 3 of the OSI model
	- if calculates the best path for a packet by analysing the hop count of each packet. A lower hop count means it passed through less number of routers on its way. 
	- it has a maximum hop count of 15. A hop of 16 means the host is unreachable
### Setting up RIP in linux
	- install frr
	- type in 'sudo nano /etc/frr/daemons'
	- change ripd=no to ripd=yes
	- then restart the service by 'sudo systemctl restart frr'
	- no do the following for each VM
```C
sudo vtysh
 'In the following program'
 configure terminal
 router rip
 network <ip_addr_range of network 1/28>
 network <ip_addr_range of network 2/28>
 exit
 exit
 write memory
 exit
```
	- disconnect and reconnect network in settings to refresh.
If everything goes successfully this should be the routing table
![[Pasted image 20250326172838.png]]
![[Pasted image 20250326172849.png]]
![[Pasted image 20250326172858.png]]

# OSPF
	- Open Shortest Path First
	- Part of a link-state routing protocol family.
	- LINK STATE PROTOCOL
		- routers exchange information about their directly connected links (interfaces) and their states
		- each router builds a complete network topology (link-state database)
	- OSPF supports areas
		- areas logically divide many routers into a single group
		- Area 0 aka backbone area
		- all other routers must connect to area 0 through a link or directly

```mermaid
flowchart TD
Area0 <--> router1
router1 <--> Area1
Area0 <--> router2
router2 <--> Area2
Area0 <--> router3
router3 <--> Area3
```

# Setting up RIP in pfsense
# Setting up web configurator
	- install pfsense, you can mostly enter, enter... and for disk selection use spacebar then enter
	- after installation restart, (remember to remove the disk from devices in VM panel settings)
	- after boot wait
	- click on option 1 to set interfaces
	- you should have added 3 network interfaces in VM settings earlier
	- so here 
	- eth0 -> WAN
	- eth1 -> LAN
	- eth2 skip for now, we will setup later
	- press enter and continue
	- now click option 2
	- for ipv4 dhcp server say no, beacuse we need to set it up manually
	- you will be prompted for an IP address here you should give 172.16.20.65 (this will be the routers ip address, all the machines connecting to this network will send packets to this ip like a gateway)
	- next bit mask size should be 28
	- next you will have to add a dhcp server ip range
		- type in range 172.16.20.66
		- follwed by 172.16.20.79
		- remeber that we divded the network into four parts and now has 16 host machines to work with (ie 4 bits)
	- for ipv6 dhcp say yes, because we are not setting it up for now
	- for web configurator say yes
	- and done!
	- now Go to VBox and add another machine with same internal network as NIC1 of your router. Here it should be intnet1
	- immediately after logging in you should autmocatically be assigned an ip address in the range of 172.16.20.(66 - 79), just like we added in the router settings
	- now go to the addrss http://172.16.20.65
	- you should be prompted for username and password which in admin/pfsense
	- you have now completed web configurator setup.
## Enabling Internet
	 - first you need internet access
	 - go to services->DNS resolver
	 - enable DNS resolver, add tick forwarding mode
	 - incoming WAN, outgoing LAN1, LAN2, localhost
	 - goto general setup and add 2 DNS services (1.1.1.1, 8.8.8.8) and also choose the correct time zone (asia/kolkata)
	 - now your pfsense should have internet access
	 - goto general -> pacakges and search for frr
	 - install frr package
## Enabling RIP
	- goto services -> RIP global/zebra 
	- enable FRR and save
	- goto RIP and enable RIP

Here RIP routing should be enable and you should add two networks (depending on the router number this will vary)
for router 1 it should connect intnet1 and intnet4 so ip address should be ...20.64/28 and ....20.112/28. 
![[Pasted image 20250327201156.png]]
	
	- write the configurations properly and save
	- next go to interfaces tab and add two interfaces LAN1 and LAN2
	- next goto INTERFACES and click on LAN2(it might be named OPT1 rename it by editing it)
	- you need to set the ip address as follows
	
![[Pasted image 20250327201455.png]]![[Pasted image 20250327201503.png]]
	 
	 - click save and continue
	 - next you need to add a dhcp server so that every machine that connects to this networks automatically gets an IP. we have already done it for LAN1, now we need to do this for LAN2
	 - goto services -> DHCP server
	 - click on LAN2 and add the configurations
	 - click enable DHCP server add the ip address

![[Pasted image 20250327201715.png]]
	
	- Next we need to add a firewall rule to allow all packets to go in and out freely
	- Goto firewall -> rules and click on LAN2
	- tick on log packets (will be useful for demo purpose)
	- click add and select protocol to any
	- and save

	Now repeat this process for 3 more routers with the correponding ip address

| Machine | NIC1    | NIC2    | IP1          | IP2           | LAN1         | LAN2          |
| ------- | ------- | ------- | ------------ | ------------- | ------------ | ------------- |
| router1 | intnet1 | intnet4 | 172.16.20.64 | 172.16.20.112 | 172.16.20.65 | 172.16.20.113 |
| router2 | intnet2 | intnet4 | 172.16.20.80 | 172.16.20.112 | 172.16.20.81 | 172.16.20.114 |
| router3 | intnet3 | intnet4 | 172.16.20.96 | 172.16.20.112 | 172.16.20.97 | 172.16.20.115 |

	- create 3 VM's with network set to internal network.
	- VM1 -> intnet1
	- VM2 -> intnet2
	- VM3 -> intnet3
	- You should be able to ping every combination of VM's even though no two are in the same internal network 
	- You have completed routing using RIP
	- check diagnostics -> routes in pfsense to see the routing table genrated

## OSPF (open shortest path first)
	- This uses concept of areas.
	- area's are a way to group together routers
	- There is master area called backbone (ip: 0.0.0.0). Through which all the other areas are connected.
	- In our case backbone in intnet4
This will be our network diagram. While configuring OSPF we will be referring this.
![[Pasted image 20250327203940.png]]

	- first goto RIP setting and disable it
	- goto OSPF and enable it.


![[Pasted image 20250327204419.png]]

	- click save and continue
	- do this for all 3 routers
	- boom. you have done routing with OSPF.
	- try pinging pair of client VM's to see if it works.
	
# IPv6
	given ip 2001:5591:DEE6:A00::/56
	0010000000000001:0101010110010001:1101111011100110:0000101000000000:0000000000000000:0000000000000000:0000000000000000:0000000000000000
	A: 0010000000000001:0101010110010001:1101111011100110:0000101000000000:0000000000000000:0000000000000000:0000000000000000:0000000000000000
	B: 0010000000000001:0101010110010001:1101111011100110:0000101000000001:0000000000000000:0000000000000000:0000000000000000:0000000000000000
	C: 0010000000000001:0101010110010001:1101111011100110:0000101000000010:0000000000000000:0000000000000000:0000000000000000:0000000000000000
	D: 0010000000000001:0101010110010001:1101111011100110:0000101000000011:0000000000000000:0000000000000000:0000000000000000:0000000000000000
	we need to subdivide it into /64 
	so ip address's would be 
		A: 2001:5591:DEE6:A00:: /64  [1] for routers
		B: 2001:5591:DEE6:A01:: /64  [1] for routers
		C: 2001:5591:DEE6:A02:: /64  [1] for routers
		D: 2001:5591:DEE6:A03:: /64  [1,2,3] for routers

	- intnet1 : 172.16.20.64
	- intnet2 : 172.16.20.80
	- intnet3 : 172.16.20.96
	- intnet4 : 172.16.20.112

## IPv6 Setup (OSPF)
	- Goto interfaces and for each LAN1 and LAN2 enable static IPv6 and set the ip address from above (A,D), (B,D), (C,D)
	- Goto services OSPF
		- set router id to 10.0.0.1 for router1 and so on
		- set default area to 0.0.0.0
		- type in the ip ranges
		- tick the distribute connected networks
		- tick distribute default route to neighbours
	- Goto Global settings
		- set defalut router ID to 10.0.0.1
	- Goto OSPF6
		- set routerID (10.0.0.1)
		- set defalut area (0.0.0.0)
		- set the ip ranges
		- tick distribute connected networks
	- Services -> router advertisment
		- enable for both LAN1 and LAN2 
		- choose managed for both
	- ADHOC
		- disable RIP
		- make sure timezone in system -> general setup is correct
	- try connecting 3 clients to each network and ping with ipv6 addresses.
	- DONE ??
## IPv6 (RIPng)

	go to /usr/local/etc/rc.conf.d
	open the frr file inside that with
	vi frr
	add ripngd to frr_daemons
	so that it will look like 
	frr_daemons="zebra mgmtd static ripd ripngd"
	
	then restart frr to enable ripngd via
	service frr restart
	
	(this has to be done everytime unless)
	--------------------------Not verified-----------------------
	/usr/local/etc/rc.conf.d
	for some reason the config is getting wiped on reboot
	it has permissions
	-rw-r--r--
	chmod 644 /frr to make it 
	
	wait (for exactly 5 seconds)
	--------------------------------------------------------------
	
	in FRR > Global Settings > Raw Config
	click on Update Running
	then
	in RUNNING frr.conf
	add the section for IPv6 routes via ripng
	-------------------------Router 1---------------------------------
	#################### DO NOT EDIT THIS FILE! ####################
	###############################################################
	##
	# This file was created by an automatic configuration generator.
	#
	# The contents of this file will be overwritten without warning!
	#
	###############################################################
	##
	!
	frr defaults traditional
	hostname pfSense.home.arpa
	password iam
	service integrated-vtysh-config
	!
	router rip
	 redistribute connected
	 network 172.16.20.64/28
	 network 172.16.20.80/28
	!
	router ripng
	 redistribute connected
	 network 2001:5591:DEE6:A00::/64      ---   (A01, A02,)
	 network 2001:5591:DEE6:A03::/64
	!
	line vty
	!
	click on copy frr running to saved
	and then save
	
	Finally add Firewall rules for IPv6 ICMP on all the routers


### Part II IPv6 subnetting
	Router 01
		- 2001:5591:DEE6:A001::/64
		- lets divide into 
			- 2001:5591:DEE6:A001:1000::/68 intnet3
			- 2001:5591:DEE6:A001:2000::/68 intnet4
			- 2001:5591:DEE6:A001:3000::/68 intnet5
			- 2001:5591:DEE6:A001:4000::/68
		- floating ip : 2001:0EF9:BDA8::10/48
			- redirect 172.16.21.7 to floating IP.
	Router 02
		 - 2001:5591:DEE6:A0::/56
		 - lets divide into
			 - 2001:5591:DEE6:A010::/60 intent2
			 - 2001:5591:DEE6:A020::/60 intnet3
			 - 2001:5591:DEE6:A030::/60 intnet4
			 - 2001:5591:DEE6:A040::/60
	Router 03
		- 2001:585C:FEEC:595A::/64
		- lets divide into
			- 2001:585C:FEEC:595A:1000/68 intnet1
			- 2001:585C:FEEC:595A:2000/68 intnet2
			- 2001:585C:FEEC:595A:3000/68 intnet4
			- 2001:585C:FEEC:595A:4000/68

2001:585c:feec:595a:1ac8:812b:60d6:b1ab
2001:5591:dee6:a001:1ac8:812b:60d6:b1ab