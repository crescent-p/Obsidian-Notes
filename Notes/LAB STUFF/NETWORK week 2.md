# Socket Programming

## Layers of Networking
	1) Physical
	2) Data link
	3) Network
	4) Transport
	5) Session
	6) Presentation
	7) Application

![[Pasted image 20250114142046.png]]

	Layers 1, 2, 3 are actively used in routers to update relay information like, jump count, time to live etc.
#### Why layering?
	Programmer doesn't need to worry about sending IP packers, ethernet frames, reliability of TCP packets.
	- Only need a way to access transport layer functions. Socket is that API.
	- Lower layer (towards physical) need to know addressing (where to send) and which process to send (multiplexing) the data to.
	- ADDRESSING -> IP address
	- MULITPLEXING -> Port Number

![[Pasted image 20250114142856.png]]
## Sockets
	Setup
		- Where is the remote machine (IP)
		- Which process gets the data (Port)
	Designed just like any other I/O in UNIX
		- send equivalent to write
		- recv equivalent to read
	Close the Socket.

## Binding
	Binding is the process of permanently associating a local address:port number to a server. So that when a connection comes to this addresss the OS can directly send it to the binded process.
	• Client: socket()----------------------->connect()->I/O->close()
	• Server: socket()->bind()->listen()->accept()--->I/O->close()


## Step in establishing a connection

### Step 1 Setup Socket
	Both client and server needs to setup
``` C
int socket(int domain, int type, int protocol)

int sockfd = socket(AF_INET, SOCK_STREAM, 0);
```
##### domain
	AF_INET, -- IPV4
	AF_INET6, -- IPV6
##### type
	SOCK_STREAM -- TCP
	SOCK_DGRAM -- UDP
##### protocol
	0

### Step 2 Binding ( Server only, optional for client )
```C
	int bind(int sockfd, const struct sockaddr* my_addr, socklen_t addrlen);
```
	
	sockfd --> file descriptor socket() returned.
	my_addr --> cast the sockaddr_in* to a sockaddr*
	data for sockaddr is manually added.

	Here the cast is necessary because the fuction is protocol independent (IPV4, IPV6)
```C
struct sockaddr_in {
	short sin_family; // e.g. AF_INET
	unsigned short sin_port; // e.g. htons(3490)
	struct in_addr sin_addr; // see struct in_addr, below
	char sin_zero[8]; // zero this if you want to
};
struct in_addr {
	unsigned long s_addr; // load with inet_aton()
};
struct sockaddr {
	unsigned short sa_family; // address family
	char sa_data[14]; // protocol address
};	
```

```C
Stuct for IPV4
struct sockaddr_in {
    short sin_family;        // Address family (e.g., AF_INET)
    unsigned short sin_port; // Port number in network byte order
    struct in_addr sin_addr; // IP address
    char sin_zero[8];        // Padding to match struct sockaddr size
};

Struct for IPV6
struct sockaddr_in6 {
    short sin6_family;       // Address family (e.g., AF_INET6)
    unsigned short sin6_port;// Port number
    unsigned long sin6_flowinfo;
    struct in6_addr sin6_addr; // IPv6 address
    unsigned long sin6_scope_id;
};
```

	 addrlen --> size of the sockaddr_in

##### Binding
		
```C
memset(&saddr, '\0', sizeof(saddr)); // zero structure out
saddr.sin_family = AF_INET; // match the socket() call
saddr.sin_addr.s_addr = htonl(INADDR_ANY); // bind to any local address
saddr.sin_port = htons(port); // specify port to listen on

if((bind(sockfd, (struct sockaddr *) &saddr, sizeof(saddr)) < 0) { // bind!
	printf(“Error binding\n”);
	...
}
```

	- htons()/ htonl() --> host to network short
	- ntohs()/ ntohl() --> network order to host short/long
	- byte ordering configuration. little endian, big endian
	- little endian LSB is stored first
	- big endian MSB is stored first
	- as a standard networks use big-endian (aka network byte order)
	- so htons() converts host byte order to network byte order of a short integer like port number.
	- htonl() converts long numbers like ip address to network byte order.
	
		When to use these functions?
			- Port numbers : convert before binding sockets (htons) and when interpreting received data (ntohs).
			- IP Addresses : convert before sending them (htonl) and after receiving them  (ntohl).


### Step 3 Listening ( Server )
```C
int listen(int sockfd, int backlog)
```
		sockfd --> file descriptor socket() returned.
		backlog --> pending connections to be handled.
```C
listen(fd, 34);
```
### Step 4 Accept ( Server )
	Server must explicitily accept incoming connections
```C
int accept(int sockfd, struct sockaddr* addr, sockelen_t* addrlen);

	int isock = accept(sockfd, (struct sockaddr_in* )&caddr, &clen);
```

	sockfd --> file descriptor socket() returned
	addr --> pointer to store client address. cast socketaddr_in* to sockaddr*
	addrlen --> pointer to store returned size of addr, 

```C "SERVER CODE"
struct sockaddr_in saddr, caddr;
int sockfd, clen, isock;
unsigned short port = 80;

if((sockfd=socket(AF_INET, SOCK_STREAM, 0) < 0) { // from back a couple slides
	printf(“Error creating socket\n”);
...
}
   
memset(&saddr, '\0', sizeof(saddr)); // zero structure out
saddr.sin_family = AF_INET; // match the socket() call
saddr.sin_addr.s_addr = htonl(INADDR_ANY); // bind to any local address
saddr.sin_port = htons(port); // specify port to listen on

if((bind(sockfd, (struct sockaddr *) &saddr, sizeof(saddr)) < 0) { // bind!
	printf(“Error binding\n”);
	...
}
	  
if(listen(sockfd, 5) < 0) { // listen for incoming connections
	printf(“Error listening\n”);
		...
}
	  
clen=sizeof(caddr)
	  
if((isock=accept(sockfd, (struct sockaddr *) &caddr, &clen)) < 0) { // accept one
	printf(“Error accepting\n”);
	...
}
```


### CLIENT
	client doesn't need to bind, listen or accept only connect

```C
int connect(int sockfd, const struct sockaddr* saddr, socklen_t addrlen);

connect(sockfd, (struct sockaddr *) &saddr, sizeof(saddr));
```
### Domain Name System
	1) converts hostname to IP addresses.
```C
struct hostent *gethostname(const char* name);
```
	2) convert ip address to hostname.
```C
struct hostent *gethostbyaddr(const char* addr, int len, int type);
```

```C   "CLIENT code"
struct sockaddr_in saddr;
struct hostent *h;
int sockfd, connfd;
unsigned short port = 80;

if((sockfd=socket(AF_INET, SOCK_STREAM, 0) < 0) { // from back a couple slides
	printf(“Error creating socket\n”);
	...
}
   
if((h=gethostbyname(“www.slashdot.org”)) == NULL) { // Lookup the hostname
	printf(“Unknown host\n”);
	...
}
   
memset(&saddr, '\0', sizeof(saddr)); // zero structure out
saddr.sin_family = AF_INET; // match the socket() call
memcpy((char *) &saddr.sin_addr.s_addr, h->h_addr_list[0], h->h_length); // copy the address
saddr.sin_port = htons(port); // specify port to connect to

if((connfd=connect(sockfd, (struct sockaddr *) &saddr, sizeof(saddr)) < 0) { // connect!
	printf(“Cannot connect\n”);
	...
}
```

### Connected
	Now server and client are connected. 
	1) read
	2) write
```C
read(sockfd, buffer, sizeof(buffer)); 
write(sockfd, “hey\n”, strlen(“hey\n”))
```
## TCP Framing
	- Doesn't guarentee message boundaried
	- IRC commands are terminated by a newline.
	- may come as "hel", "lo\n"
	- if entire line not from one read() use a buffer.

![[Pasted image 20250114182849.png]]

## Close
	after sending the file. Clost the file descriptor.

```C
int close(int sockfd);
```

## Concurrency
	Allowing multiple connections at the same time.
	1) Threading 
		1) multiple threads running an instance of the process.
		2) leverages multi core systems.
		3) disadvantage - race conditions, scalability - not enough resource to create one thread per user
	2) select() function
		1) used for monitoring multiple file descriptors (sockets) simultaneously, allowing multiple connections per thread.
		2) select() blocks one or more fd's until one is read to read/write.
		3) Advantages: 
			1) explicit control - fine grain control to programmer on how fd's are handled.
			2) no need for synchronization.
			3) efficient for many connections - scales better beacause a single thread can handle many.
		4) Disadvantages:
			1) Complex control flow
			2) perfomance limitations
				1) only upto 1024 fd's can be monitored by a single select() in most systems.

### Step 1 Allowing address reuse
	When a socket is closed the port it was binded to may stay in a state of TIME_WAIT for a while, preventing other connections to come through. Address reuse ensures the port is reassgined to another socket immediately.
```C
int sock, opts = 1;
sock = socket(...); // Create a socket
setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &opts, sizeof(opts));
```
### Step 2 Set sockets to be non-blocking
	In non-blocking mode operations like accept(), recv(), send() will return immediately if they can't proceed, instead of blocking the program from continuing.
```C
if ((opts = fcntl(sock, F_GETFL)) < 0) { // Get current flags
    printf("Error getting socket options...\n");
    // Handle error
}
/bitmasking
opts = opts | O_NONBLOCK; // Add non-blocking mode
if (fcntl(sock, F_SETFL, opts) < 0) { // Set the updated flags
    printf("Error setting socket options...\n");
    // Handle error
}
```

### Step 3 Monitor sockets with select()
```C
int select(int maxfd, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, const struct timespec *timeout);
```
	maxfd --> max file descriptor + 1
	fd_set --> bit vector with FD_SETSIZE bits
			- readfds: bit vector of read descriptors to monitor
			- writefds: bit vector of write descriptors to monitor
			- exceptfds: set to NULL
	timeout --> how long to wait without activity before returning


#### Bit vectors
```C
void FD_ZERO(fd_set* fdset);
//clear out all the bits
void FD_SET(int fd, fd_set* fdset);
//set fd bit to 1
void FD_CLR(int fd, fd_set* fdset);
//change 1 to 0 in fd bit
void FD_ISSET(int fd, fd_set* fdset);
// checks if fd bit is set or not
```


 ==$INDEPTH$==

# Introduction
	A computer network is a connection of computers conneceted through some routers and swithes. Primary goal is to share computing power. For this information need to be transmitted and recieved. For sending and receiving sockets are created. Programs that do this are known as socket programs.


## Accessing Datalink Layer
	tcpdump directly access the data link layer to display all the packets send and received.
	- When a packet is received by the Network interface card, the packet is transferred to the kernel by DMA(direct memory access) controller, and the packet is put in a buffer. 
	- NIC has two modes, promiscuous mode and non-promiscuous mode. promiscuous mode allows a network device to intercept and read each network packet in its entirety. In non-promiscuou mode the packets are filtered and only relevant ones are let through.
	- To access the DLL the buffer has to be accessed, where the packets are forwared by the NIC.

### Understanding the 'tcpdump' program
	Allows the user to see all the packets send and received on the system from terminal line.

![[Pasted image 20250115220332.png]]

	kernel may drop packets dur to low buffer space.

### Access to DLL
	packet_sockets are used to recieve or send raw packets at the device driver (datalink layer) level. They allow user to implement protocol modules in user space on top of the physical layer.

```c
#include <sys/socket.h>
#include <netpacket/packet.h>
#include <net/Ethernet.h> /* For DLL protocols */
packet_socket = socket(PF_PACKET, int socket_type, int protocol);
```

	socket() return a socket descriptor, here packet_socket. 
	- PF_PACKET for creating packet socket. 
	- socket_type is either SOCK_RAW or SOCK_DGRAM, SOCK_RAW includes the link level header and SOCK_DRAM has the header removed. 
	- htonl() and htons() are used to convert between byte order.
	- protocol refers to IEEE 802.3 protocol number in network byte order.
		- when protocol field is set to ETH_P_ALL then the packets of all protocol to which ethernet forwarda data, are received.

	To recieve packets
```C
#include <sys/socket.h>
int recvfrom(int packet_socket, void *buf, unsigned int len, int flags,struct sockaddr *from, unsigned int *fromlen);
```
	is called. 
		- buf stores the incoming data. 
		- buf has a length of len.
		- from provides the source address, which is in sockaddr format
		- the from address is caseted to a sockaddrll format which is device independent.
		- when transmitting a packet the user defined buffer should contain the physical layer header, that packet is queued unmodified to the network driver of the interface defined by the destination address.

### Ethernet Frames
	Packets of informations that adhere to the Ethernet protocol. Contains data to be transmitted wrapped in other informations like addressing and error checking.
	1) Preamble (7 bytes)
		- a sequence of 0's and 1's to synchronize sender and recienver
	2) Start frame delimiter (1 byte)
	3) Destination MAC address (6 byte)
	4) Source MAC address (6 byte)
	5) EtherType/Lenght (2 byte)
	6) Payload (46 to 1500 bytes)
	7) Frame check sequence (4 bytes)
		1) Cyclic redundancy check value used to check for error during transmission.

```C
struct sockaddr_ll {
	unsigned short sll_family; /* Always AF_PACKET */
	unsigned short sll_protocol; /* Protocol */
	int sll_ifindex; /* Interface number */ 0 matches any interface
	unsigned short sll_hatype; /* Header type */
	unsigned char sll_pkttype; /* Packet type */
	unsigned char sll_halen; /* Length of address */
	unsigned char sll_addr[8]; /* Physical layer address */
};
```
#### Fields in `struct sockaddr_ll`

1. **`sll_family`**
    
    - Type: `unsigned short`
    - Description: Specifies the address family. This field is always set to `AF_PACKET` for raw socket communication at the link layer.
2. **`sll_protocol`**
    
    - Type: `unsigned short`
    - Description: Specifies the protocol to use at the link layer. For example:
        - `htons(ETH_P_IP)` for IP packets.
        - `htons(ETH_P_ARP)` for ARP packets.
    - Use `htons()` to convert protocol values to network byte order.
3. **`sll_ifindex`**
    
    - Type: `int`
    - Description: Specifies the interface index (unique identifier for network interfaces on a system).
        - Use `0` to match any interface.
        - You can retrieve the interface index using functions like `if_nametoindex()`.
4. **`sll_hatype`**
    
    - Type: `unsigned short`
    - Description: Specifies the ARP hardware type (e.g., Ethernet is typically `ARPHRD_ETHER`).
    - Defines the type of hardware used by the interface.
5. **`sll_pkttype`**
    
    - Type: `unsigned char`
    - Description: Specifies the packet type. Possible values:
        - `PACKET_HOST`: Packet addressed to the local host.
        - `PACKET_BROADCAST`: Broadcast packet.
        - `PACKET_MULTICAST`: Multicast packet.
        - `PACKET_OTHERHOST`: Packet not destined for this host.
        - `PACKET_OUTGOING`: Outgoing packet.
6. **`sll_halen`**
    
    - Type: `unsigned char`
    - Description: Specifies the length of the hardware (physical) address. For Ethernet, this is typically `6` bytes.
7. **`sll_addr`**
    
    - Type: `unsigned char[8]`
    - Description: Contains the hardware (physical) address of the device.
        - For Ethernet, this will store the MAC address.


```C
#include<sys/socket.h>
#include<netpacket/packet.h>
#include<net/ethernet.h>
int main(){
	int sockfd, len;
	char buffer[2048];
	struct sockaddr_ll pla;
	sockfd=socket(PF_PACKET,SOCK_RAW,htons(ETH_P_ALL));
	if(sockfd<0){
		perror("packet_socket");
		exit(0);
	}
	printf("Types of the captured packets are...\n"
		while(1){
		len = sizeof(struct sockaddr_ll);
		recvfrom(sockfd,buffer,sizeof(buffer),0,
		(struct sockaddr *)&pla,&len);
		switch(pla.sll_pkttype){
		// these constant values are taken from linux/if_packet.h
			case 0://PACKET_HOST
				printf("For_Me\n");
				break;
			case 1://PACKET_BROADCAST
				printf("Broadcast\n");
				break;
			case 2://PACKET_MULTICAST
				printf("Multicast\n");
				break;
			case 3://PACKET_OTHERHOST
				printf("Other_Host\n");
				break;
			case 4://PACKET_OUTGOING
				printf("Outgoing\n");
				break;
			case 5://PACKET_LOOPBACK
				printf("Loop_Back\n");
				break;
			case 6://PACKET_FASTROUTE
				printf("Fast_Route\n");
				break;
		}
	}
}
```

### Handling an interface in promiscuous mode
	if protocol field of socket() is set to ETH_P_ALL, the ethernet accepts all the broadcast and unicast packets addresed to the system. If you set it to promiscous mode it capture packets not meant for the device too.
	- Before setting an interface in promiscous mode we need to get information regarding the interface.
```C
#include <sys/ioctl.h>
int ioctl(int d, int request, ptr* pointer)
```
	d => valid packet socket descriptor
	request => device-dependent request code.
	pointer => depends on the device. the requested data is stored in the location pointed to by the pointer.
```C
struct ifreq req;
strcpy(req.ifr_name,"eth0");
io = ioctl(sockfd,SIOCGIFINDEX,&req);
if(io<0)
	printf("The interface eth0 does not exist");
```
## Accessing Network Layer
	Application layer usually interacts with the transport layer like TCP/UDP. Some programs like the ping program interacts directly with the network layer bypassing the transport layer.
	The sockets that allow interacting with the network layer are the raw sockets.

		Proper knowledge of the information to be filled in each protocol is curcial. Linux provides with structures like struct ip. We just need to fill them correctly.
		1) IP
		2) ICMP
		3) TCP
		4) UDP
### IP
	IP is the Network/Internet layer protocol used for routing data from the source to the destination.Every datagram contains an IP header followed by a transport layer protocol such as TCP.
```C
struct ip {
	u_int ip_hl:4, ip_v:4; /* this means, each member is 4 bit long */
	u_char ip_tos;
	u_short ip_len;
	u_short ip_id;
	u_short ip_off;
	u_char ip_ttl;
	u_char ip_p;
	u_short ip_sum;
	struct in_addr ip_src, ip_dst;
}; /* total ip header length: 20 bytes (=160 bits) */
```
	- ip_hl : length of the header. To get it in bytes multiply by 4. Necessary to determine where the payload starts.
	- ip_v : ip version, typically IPv4
	- ip_tos : type of service. routing priority, delay, throughtput, reliability, cost etc
	- ip_len : Total length of the IP datagram. Include size of IP header size + (UPD/TCP/UDP header size) + payload size 
		- range : 0 - 65535(2^15) bytes
	- ip_off : fragment offset used for reassembly of fragmented datagrams.
	- ip_ttl : time to live, number of hops before it is send back/discarded. MAX 255
	- ip_p : protocol : TCP(6) UPD(7) ICMP(1) or whatever protocol
	- ip_sum : checksum
		- is checksum is incorrect the router will discard the packet.
	- ip_src, ip_dst: source and destination addresses, converted to long format by inet addr().

	Example 1: Small Packet
	
	- IP header length: 20 bytes (default, no options).
	- TCP header length: 20 bytes.
	- Payload size: 100 bytes.
	
$ip len=20+20+100=140bytes.$

### ICMP
	An addition to IP protocol to carry error, routing and control messages and data.

```C
struct icmp {
	unsigned char icmp_type;
	unsigned char icmp_code;
	unsigned short int icmp_cksum;
	/* The following data structures are ICMP type specific */
	unsigned short int icmp_id;
	unsigned short int icmp_seq;
}; /* total icmp header length: 8 bytes (=64 bits) */
```
	icmp_type : type of message, echo reply, echo request, destination unreachable etc.
	icmp_code : error code
	icpmp_cksum : checksum
	icmp_id : used in echo request/reply to identify messsage
		- ICMP ping requests and their corresponding replies need to be matched.
	icmp_seq : identifies the sequence of echo messages, if more than one is sent.
### UDP
	UDP is a transport protocol for sessions that need to exchange data. Not reliable though. Both UDP and TCP provide 65535 unique ports. UDP dosen't use sequence numbers or stateful connections.

```C
struct udphdr { /* For Linux */
	u_short source;
	u_short dest;
	u_short len;
	u_short check;
};
```

### TCP
	Tcp is a reliable connection. There is some basic authentication, using connection states and sequence numbers.A struct like tcphdr is used to from a header.
```C
struct tcphdr {
	u_short th_sport; // the source port
	u_short th_dport; // the destination port
	tcp_seq th_seq; // sequence number, the tcp packets maybe broken up and send as sepeartae packets that are put together.
	tcp_seq th_ack; // contains previous seq nubmer 
	u_int th_x2:4, th_off:4; /* each member is 4-bit long */ // offset specifies header length. Payload starts after header.
	u_char th_flags; // binary flags, TH_URG, TH_ACK : used to acknoledge data and in 2nd and 3rd step of TCP connection initiaition, TH_PSH : the systems IP stack will not buffer and push it immediately, TH_RST, TH_SYN, TH_FIN : final messages, connection closes after this.
	u_short th_win; // amount of data that can be send before an ACK is required by receiving party.
	u_short th_sum; // checksum
	u_short th_urp; // urgent pointer, set to the end of payload data that needs to be send urgently
}; /* total tcp header length: 20 bytes (=160 bits) */
```
		
## Raw Sockets
	Basic concept of low level sockets is to send the packet with all the headers filled in by us instead of the kernel.
```C
int s;
s = socket(PF_INET, SOCK_RAW, protocol);
/*
PF_INET : protocol for INternET
SOCK_RAW : for creating raw socket
if we put 0 in protocol, we will recieve a copy of all the datagrams passing through the kernel.
protocol specifies a constant for each tyep of connection. 
IPPROTO_ICMP, IPPROTO_TCP, IPPROTO_UDP
You can only send and recieve IP packets with the matching protocol.
*/
```

```C
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
int main(){
	int fd = socket (PF_INET, SOCK_RAW, IPPROTO_TCP);
	struct ip *iph;
	char buffer[8192]; /* single packets are usually not bigger than 8192 bytes */
	while (recvfrom (fd, buffer, 8192, 0, NULL, NULL) > 0){
		iph = (struct ip*) buffer;
		printf("Received packet from %s\n", inet_ntoa(iph->ip_src));
		printf ("TCP data: %s\n", buffer+sizeof(struct ip)+sizeof(struct tcphdr));
	}
}
```


## TCP Sockets
	Raw sockets and packet socket are used for monitoring and adminitring the network.
	Almost all application programs use TCP sockets(stream) or UDP sockets (datagram). 
	Two type of processes.
		1) client process
		2) server process
	A TCP socket is defined as an endpoint for connection. A conncection can be viewed as the pair <ip_addr, port_num>
	On Unix machines /etc/services contains list of services and ports used by them.
#### TCP client and server
	A TCP connection can be thought as a pair of connections. One from client to server and from server to client. 
	Suppose client C wants to browse a webpage on server S with ip addr 146.86.5.20:80, the localhost of client C will allocate a free port address to that service and the complete connection would look like

$$< 146.86.3.15 : 12345 \space , \space 146.86.5.20 : 80 >$$
	A Three way handshaking process is done to initate a connection. The client always make the first request/communication.
### Socket address
	Sockets created by some application is identified by a socket address. Socket address is the combination of an ipaddr together with the port number. 

```C
struct in_addr {
	in_addr_t s_addr; /* 32-bit IP address; network byte ordered */
};
struct sockaddr_in {
	uint8_t sin_len; /* length of structure */
	sa_family_t sin_family; /* PF_INET */
	in_port_t sin_port; /* TCP/UDP port number; network byte ordered */
	struct in_addr sin_addr; /* IP address */
	char sin_zero[8]; /* unused */
};
```
	socket(), bind(), listen(), accept() are the elementray API's required to create a connection.

### TCP Socket API's
#### socket
```C
# include <sys/socket.h>
int socket(int f amily, int type, int protocol);
```
	Function creates an endpoint for communication. Return an integer, negative if an error occurs.
	family can be AF_INET or PF_INET (protocol family for internet)
	type can be SOCK_DRAM for UDP, or SOCK_STREAM for TCP

```C
int s;
s = socket(AF INET, SOCK STREAM, 0);
// TCP and UDP has only one protocol, so it can be set to 0.
```

![[Pasted image 20250125200418.png]]

#### connect()
```C
# include <sys/socket.h>
int connect(int s, const struct sockaddr ∗addr, int addr_len);
```
	This is initiated by the client to establish a connection with the server.addr_len stores the length of addr. connect() blocks until a connection is successful or an error occurs.
	The connect() in client side and accept() in server side are directly involved in the three way handshake.
```C
	int c;
	struct sockaddr_in server_addr;
	s = socket(AF_INET, SOCK_STREAM, 0);
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(9999);
	inet pton(AF_INET,"146.86.5.20",&server_addr.sin_addr);
	c = connect(s, (struct sockaddr*)&server_addr, sizeof(sockaddr_in));
	
	if(c<0){
		printf("connect error");
		exit(0);
	}
```

#### bind()
	bind() is called by the TCP server. Before sending and receiveing data it must binded with a local port and network address. 

```C
# include <sys/socket.h>
int bind(int s, const struct sockaddr ∗myaddr, int addr len);
```
	s = number returned by socker()

```C
	struct sockaddr in sin;
	int s, b;
	s = socket(AF INET, SOCK STREAM, 0);
	sin.sin family = AF INET;
	sin.sin port = htons(9999);
	sin.sin addr.s addr = INADDR ANY;
	b = bind(s, (struct sockaddr *)&sin, sizeof(sin));
	if(b<0){
		printf("bind error");
		exit(0);
	}
/* s is now a usable TCP socket. Server port is 9999. */
```
	sometimes bind may be unsuccessful if port is already in use. It will return -1 in that case.

#### listen()
```C
# include <sys/socket.h>
int listen(int s, int backlog);
```
	socket() -> bind() -> listen()
	listen tells the kernel that it should accept requests on the given port.

#### accept()
	This is a blocking operation that does not return until a remote client has established a connection.
```C
# include <sys/socket.h>
int accept(int s, struct sockaddr ∗Caddr, int ∗Caddr_len);
```
	after successful execution of accept Caddr is filled with client information and Caddr_len contains the lenght of Caddr.
	A listening socket can be viewed as a pair <server's IP addr, server's port number>. So no data transfer is possible.
	On the other hand an accepted sokcet contains both pairs. server <ip, port> and client <ip , port>.

#### write, read, send  and recv
```C
int write(int confd, char *buffer, int msg len);
int read(int confd, char *buffer, int msg len);
OR
int send(int confd, char *buffer, int msg len, int flags);
int recv(int confd, char *buffer, int buf len, int flags);
```
### Some other import API's
#### IP address conversion
	User understand only dotted ip address, while computer understands big-endian byte orderd one aka network byte order. 
```C
const char *inet ntop(int f amily, const void ∗numeric, char ∗presentation,
socklen t plen);
int inet pton(int f amily, const char ∗presentation, void ∗numeric);
```
	converts ip address from presentation (dotted) to network byte order and vice versa.
#### Byte ordering functions
```C
uint32 t htonl(uint32 t hostlong);
uint16 t htons(uint16 t hostshort);
//host to netwrok long short 
uint32 t ntohl(uint32 t netlong);
uint16 t ntohs(uint16 t netshort);
//network to host short/long
```
	The byte ordering of computer may be different from network byte order (big endian) so you may need to convert between two before sending them.

```C client code for file transfer
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>

#define MAXLEN 100
#define PORT 12345

int main(int argc, char **argv) {
    int s;
    char buff[MAXLEN], ACK[3];
    struct sockaddr_in saddr;
    FILE *fp;

    if (argc != 3) {
        printf("Usage: %s <Server’s address> <file name>\n", argv[0]);
        exit(0);
    }

    s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0) {
        perror("socket");
        exit(0);
    }

    saddr.sin_family = AF_INET;
    saddr.sin_port = htons(PORT);

    if (inet_pton(AF_INET, argv[1], &saddr.sin_addr) <= 0) {
        printf("Error: Invalid IP address\n");
        exit(0);
    }

    if (connect(s, (struct sockaddr *)&saddr, sizeof(saddr)) < 0) {
        perror("connect");
        exit(0);
    }

    write(s, argv[2], strlen(argv[2]));
    if ((fp = fopen(argv[2], "r")) == NULL) {
        perror(argv[2]);
        exit(0);
    }

    read(s, ACK, 2);
    while (1) {
        fgets(buff, MAXLEN - 1, fp);
        if (feof(fp))
            break;

        write(s, buff, sizeof(buff));
        read(s, ACK, 2);
    }

    fclose(fp);
    close(s);

    return 0;
}
```

### **Main Function**

#### 1. **Argument Validation**

```c
if (argc != 3) {
    printf("Usage: %s <Server’s address> <file name>\n", argv[0]);
    exit(0);
}
```

- The program expects two arguments:
    1. The server's IP address (`argv[1]`).
    2. The file name to send (`argv[2]`).
- If the number of arguments is incorrect, it prints the usage and exits.

---

#### 2. **Socket Creation**

```c
s = socket(AF_INET, SOCK_STREAM, 0);
if (s < 0) {
    perror("socket");
    exit(0);
}
```

- A TCP socket is created using the `socket()` function.
- `AF_INET`: Specifies IPv4 addressing.
- `SOCK_STREAM`: Specifies TCP protocol.
- If the socket creation fails, `perror` is used to print the error.

---

#### 3. **Server Address Setup**

```c
saddr.sin_family = AF_INET;
saddr.sin_port = htons(PORT);

if (inet_pton(AF_INET, argv[1], &saddr.sin_addr) <= 0) {
    printf("Error: Invalid IP address\n");
    exit(0);
}
```

- The `sockaddr_in` structure is initialized:
    - `sin_family`: Specifies IPv4.
    - `sin_port`: Converts `PORT` to network byte order using `htons`.
    - `sin_addr`: Converts the server's IP address from text to binary using `inet_pton`.

---

#### 4. **Connecting to the Server**

```c
if (connect(s, (struct sockaddr *)&saddr, sizeof(saddr)) < 0) {
    perror("connect");
    exit(0);
}
```

- The `connect()` function establishes a connection to the server.
- If the connection fails, the program exits with an error message.

---

#### 5. **Sending File Name**

```c
write(s, argv[2], strlen(argv[2]));
if ((fp = fopen(argv[2], "r")) == NULL) {
    perror(argv[2]);
    exit(0);
}
```

- The file name is sent to the server using `write()`.
- The file is then opened in read mode (`"r"`). If the file cannot be opened, an error is printed.

---

#### 6. **Reading ACK and Sending File Data**

```c
read(s, ACK, 2);
while (1) {
    fgets(buff, MAXLEN - 1, fp);
    if (feof(fp))
        break;

    write(s, buff, sizeof(buff));
    read(s, ACK, 2);
}
```

- The client waits for an acknowledgment (`ACK`) from the server before sending file data.
- In the loop:
    1. `fgets()` reads lines from the file into `buff`.
    2. If the end of the file is reached (`feof()`), the loop exits.
    3. The line is sent to the server using `write()`.
    4. The client waits for an acknowledgment from the server before continuing.

---

#### 7. **Closing Resources**

```c
fclose(fp);
close(s);
```


### Server Code

```c
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string.h>

#define MAXLEN 100
#define PORT 12345

int main(int argc, char **argv) {
    int s, connfd, len, n;
    char recv[MAXLEN], recvaddr[16];
    struct sockaddr_in saddr, caddr;
    FILE *fp;

    // Create a socket
    s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0) {
        perror("socket");
        exit(0);
    }

    // Initialize server address structure
    saddr.sin_family = AF_INET;
    saddr.sin_addr.s_addr = htonl(INADDR_ANY);
    saddr.sin_port = htons(PORT);

    // Bind the socket to the specified port
    if (bind(s, (struct sockaddr *)&saddr, sizeof(saddr)) < 0) {
        perror("bind");
        exit(0);
    }

    // Listen for incoming connections
    listen(s, 5);

    while (1) {
        printf("Waiting for request...\n");

        len = sizeof(struct sockaddr_in);
        connfd = accept(s, (struct sockaddr *)&caddr, &len);

        // Read file name from client
        n = read(connfd, recv, MAXLEN - 1);
        recv[n] = '\0';

        // Open file for writing
        fp = fopen(recv, "w");
        if (fp == NULL) {
            perror("File open");
            close(connfd);
            continue;
        }

        // Send acknowledgment to the client
        write(connfd, "OK", 2);

        // Receive and write file data
        while ((n = read(connfd, recv, MAXLEN - 1)) > 0) {
            recv[n] = '\0';
            fwrite(recv, 1, strlen(recv), fp);
            write(connfd, "OK", 2);  // Send acknowledgment
        }

        fclose(fp);

        // Display the client's address and port
        inet_ntop(AF_INET, &caddr.sin_addr, recvaddr, sizeof(recvaddr));
        printf("File uploaded from %s, port=%d\n\n", recvaddr, ntohs(caddr.sin_port));

        close(connfd);  // Close the connection
    }

    return 0;
}
```

---

#### **Explanation**

##### **1. Includes and Definitions**

```c
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string.h>
```

- **`<stdio.h>`**: Provides standard input/output functions like `printf` and `fwrite`.
- **`<sys/socket.h>`**: Contains socket functions like `socket`, `bind`, `listen`, and `accept`.
- **`<netinet/in.h>`**: Provides definitions for Internet address structures.
- **`<stdlib.h>`**: For `exit` function.
- **`<string.h>`**: For functions like `strlen`.

```c
#define MAXLEN 100
#define PORT 12345
```

- **`MAXLEN`**: Maximum size of the buffer used to read data.
- **`PORT`**: Specifies the port number the server listens on.

---

##### **2. Socket Creation**

```c
s = socket(AF_INET, SOCK_STREAM, 0);
if (s < 0) {
    perror("socket");
    exit(0);
}
```

- A TCP socket is created.
- **`AF_INET`**: Specifies IPv4.
- **`SOCK_STREAM`**: Specifies TCP.

---

##### **3. Binding to an Address and Port**

```c
saddr.sin_family = AF_INET;
saddr.sin_addr.s_addr = htonl(INADDR_ANY);
saddr.sin_port = htons(PORT);

if (bind(s, (struct sockaddr *)&saddr, sizeof(saddr)) < 0) {
    perror("bind");
    exit(0);
}
```

- The server binds to all available network interfaces (`INADDR_ANY`) and listens on the specified `PORT`.

---

##### **4. Listening for Incoming Connections**

```c
listen(s, 5);
```

- The server starts listening for incoming connections.
- The argument `5` specifies the maximum number of pending connections in the queue.

---

##### **5. Accepting Connections**

```c
len = sizeof(struct sockaddr_in);
connfd = accept(s, (struct sockaddr *)&caddr, &len);
```

- The `accept()` function waits for a client connection.
- On success, it returns a new socket descriptor (`connfd`) for communication with the client.

---

##### **6. Handling File Upload**

 **6.1 Reading the File Name**

```c
n = read(connfd, recv, MAXLEN - 1);
recv[n] = '\0';
fp = fopen(recv, "w");
```

- The server reads the file name sent by the client and opens it for writing.
- If the file cannot be opened, it skips further processing.

 **6.2 Sending Acknowledgment**

```c
write(connfd, "OK", 2);
```

- The server sends an acknowledgment ("OK") to the client, indicating readiness to receive data.

 **6.3 Receiving File Data**

```c
while ((n = read(connfd, recv, MAXLEN - 1)) > 0) {
    recv[n] = '\0';
    fwrite(recv, 1, strlen(recv), fp);
    write(connfd, "OK", 2);  // Acknowledge each chunk
}
```

- The server reads chunks of data from the client and writes them to the file using `fwrite`.
- After processing each chunk, it sends an acknowledgment to the client.

---

##### **7. Logging Client Details**

```c
inet_ntop(AF_INET, &caddr.sin_addr, recvaddr, sizeof(recvaddr));
printf("File uploaded from %s, port=%d\n\n", recvaddr, ntohs(caddr.sin_port));
```

- The server logs the client's IP address and port using `inet_ntop` and `ntohs`.

---

##### **8. Closing the Connection**

```c
close(connfd);
```

- The server closes the connection with the client and waits for the next request.

---

#### **How the Program Works**

1. The server sets up a TCP socket and listens for connections on `PORT`.
2. When a client connects, the server:
    - Reads the file name.
    - Opens the file for writing.
    - Receives file data from the client in chunks, writes it to the file, and sends acknowledgments.
3. The server logs the client's details and closes the connection.

This process repeats indefinitely for subsequent clients. The server ensures reliable file transfer over TCP.

## UDP Sockets
	