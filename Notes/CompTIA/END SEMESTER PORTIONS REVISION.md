Kurose
https://www.ucg.ac.me/skladiste/blog_44233/objava_64433/fajlovi/Computer%20Networking%20_%20A%20Top%20Down%20Approach,%207th,%20converted.pdf
1.1 - 1.4
2.1, 2.2, 2.4, 2.5
Chapter 3
4.1 - 4.3;dhcp
5.1 - 5.4, 5.6;dhcp
6.1 - 6.3.3, 6.4, 6.5
7.1, 7.2(just skip CDMA) - 7.3.5

# Delays In Networks
## Network Edge : hosts, access networks, physical media
	Nework edges :
		 hosts : clients and servers
		 servers often in data centers

![[Pasted image 20250410132153.png]]

	Host : sends packets of data 
		funcion:
			1) take application layer message 
			2) break into smaller chunks known as packets and send it in length of L bits.
			3) transmists packet into access network at transmission rate R
			4) link transmission rate aka link capacity aka link bandwidth
only the time delay of transmitting first packet is calculated
![[Pasted image 20250410132416.png]]

### Access networks and Physical Media
	how to connect end systems to edge routers ?
	- Wired Connections
		- Etherenet 
		- modem to router
	- Wireless
		- Wifi
		- Wireless range extenders
	- IN modern systems firewall, NAT, router, wifi acces point and cable or DSL modem are combined into a single box

what are end systems?
	In computer networks end systems are the systems that either send or receive data. Either the source or the destination of information.
	eg: phones, laptops, gaming consoles, web servers etc.
### Wireless Access Networks
	Shared wireless access networks connect end system to routers
	1) wireless local area networks
		range of around 100ft
		802.11b/g/n (b, g, n are newer versions inorder, n supports dual band 2.4GHz and 5GHz)
	2) Wide-area cellular access networks
		range of aroudn 10km
		4G/5G cellualar networks

##### What is half duplex ?
	It is a mode of communication where the data flow is bidirectional, but only a single party can communicate at the same time. 
	
#### Links : physical media
	- bit: propagates betwen transmitter/reciever pair
	- physical link: the conneciton between transmistter and reciever
	- guided media : signals that propagate in solid media (copper wire, fiber, coax (aka coaxial cable))
	- unguided media : radio, wifi
	- twisted pair (TP) : two insulated copper wires CAT5(1Gbps) CAT6(10Gbps) 
	- coaxial cable : two concentric copper conductors 
		- multiple frequency channels on cable 
		- each channel supports 100mbps
	- fibre optic cable : glass fibres each caryying a light pulse, each pulse a bit
		- high speed operation
		- very low error rate (repeaters spaced apart for this reason)
		- immune to electormagnetic noise
	- wireless radio
		- signal carried in electormagnetic spectrum
		- propagation environment effects : 
			- reflection
			- interference 
			- obstrucion by objects
		- no physical wire
		- RADIO LINK TYPES
			- wireless LAN  (wifi)
				- upto 100Mbps
			- wide area (eg: cellular)
			- satellite
				- upto 45Mbps per channel
			- SPEED 
				- wifi > cellular > satellite

## Internet Structure
	- a network of networks
	- hosts connect to internet via access ISP's (internet service providers)
	- ISP in turn must be inter-connected to each other
	- HOW TO INTER-CONNCET ISP's?
		- Complete graph? (O(n^2) complexity)
		- center ISP where every ISP is connected ?
			- but if one ISP is viable business there will be competitions.
	- an internet exchange point is an infrastructure that lets ISPs, CDNs, cloud providers exchange internet traffic.
	- How does IXPs work ?
		- Technical setup : IXP's use switches to directly connectect participating routers to each other. These switches enable directing exchange between routers using protocols like border gateway protocol (BGP)
		- Traffic exchange : Networks exchange information and decide which trafiic should flow directly between them

![[Pasted image 20250410145628.png]]

	A Network of networks
		- A few large well connceted ISPs (Tier 1 ISP commercial ISP) national and international converage
		- content provider networks (a few private network that connects its data centers to internet, bypassing tier 1 and regional ISP's)
	
![[Pasted image 20250410150246.png]]

## Network core : packet/circuit switching
	- mesh of interconnected routers
	- packet-switching : hosts brak application layer messages into packets
	- forwards packet from one router to the next across links on path from source to destination
	- each packet transmisted at full link capacity
- Transmission delay : takes L/R time to push out a L bit packet into link at R bps
- Store and forward : the router waits for the entire packet to arrive before forwarding it
- End-end delay : 2L/R (assuming zero propagation delay)
### Queueing delay, loss
	- if arrival rate to link exceeds transmission rate of link for a period of time packets will queue up to be send
	- the router may drop packets if the memroy buffer fills up
	- factors 
		- rate at which traffic arrives at the queue
		- transmission rate of the link
		- if packtes arrive in bursts or continous stream
	- R: link bandwidth
	- L: packet length in bits
	- a: average number of packets arriving per second
	- traffic intensity = La/R
	- La/R ~ 0 (no delay)
	- La/R <= 1 (delay depends on type on incoming traffic)
	- La/R = 1 (large queuing delay)
	- La/R > 1 (infinite queueing delay)
	- GOLDEN RULE : desing yours system so that the average queuing delay is not so greater than 1

### How does traceroute program work?
	- sends out i packets of data where i is the number of routers
	- in each packet the ttl is set to i.
	- so that after it pass throught the ith router it is returned immediately
	- the program then measures the time taken for the whole journey

![[Pasted image 20250410151226.png]]

### Performance : loss, delay, throughput
	- packet delay (four sources)

![[Pasted image 20250410151610.png]]
	- processing delay (checking error bits, finding output link, usually < ms)
	- queueing delay (time waiting at output link for transmission, depends on router congestion)
	- transmission delay, propagation delay
	- propagation delay is the time taken for a signal to reach one router from another
		- dprop = length of medium / speed of signal (~2x10^8 m/sec)

### Bandwidth vs Throughput
	- Network Bandwidth : refers to the *maximum amount* of data that can be trasmitted over a network in a given amount of time.
	- Throughput (effective data rate) : refers to the actual amount of data that can be transmitted in realistic scenario (yours wifi bandwidth might be 866Mbps but the throughput might be 300Mbps due to device limitations)
	- instantatneous throughput : rate of data flow at current time
	- average throughput : rate over long period of time
#### Bottleneck

![[Pasted image 20250410153626.png]]

	- 10 devices are connected via a backbone.
	- per connection avg throughput = min(Rs, Rc, R/10)
	- the constrained factor for throughput in today's network is usuall the access network
		- throughput depends not only on1 the transmission rates of the link along the path, but also on the intervening traffic.

## Layered Internet Protocol Stack
	1) application
	2) presentaion (allow application to interpret meaning of data. eg: encryption, compression, machine specific conventions)
	3) session (synchornization, recovery of data)
	4) transport (TCP,UDP)
	5) network (IPv4, IPv6)
	6) link (ethernet, 802.11)
	7) physical

==All People Seems To Need Data/Link Processing==  APSTNDP
		
		- transport layer encapsultaes applicatin message with transport headers to create a transport layer segment
			- Ht used by transport layer protocol to implemnet its services
		- network layer encapsulates tranpsort layer segement with Hn to create network-layer datagram
			- Hn used by network layer protocol to implement its services
		- link layer protocol encapsulates network datagram with linklayer headers to create link layer frame

APPLICATION -> TRANSPORT -> NETWORK -> DATA/LINK
![[Pasted image 20250410155741.png]]

![[Pasted image 20250410155913.png]]

![[Pasted image 20250410155933.png]]


![[Pasted image 20250410160042.png]]

"switches do not modify the frames they forward in any way. This is known as transparent bridging..."

	When packets pass through a router the IP address remain the same except for the ttl decrement. 
	But he MAC address goes significant change.
	The Source MAC is replaced with the routers outgoing interface MAC address and destination MAC is replaced with the next hop MAC address.

![[Pasted image 20250410205210.png]]


The internet hourglass
![[Pasted image 20250410215839.png]]


### Internet Protocol Stack
	- application : HTTP, SMTP, FTP
	- transport : TCP UDP
	- network : routing packets from source to destination, IPv4, IPv6
	- data link : 

### Link Layer Services
	- framing, link access
		- encapsulated datagram into frame
		- reliable delivery between adjacent nodes
		- flow control : pacing between adjacent sending and recieving nodes
		- error detetction : caused by signal attenuation noise.
		- error detection : 
		- half duplex and full duples : with half duplex bothe parties can't communicate at the same time
	- Link layer is implemented at NIC or on a chip
		- attaches into host system's bus
	- LINK LAYER INTERFACES COMMUNICATING
	- sending side
		- encapsulates datagram in frame
		- adds error checking bits, reliable data tranfer, flow control etc
	- recieving side
		- look for errors, reliable data tranfer etc.
		- extracts datagram, passes to upper layer at receiving side
#### IEEE standard for LAN
	- two sublayers
	- upper sublayer : LLC (logical link control), flow and error control
	- lower sublayer : multiple access (MAC) media access control
		- Multiple acces (MAC) for resolving access to the shared media
		- if channel is dedicated (point to point) then we dont need MAC sublayer

![[Pasted image 20250410231810.png]]

### Error Control
	- parity check
	- checksum
	- cyclic redundancy check

![[Pasted image 20250410233011.png]]

	# Parity checking
		detect single bit errors
		set a single bit to keep the parity of the data
		
==set parity so that there is an even number of 1's
		
	# 2D parity checking
		able to detect and correct single bit errors

### Internet Checksum
	- goal : detetct errors in transmitted segment
	- sender : 
		- treat contents of UDP segement (including header and IP address) as 16 bit integers
		- checksum : ones complement sum of segemnt content
	- reciever :
		- calculate an verify the checksum



1. **Summation**: Segments are added using 1’s complement arithmetic, where overflow bits (carry) are added back to the sum[3](https://www.ietf.org/rfc/rfc1071.html)[4](https://dspmuranchi.ac.in/pdf/Blog/Check%20sum.pdf). For example:
    - If segments are `0x48`, `0x65`, `0x6C`, `0x6C`, their 1’s complement sum would be:
        - `0x48 + 0x65 = 0xAD` (no carry).
        - `0xAD + 0x6C = 0x119` → Discard the carry (`0x01`) and add it back: `0x19 + 0x01 = 0x1A`.
        - `0x1A + 0x6C = 0x86`1[4](https://dspmuranchi.ac.in/pdf/Blog/Check%20sum.pdf).
2. **Checksum Generation**: The final sum is complemented (bitwise NOT) to produce the checksum[2](https://stackoverflow.com/questions/5607978/how-is-a-1s-complement-checksum-useful-for-error-detection)[4](https://dspmuranchi.ac.in/pdf/Blog/Check%20sum.pdf).
	    - Example: Sum `0x86` → Checksum `0x79`.
	## **Error Detection at Receiver*
	- The receiver repeats the 1’s complement sum of all segments **including the checksum**.
	- A valid checksum yields a result of all `1`s (e.g., `0xFFFF` for 16 bits), which when complemented gives `0x0000`, confirming no error.

## Cyclic redundancy check
	- more powerful error-detection coding
		- a group of error control bits (which is the remainder of a polynomial division)
		- has considerable burst error detection capability

Sender Side
![[Pasted image 20250411004223.png]] 

Receiver Side
![[Pasted image 20250411004237.png]]


# Ideal multiple access protocol
	- given : multiple channels of rate R bps
	- requirement : 
		- when one node want to send it can at R bps
		- when M nodes want o send it can send at R/M bps
	- fully decentralized


## MAC protocols : taxonomy
	- channel partitioning
		- divide channels into smaller 'pieces' (time slots, frequency, code)
	- random access
		- no division allow collision
		- recover from collisions
	- taking turns
		- nodes take turns, but nodes with data to send can take longer turns
### TDMA (time division multiple access)
	- access to channel in rounds
	- each station gets fixed lenght slot
	- unused slots idle
Here slot 2,5,6 idles and waste bandwidth
![[Pasted image 20250411022412.png]]

### FDMA (channel partitioning)
	Frequency division mutiple access
	- channel spectrum divided into frequency bands
	- each station assigned fixed frequency bands
	- unused bands go idle
	- eg: 5 station LAN, 1,3,4 have packets to send, other 2 are idling and wasting bandwidth

## Random access protocols 
	- when nodes has packets to send, send at full speed
	- detetct collision and correct
	- recorrect via delayed retransmission
	- examples of MAC protocols
	- ALOHA, slotted ALOHA
	- CSMA, CSMA/CD, CSMA/CA (imp and in use)

### Slotted ALOHA
	- assuptions
		- all frames same size 
		- nodes transmit at start of the slot only
		- nodes are synchronized
		- if 2 or more nodes transmit in same slot, all nodes detect collision
	- Operation
		- node transmits data in next available slot
		- if collision then it retransmits in each subsequent slot with probability p until success (subsequent here means even if its not his slot)

### Pure ALOHA
	- unslotted, more simple
	- collision frequency increases

#### Simple CSMA (carrier sense multiple access)
	 - listen before sending
	 - if channel busy dont send otherwise send
	- collsion can still occur
		- propagation delay means two nodes may not hear messages send at the same time.
		- entire packet is send regardless of collision
#### CSMA/CD (CSMA with Collision detetction)
	- if collision detected, stop transmission rather than complete the transmission. 
	- collision detetction easy in wired, but hard in wireless

![[Pasted image 20250413144005.png]]

#### Ethernet CSMA/CD algorithm
	1 NIC recieves datagram from network layer, creates frame
	2 NIC senses the channel
		- if busy dont send, otherwise send
	3 if NIC transmits with no collision NIC is done with frame
	4 if NIC detects another signal while transmitting, abort and send JAM signal
	5 after aborting, NIC enters binary exponential backoff :
		- eg: after 3rd collsion it waits a random amount of time for {0,1,2,3...7} and return to step 2
		- more collsion more backoff

### "TAKING TURNS" MAC protocols
	# channel partitioning MAC protocols
	- at high load very efficient
	- at low load lots of bandwidth wastage. Only 1/N bandwidth used at low load
	# random Access MAC protocols
	- efficient at low load
	- but results in lot of collision at high load
	- Taking turns combines best of both worlds

### Polling
	- master node invites other nodes to transmit in turn
	- used in "dumb" devices
	- cons 
		- polling overhead
		- single point of failure
		- latency

### Token passing
	- control token passed from one node to another
	- token message
	- cons
		- token passing overhead
		- if token lost, it results in large delay
		- single point of failure (token)
		
![[Pasted image 20250413144737.png]]

## Summary of MAC protocols
	- channel partitioning
		- by time, frequency or code
	- random access (dynamic)
		- ALOHA, slotted ALOHA, CSMA, CSMA/CD
		- CSMA/CD used in ethernet
		- CSMA/CA used in 802.11
	- taking turns
		- polling, token passing
		- bluetooth, FDDI, token ring

# DATA LINK LAYER : MAC, LANs

## IEEE 802.11 (Wi-Fi) : multiple access
	- avoids collisions
	- two nodes transmitting at the same time.
	- 802.11 CSMA : if traffic detected don't send
	- 802.11 no collision detection :
		- very difficult to sense collsions
		- hidden terminal, fading, weak recieved signal all makes it very hard to detect collision
	-- Hidden terminal 
		Two nodes A and C (who are out of reach) send data to a common node B. This creates a collision that both A and C can't detect. In wired this would have been detetcted, but not in wireless.
	-- Signal fading
		Signals due to bounceing off walls, distance, interruptions get corrupted or weakened. which mimics collision making it hard to decide.


SIFS (short interframe space)
	- shortest waiting time between frames
	- used for : 
		- ACK
		- CTS (clear to send) after a RTS
		- between fragments of a large frame
DIFS (distributed inter-frame space)
	- a longer delay used by devices to send data if the medium is idle
	- calculate as DIFS = SIFS + 2 * slot time
	- used in DCF (distributed coordination function) the basic access method used in Wi-Fi
### IEEE 802.11 CSMA/CA (collision avoidance)
	802.11 sender
	1) if channel idle for DIFS send entire frame
	2) if channel busy, start random backoff
		1) when timer ends transmit
		2) if no ACK recieved increase random backoff internval, goto 2
	
	802.11 reciever
	a) if frame recieved OK
		return ACK after SIFS (ACK needed due to hidden terminal problem)

![[Pasted image 20250413155133.png]]

### Avoiding collisions
		- sender reserves channel use for data frames using small reservation packets
		- sender first sends RTS (request to send) to access point using CSMA
			- collision might occur, but it will be small.
		- AP broadcasts CTS in response to RTS
		- CTS heard by nodes
			- sender transmits data frame
			- other nodes defer from transmission
here RTS itself collides, but then B starts a larger backoff so that A successfully transmits a RTS to gets a CTS
![[Pasted image 20250413155523.png]]

## MAC addresses 
	- 32 bit IP address:
		- network-layer address for interface.
		- used for layer 3 forwarding
		- eg: 12.42.35.128
	- 48 bit MAC address: 
		- burned in NIC ROM
		- eg: FF:FF:FF:FF:FF:FF
	- each interface on LAN
		- has unique MAC address and IP address

![[Pasted image 20250413163504.png]]

## ARP (address resolution protocol)
	- how to determine MAC address if you know its IP address?
		- ARP table: each IP node(host, router) on LAN has table
		- IP/MAC address mappings for some LAN nodes
		- <IP address, MAC address, TTL> TTL (time to live after which this expires)
		- TTL ~ 20 min
		
- How it works
	- A  broadcasts ARP query, containing B's IP address 
		- With destination MAC as FF:FF:FF:FF:FF:FF
		- all nodes on LAN receive ARP query
	- B will reply to A with its MAC address
	- A adds the MAC address to its ARP table
## Routing to another subnet 
	1) identifying the destination
		1) The host compares its IP address and subnet mask with the desitnation IP address
		2) if the destination IP is outside its own subnet, then it know to forward the packet to the default gateaway (a router)
	2) Forwarding to the router
		1) the host sends the packet to the MAC address of the router (obtained via ARP)
		2) the router recieves the packet and check the routing table (ARP) for an entry matching the destination subnet mask
	3) Routing decision
		1) De-encapsulation : the router strip of the ethernet frame and reads the IP header to find the next hop
		2) Matches the destination IP subnet and finds the MAC of the next hop.
		3) also figures out the outgoing interface
	4) Forwarding to the next subnet
		1) the router decrements the TTL and recalculated the checksum
		2) It encapsulates the new packet to a new Ethernet frame
	5) Delivering the packet
		1) If the router is on a connected subnet, it is delivered directly


## Flow Control
| Feature            | Stop and Wait           | Go-Back-N                    | Selective Repeat                 |     |
| :----------------- | :---------------------- | :--------------------------- | :------------------------------- | --- |
| Frames Sent        | One at a time           | Multiple (up to N)           | Multiple (up to N/2)             |     |
| Error Handling     | Retransmit single frame | Retransmit from error onward | Retransmit only erroneous frames |     |
| Receiver Buffering | Not required            | Not required                 | Required                         |     |
| Efficiency         | Low                     | Moderate                     | High                             |     |
| Complexity         | Low                     | Moderate                     | High                             |     |

# Congestion Control
	congestion : too many sources sending too much data too fast for network to handle.
	- long delays : queuing in router buffers
	- packet loss : buffer overflow in routers
	- congestion control refers to mechanisms that help keep the load below the capacity
## End-End congestion control
	- no explicit feedback from network
	- congestion inferred from observed loss, delay
	- approach taken by TCP
## Network assisted congestion control
	- router provides direct feedback to sending/recieving hosts.
	- may indicate congestion or explicitly set sending rates
	- TCP ECN (explicit congestion notification)

## TCP : Triggering Congestion Control
	- two ways to trigger
	- RTO : sure way of congestion, however time consuming
	- Duplicate ACK : Reciever sends duplicate ACK whenver it recieves out of order segment
		- a loose of sending congestion
		- TCP arbitarily assumes 3ACKs (DUPACKs) imply a packet has been lost. which triggers congestion control mechanism

## AIMD (additive increase multiplicative decrease)
	- add +1 to max segment size every round trip time
	- cut max segment size by two every packet loss
	
![[Pasted image 20250413202317.png]]

### TCP tahoe
	- cut to 1 MSS (max segment size) when loss detected by timeout

### TCP reno
	- cut to half on loss detected by triple duplicate ACK

	- TCP maintains a congestion window. Number of bytes the sender may have in the network at any time.
	- Sender window = min (Congestion window, Reciever advertised window)
	- Every TCP ACK contains a window size that tell the reciever about the sender's window size

Window size field is used in **flow control** (not congestion control) to prevent the sender from overwhelming the receiver.
1. Receiver has, say, 65535 bytes of buffer free → sends `RWnd = 65535` in TCP header.
2. As it receives data, the receiver **updates `RWnd`** in each ACK to reflect remaining space.
3. If buffer fills up → receiver sets `RWnd = 0` → sender must pause.


#### TCP congestion control
	- In the slow-start phase. The window size start from 1 and grows exponentially until it reaches the threshold.
	- After this it linearly increases by 1 until a timeout reaches or max window size is reached.

![[Pasted image 20250413204656.png]]



ssthresh = slow start threshold

**Mechanisms**

1. **Slow Start**: Begins with `cwnd = 1 MSS`, doubling `cwnd` every RTT until reaching `ssthresh`[^2][^6].
2. **Congestion Avoidance**: After `cwnd &gt; ssthresh`, increases `cwnd` by 1 MSS per RTT[^2][^6].
3. **Loss Handling**:
    - On **timeout**: Resets `cwnd = 1`, sets `ssthresh = cwnd/2`, re-enters slow start[^1][^6].
    - On **3 duplicate ACKs**: Same as timeout (fast retransmit)[^6][^9].

**Example**:
A file transfer starts with `cwnd = 1` and `ssthresh = 8`:

1. **Slow Start**: `cwnd` grows exponentially (1 → 2 → 4 → 8) in 3 RTTs.
2. **Congestion Avoidance**: `cwnd` increases linearly (8 → 9 → 10 → 11).
3. **Packet Loss**:
    - If a timeout occurs at `cwnd = 12`, reset `cwnd = 1`, `ssthresh = 6`.
    - Restart slow start until `cwnd = 6`, then switch to additive increase[^1][^3].

---

## TCP Reno

**Improvements Over Tahoe**
Adds **Fast Recovery** to avoid resetting `cwnd` to 1 on duplicate ACKs[^6][^9].

**Mechanisms**

1. **Fast Retransmit**: Resends lost packet after 3 duplicate ACKs.
2. **Fast Recovery**:
    - Sets `cwnd = cwnd/2 + 3` (accounts for 3 duplicate ACKs).
    - Continues transmitting new packets while recovering lost ones[^6][^10].
    - Exits fast recovery when ACK for lost packet arrives[^4][^7].

**Example**:
A video stream with `cwnd = 16` experiences 3 duplicate ACKs:

1. **Fast Retransmit**: Resend lost packet.
2. **Fast Recovery**:
    - `ssthresh = 8`, `cwnd = 8 + 3 = 11`.
    - Continue sending new packets within `cwnd = 11`.
3. **ACK Recovery**:
    - When lost packet’s ACK arrives, set `cwnd = ssthresh = 8`.
    - Resume congestion avoidance[^4][^6].

---

### Key Differences

| Feature | TCP Tahoe | TCP Reno |
| :-- | :-- | :-- |
| **Duplicate ACK Handling** | Resets `cwnd = 1` | Halves `cwnd`, uses fast recovery |
| **Throughput Impact** | Aggressive reduction | Smoother transition |
| **Recovery Phase** | Always re-enters slow start | Skips slow start via fast recovery |

**Performance**: Reno maintains higher throughput under moderate packet loss by avoiding full window resets[^9][^10]. Tahoe’s conservative approach suits environments with frequent severe congestion[^1][^6]. Both use AIMD (`cwnd` += 1 on success, `cwnd` /= 2 on loss)[^2][^6].


In congestion by timeout both algorithms set congestion window to 1.
Congestion by timeout is a critical issue and needs harsh actions.



# Wireless and Mobile netw0rks
	- two important challenges
		- wireless : communication over wireless link
		- mobility : handling changing point of attachment to network.

## 802.11 frame addressing

![[Pasted image 20250413230013.png]]

	This wifi frame will be encapsulated by an ethernet framw with two MAC addresses

![[Pasted image 20250413230157.png]]


# Network Control
	- forwarding : moving packets from routers input interface to appropriate router output -- DATA PLANE --
	- routing : determingin path taken by packets from source to destination -- CONTROL PLANE --


## Per router control plane
	- Individual routing algorithm in each and every router interact in the control plane.
## SDN (software defined networking)
	- remote controllers compute and install routing tables in routers

## Routing protocols
	1) Link state
	2) Distance vector

	Global routing algorithm
		- Each router knows the entire network topology
		- link state algorithms
	Decentralized routing algorithm
		- each router has sense of its neightbouring router only
		- iterative process of computation, exchange of info with neighbours
		- distance vector algorithms

### Dijkstra's link state routing algorithm
	- Centralized : network topology, link costs known to all nodes





# IPv6
## SLAAC (stateless address autoconfiguration)
	enable IPv6 hosts to autoconfigure unique address without a centralized tracking, unlike DHCPv6
	subnets using auto adddressing must be /64s
	1) Link Local addresss generation
		- The host generates a link local address from fe80::/64.
		- using a radom value or its MAC-derived EUI-64
			- the MAC address is unique so it uses it for the rest of the 64 host bits
			- HOW TO?

```
Step 1: Split the MAC Address
The 48-bit MAC address 00:50:79:66:68:1f is divided into two 24-bit parts:

First half (OUI): 00:50:79
Second half (NIC): 66:68:1f

Step 2: Insert FFFE in the Middle
Insert the 16-bit value FFFE between the two halves to create a 64-bit EUI-64 identifier:

00:50:79:FF:FE:66:68:1f

Step 3: Flip the 7th Bit (Universal/Local Bit)

Flip the 7th bit (second bit from the left, highlighted below):
00000000 → 00000010

Convert back to hex:
02

This modifies the first octet from 00 to 02, ensuring the identifier is globally unique.

Final EUI-64 Identifier
After flipping the bit, the EUI-64 becomes:

02:50:79:FF:FE:66:68:1f
```



		- DAD (duplicate address detection) verifies uniqueness via neighbour solicitation messages
	2) Global address assignment
		- Router sends a router solicitation (RS) to prompt routers for prefixes
		- Router reply with a router advertisement (RA) contatingin network prefixes
		- the host combines the network prefix along with interfaceID to form a global unicast address and runs DAD again

![[Pasted image 20250415185506.png]]

	Uses	5	ICMPv6	messages	
	– Router	Solicitation	(RS)	–	request	routers	to	send	RA	
	– Router	Advertisement	(RA)	–	router’s	address	and	subnet	parameters	
	– Neighbor	Solicita;on	(NS)	–	request	neighbor’s	MAC	address	(ARP	Request)	
	– Neighbor	Adver;sement	(NA)	–	MAC	address	for	an	IPv6	address	(ARP	Reply)	
	– Redirect –	inform	host	of	a	beier	next	hop	for	a	desCnaCon
	
	
	- IPv6 128 bits compared to IPv4 32 bits


## Significant protocol changes
	- increased MTU from 576 to 1280
	- no enroute fragmentation. Fragmentation at source only
	- header changes. A lot of fields where removed

A new field flow label is introduced
![[Pasted image 20250415164234.png]]

### Flow label
	- a flow label is 20 bit field in the IPv6 packet header to identify packets that belong to the same flow.
	- A flow is sequence of packets send from a particular to source to a destination
	- traffic class is used to set priority of packets
### Traffic class
	- replaces type of service field in ipv4
	- 8 bit field
	- first 6 bits for identifying service
	- last 2 bits for congestion control without dropping packets (ECN explicit congestion notification)

### Foramtting
	- leading zeroes can be omitted
	- continous string of zeroes can be replaced with ::
	- only use bitcount with IPv6
	- default route ::/0
	- localhost/loopback ::1/128
	- unspecified address ::/128


## Type of IPv6 addresses
	- Unicast addresess
		- Packets send to the unicast address are delivered to just one device
			- Global unicast
				- routable on the internet. Just like IPv4 address
				- 3 parts (48 bit global prefix, 16 bit subnet, 64bit interface ID)
				- addresses that start with range 2000::/3  (in binary beginning is 0010:: /3)

![[Pasted image 20250415174249.png]]
			
			- link local unicast 
				- used for local communications
				- prefix fe80::/10
				- automatically assigned to every IPv6 device on the local link
			- unique local unicast
				- globally unique address for local communication. prefix fd00::/8
				- they are useful when compaines merge and no conflict will occur in existing addresses
				- they are not globally routable, making them secure
	- multicast 
		- often identifies a group on interfaces on different devices
	- anycast
		- anycast addreses are assisned to multiple addresses, but is only delivered to the nearest interface depending on the routing distance.
		- uses the same address as unicast, mostly used for load balancing and redundancy.

![[Pasted image 20250415175119.png]]

#### Multicast
| 8 bits | 4 bits | 4 bits  | 112 bits         |
|--------|--------|---------|------------------|
|   ff   |  flags |  scope  |   Group ID       |

scope bits

| Value | Scope              | Description                            |
|:------|:-------------------|:---------------------------------------|
|     1 | Interface-Local    | Restricted to a single interface.      |
|     2 | Link-Local         | Local network segment (e.g.,ff02::).   |
|     5 | Site-Local         | Entire site/organization.              |
|     8 | Organization-Local | Multiple sites within an organization. |
| e     | Global             | Internet-wide (e.g.,ff0e::).           |  

| Type            | Example Address | Purpose                             |
| --------------- | --------------- | ----------------------------------- |
| **All Nodes**   | `ff02::1`       | All IPv6 nodes on the local link.   |
| **All Routers** | `ff02::2`       | All IPv6 routers on the local link. |

![[Pasted image 20250415201156.png]]


# BGP
	 - standardised exterior gateway protocol that enables global internet routing by exchaning network reachability information between autonomous systems. It maintains internet's routing table.
	 - connects different ASs, cloud services.
	 - path vector : usese attributes like AS path length, next hop address, and policy rules
	 - TCP based reliability port 179
	 - loop prevention : drop routers contiaing local AS number in their path history.
	 - CIDR (classless inter domain routing) for efficient IP address allocation
	 - BPG peers form TCP connections and send OPEN messages to authenticate
	 - peers share routing updates via UPDATE messages containing network paths and attribute.

## RIP 
	- Hop count limit : max 15 hops
	- periodic updates : broadcasts the entire routing table to neighbours every 30s
	- uses bellman-forward algorithm for path calculation
	- easy to configure but inefficient in large networks due to high bandwidth consupmtion
## OSPF
	- uses dijkstras algorithm to compute shortest path
	- fast convergence
	- hierarchial design : divides networks into areas to reduce overhead and improve scalability
	- uses bandwidth instead of hop count to detemine optimal paths
	- only updates when topology change occurs unlike RIP 
	- link state