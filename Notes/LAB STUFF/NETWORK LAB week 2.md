
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
	- htohs()/ htohl() --> network order to host short/long
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