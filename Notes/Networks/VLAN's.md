	- a logical separation of a physical network at the data link layer
	- VLANs work by taggin network frames
	- This creates isolated broadcast doamins within the same network
	- Allows devices to remain logically separate while sharing the same physical resources
## Benefits of VLAN
	1) Broadcast
		- reduces network congestion by limiting broadcast domain.
	2) Enhanced security
		- increases securtiy by separating sensitive resources
	3) Simplified administration
		- VLAN logically groups similar machines making management easier
	4) quality of service
		- PCP (priority code point) field in the VLAN tag specifies the priority of the packet, the value ranges from 0 - 7. 7 being the highest.
		- a VoIP service might have packets tagged with priority 7 as it is highly time sensitive
		- while a bulk file transfer service might have tag 0 which is of low priority
## Inter VLAN routing
	- By default machines in different VLAN can't communicate with each other. You need a router of L3 switch to enable inter-VLAN communication (happens in layer 3), this will route data packets across VLANs
### Methods of inter-VLAN routing
	1) Router on a stick
		- a single router interface is configured to handle traffic for multiple VLANs using subinterfaces
		- each subinterface is assigned an IP address corresponding to a specific VLAN
	2) Layer 3 switch
		- combines switching and routing capabilities
		- handles inter-VLAN routing internally, reducing latency comapred to external routers

### Applications of inter-VLAN routing
	- resource sharing (share printers, file servers securely)
	- traffic opmitimization (routing between VLANs allow better control over traffic flow and bandwidth allocation) 
	- scalabitily

## Limitations of using VLANs in larger networks
	1) limited number of VLANs, the VLAN tag bit is 12 bit meanining only 4096 VLANs can be used at a time.
	2) Broadcast domain overhead, each VLAN creates its own broadcast domain. In large networks with hundreds of VLANs excessive broadcast traffic can degrade network traffic.
	3) Complex configuration and management
		- increased administrative overhead
		- spanning tree protocol overhead. VLANs rely on STP to prevent loops in Layer 2 networks.
	4) security concerns
		- misconfigured trunk ports or double tagging attacks can allow malicious traffic to "hop" between VLANs
# MPLS (multiprotocol label switching)
	- Designed to improve scalability and flexibility of data transmission across wide-area networks(WANs). MPLS operates between layer 2 and layer 3 (oftern refered to as layer 2.5)
	- it uses labels instead of relying of IP address to route packets, increasing speed and efficiency
### Key concepts
	1) Labels:
		- MPLS assigns a short fixed lenght label to each packet when it enters the network
		- these labels are used by routers (label switch routers LSRs) to forward packets instead of complex IP lookups.
	2) Label Switched Path (LSP)
		- a predermined path through the MPLS network that packets follow based on their labels
		- LSP's are established using protocols like RSVP-TE or LDP (label distribution protocol)
	3) Forward Equivalence Class (FEC)
		- a group of packets that recieve the same treatment in terms of forwarding and routing
		- MPLS assings labels based on FEC, ensuring packets with same requiremnts follow the same path
	4) Edge Routers
		- Ingress router : adds labels to incoming packets
		- Outgress router : removes the labels before the packets leave the MPLS network
### Advantages of MPLS
	1) Improved perfomance
		- avoids complex IP lookups
	2) Traffic Engineering
		- MPLS enables traffic engineering, allowing network administrators to define specific paths for different type of traffic based on bandwidth, latency and other requirements
	3) Quality of Service (QoS)
		- MPLS supports QoS with priotiy based on labels
	4) Scalability
	5) Protocol Independence
		- works with layer 2 technologies like Ethernet, ATM, frame relay
		- and layer 3 protocols like IPv4 and IPv6
	6) Support for VPN's
		- MPLS is widely used for secure VPN's such as MPLS layer 3 VPNs or layer 2 VPNs

	Using Traditional IP Routing, all traffic would follow the shortest path determined by an algorithm like OSPF or BGP, regardless of bandwidth or latency requirements.
	With MPLS, administrators can define specific paths for different types of traffic:
	VoIP calls can be routed through low-latency paths.
	Bulk file transfers can be routed through high-bandwidth paths.
	This ensures better performance for critical applications while optimizing resource usage.


## Pure ALOHA
	- stations can transmit data at any time they want without looking at network conditions.
	- collision occur and data is lost. stations wait a random amount of time and retransmit again
	- Efficiency : 18 %
## Slotted ALOHA
	- to avoid collisions, time slots are created
	- machines can transmit only at the start of the time slot
	- collisions are still possible if two machines transmit at the same time.
	- efficiency : 37 %
## Carrier Sense Multiple Access (CSMA)
	- if the channel is busy it waits and if the channel is idle it transmits
	- two variants
		- CSMA/CD (collision detection)
		- CSMA/CA (collision Avoidance)
### CSMA/CD
	- if a collision happens, it is detected and stop transmitting immediately
	- waits for a random backoff period and starts transmitting again
	- usefull in wired networks, but difficult in wireless networks due to the difficulty in detecting collisions

### Polling and Token Passing
	- Polling
		- in this method, one station acts as a primary controller(master) and others are secondary stations (slaves)
		- the primary station polls each secondary station in turn to check if it has data to send. Only polled stations can transmit
		- polling eliminates collisions but introduces delay
	- Token Passing
		- Stations are arranged in ring topology.
		- A special contorl packet called token is circulated through the network
		- token passing ensures collision-free communication but introduces delay if token in lost or if demand is low


| Protocol      | Key Feature                   | Advantages                     | Disadvantages               |     |
| :------------ | :---------------------------- | :----------------------------- | :-------------------------- | --- |
| Pure ALOHA    | Transmit anytime              | Simple implementation          | High collision probability  |     |
| Slotted ALOHA | Transmit at slot boundaries   | Reduced collisions             | Requires synchronization    |     |
| CSMA          | Listen before transmitting    | Reduces unnecessary collisions | Still prone to hidden nodes |     |
| CSMA/CD       | Detect and resolve collisions | Efficient for wired networks   | Unsuitable for wireless     |     |
| Polling       | Centralized control           | Collision-free                 | Single point of failure     |     |
| Token Passing | Token-based channel access    | Fair and collision-free        | Delays if token is lost     |     |
