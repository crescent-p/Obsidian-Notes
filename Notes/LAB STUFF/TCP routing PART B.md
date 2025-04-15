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
## Part 2 IPv4 Subnetting

		A: 2001:5591:DEE6:A00:: /64  [1] for routers
		B: 2001:5591:DEE6:A01:: /64  [1] for routers
		C: 2001:5591:DEE6:A02:: /64  [1] for routers
		D: 2001:5591:DEE6:A03:: /64  [1,2,3] for routers

	- intnet1 : 172.16.20.64
	- intnet2 : 172.16.20.80
	- intnet3 : 172.16.20.96
	- intnet4 : 172.16.20.112

![[WhatsApp Image 2025-04-06 at 21.53.55_8d8516b3.jpg]]

Before starting you need 3 pfsense machines, to act as routers and 3 machines to act as clients
all pfsense machines need 4 NICs (one for WAN and 3 for LANs)

you also need to attach each LAN to an appropriate intnet. (see figure for reference)
# Setting up internet connection inside VM
	- Configure DNS resolver
		- goto services -> DNS resolver
			- Network Interfaces select LAN1 LAN2 LAN3
			- Outgoing network interfaces WAN
		 - Goto System -> general setup -> 
			 - add dns servers (1.1.1.1, 8.8.8.8) in DNS server settings
			 - choose USE remote DNS from DNS resolution behaviour
			 - choose correct timezone (IMPORTANT)
		- Now you should have internet access within VM. (check System -> package manager to see if internet is coming through)
# Adding interfaces and DHCP servers
	- goto Interfaces -> assignments
	- add the three additional assignemnts and rename them to LAN1 LAN2 LAN3
	- now you need to add an associated IP address to each card
	- for example in router 01 is connected to intnet3(...20.62) intnet4(...20.80) intnet5 (...21.0) (IPv6 address is discussed at the start)
	- so goto interfaces LAN1
		- choose IPv4 Config type to static IPv4
		- choose IPv6 Config type to static IPv6
			- now scroll down and put in correct IP address and subnet
			- be sure not to reuse IP's (there are common internal networks and each NIC should get a unique IP, This is should be kept in mid while adjusting IP ranges in DHCP servers as well)
			- for IPv6 use the above mentioned IPv6 address with ending as 2 
			- example 2001:5591:DEE6:A001:1000::/64 becomes 2001:5591:DEE6:A001:1000::2/64
		- Do this for LAN2 LAN3 as well
	- Enabling Firewall
		- goto firewall -> rules
		- now for every WAN, LAN1, LAN2, LAN3
		- click on add button and choose action to pass, address family (IPv4 + IPv6) and protocol to any
		- click log packets to debug
		- click save
		- do for all the interfaces
## Setting up DHCP server
	- goto services -> DHCP server
	- for all LAN1 LAN2 LAN3 enable the server and add the valid ranges (keep some IP's for other router NIC's)
	- if ip range if from 20.1 to 20.19. assign 20.5 to 20.19 only. Otherwise collision might occur.
	- goto serives -> DHCPv6 server
	- do the same process as above
	- goto serives -> router advertisment 
	- choose router mode as managed for all three interfaces

# Setting up OSPF
	choose router ID's (given in diagram 10.0.0.1 for router1 etc)
	- goto services -> FRR Global/Zebra and click on enable FRR
	- set default router ID as 10.0.0.1 master password "pfsense"
	- save
	- goto services -> FRR OSPF
	- tick enable OSPF routing
	- router ID 10.0.0.1
	- default area (0.0.0.0)
	- type in networks to distribute


This is for router2 (figure out the intnet address connected immediately to the router and put it here)
![[Pasted image 20250408184308.png]]

	- tick redistribute connected networkds (not sure if necessarcy)
	- tick redistribute a default route to neighbours (not sure if necessarcy)
	- save
	- goto areas
		- add 0.0.0.0 area 
		- click add and type in area as 0.0.0.0
		- put cost as 1 and save
	- goto interfaces
		- click add 
		- choose interface as (LAN1, LAN2, LAN3)
		- type in area as 0.0.0.0
		- save
	- Do this for atleast 2 routers (pfsense) and check if routes are getting established in Diagnostics -> routes
	- if routes other than the one we put in above screenshot appears it is working
	- OSPF for IPv6 is same as this
	- goto services and FRR OSPF6 and repeat the same process
	- BGP won't work if you don't have OSPF setup !!

## Setting up BGP
	- goto services FRR -> BGP
	- tick enable BGP
	- rotuer ID as the IP address of the router (any NIC card) (it just needs to be unique per router)


This is the config for router2 (also add route 0.0.0.0/0 in here) why ?? (explained below)
![[Pasted image 20250408185002.png]]

	- goto neighbours and add both the neighbours (this is unlike OSPF where neighbours are auto detected)
	- we have to manually connect both parties of the neighbourhood manulaly

Again this is for router2
![[Pasted image 20250408185113.png]] 

		- for this keep everythin default except
		- name/address (this you have to keep as the name/address you setup in other machine in routerID column)
		- remote AS (autonomus system) as 650002 (depending on router ofcourse)
		- tick address family
		- defalut orginate (IPv4 + IPv6)
		- save
		- this should setup BGP in your network

#### Why keep 0.0.0.0/0 in route distribution ?
		- For the assignemnt sir told to keep the top two routers connected to internet and keep router1 disconnected
	- but clients connected to router1 should still be accessible to internet
	- for this we are advertising route 0.0.0.0/0 via router 2 and router 3
	- what this does is if none of the other routes are matcing for incoming traffic it will be directed via router2 or router3
	- then this will be automatically directed to the internet
	- for router1 you should not keep 0.0.0.0/0


## TIPS AND TRICKS
	- use status -> services to restart OSPF and BGP to sync faster
	- use status -> systemlogs -> firewall (scroll to bottom) to see if traffic is coming through/blocked by firewall
	- use diagnostics -> routes to see if OSPF is working properly
	- use Services -> FRR BGP -> status to see if BGP routes are setup properly


Diagnostics -> routes should look like this (keep in mind we only configed 3 networks, But reroutes are automatically generated)
![[Pasted image 20250408190001.png]]
![[Pasted image 20250408190015.png]]

BGP status 
IPv4 routes
![[Pasted image 20250408190106.png]]

![[Pasted image 20250408190123.png]]
OSPF routes
![[Pasted image 20250408190209.png]]