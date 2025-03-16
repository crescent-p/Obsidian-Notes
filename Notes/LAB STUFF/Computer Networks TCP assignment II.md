# Setup
	- Same as before setup 3 machine
```C
//installing libraries
sudo apt install libnet1 libnet1-dev //for sending packets
sudo apt install libpcap-dev libnet1-dev  //for recieveing packets (used by wireshark)
```

 ==COMPILE ALL FILES WITH `gcc name.c -lpcap -lnet`== 

	
# IPv4 Packet Headers
	- packet consists of header + payload
	- header about 20 bytes of data + options
	- payload extends from 0 - 1480 bytes (can be bigger than this)


![[Pasted image 20250226221027.png]]
	- Here each row is 4*8 = 32 bits
		- version is which version of IPvX
		- IHL (internet header length) how big the header ? (represented in how many rows there are, so if it said 5, then there would be 5 * (4 * 8) = 5 * 32 bits in header)
		- 



	- What is the type of attack
		- TCP Reset attack
		- attacker sends spoofed TCP packets to one or both the machines
		- an out-of-band operation. Meaning the attakcer cant modify the legitimate packets send by the machines
		- HOW TO PREVENT THIS
			- Improved algorithms to generate the inital sequence number. (ISN)
			- IDPS (intrusion detection and prevention systems) that analyse packets and block suspicious packets using heuristics.
			- encryption. TSL, SSL or IPsec create secure tunnels that encrypt data and TCP headers making it difficult to tamper with
			- verification of Packets before forwarding them.
				- inside the router or switch itself cross-reference the source mentioned and actual source address.
	- PACKET FLAGS
		- URG
			- incoming data is important and should prioritized. Rarely used in real life.
		- ACK
			- when this bit is set. Then the acknowledgment number is valid and should be present. Indicates succesful transfer of data.
			- part of TCP reliability
		- PSH
			- used in SSH connection to skip buffer queue.
		- RST 
			- used to abruptly terminate a connection. No further communication is required
		- SYN
			- start of a TCP connection. Used to synchronize TCP sequence numbers.
		- FIN
			- used to finish a TCP connection. 
	- hping3
		- doesn't need to create a socket connection
		- but uses raw sockets that require sudo access.
		- Allows it to bypass L3 layer OS stack and directly use its own protocols.
		- SOCK_STREAM for TCP and SOCK_DGRAM for UDP
	- TCP connections are uniquely identified by a 4-tuple: source IP, source port, destination IP, and destination port.
	-  Challenge ACKs
	    - Some systems implement additional security measures like challenge ACKs (RFC 5961). If a RST packet is received with a sequence number that is close but not exact, the system may send a challenge ACK instead of immediately accepting the RST. The attacker would then need to respond correctly to this challenge to complete their attack.
		- the RST recieved system sends a packet with expected sequence number. The client should rereply with taht sequence number to break the connection
	- 