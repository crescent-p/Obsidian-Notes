TCP, or Transmission Control Protocol, is one of the core protocols of the Internet Protocol (IP) suite. It operates at the transport layer and provides reliable, ordered, and error-checked delivery of a stream of data between applications running on hosts communicating over an IP network.

### Key Features of TCP

1. **Connection-Oriented:**
   - TCP establishes a connection between the sender and receiver before data transmission begins. This is known as a "handshake" process, ensuring both parties are ready to communicate.

2. **Reliable Transmission:**
   - TCP ensures that all data sent from the sender is received by the receiver in the correct order and without errors. If data packets are lost or corrupted during transmission, TCP will retransmit them.

3. **Ordered Data Transfer:**
   - Data packets are delivered in the exact order they were sent. TCP maintains sequence numbers to keep track of the order of packets.

4. **Error Checking:**
   - TCP uses checksums to verify the integrity of data. If a checksum does not match, the packet is discarded and retransmitted.

5. **Flow Control:**
   - TCP implements flow control mechanisms to ensure that a sender does not overwhelm a receiver with too much data at once. This is achieved through the use of a [[sliding window protocol]].

6. **Congestion Control:**
   - TCP adjusts the rate of data transmission based on network congestion levels to avoid overwhelming the network.

### TCP Connection Establishment (Three-Way Handshake)

1. **SYN (Synchronize):**
   - The client sends a SYN packet to the server to initiate a connection.
   
2. **SYN-ACK (Synchronize-Acknowledge):**
   - The server responds with a SYN-ACK packet, acknowledging the client's request and indicating its willingness to establish a connection.
   
3. **ACK (Acknowledge):**
   - The client sends an ACK packet back to the server, confirming the connection is established and ready for data transfer.

### TCP Connection Termination (Four-Way Handshake)

1. **FIN (Finish):**
   - The client sends a FIN packet to the server indicating it has finished sending data.
   
2. **ACK (Acknowledge):**
   - The server acknowledges the FIN packet with an ACK.
   
3. **FIN (Finish):**
   - The server sends its own FIN packet to the client.
   
4. **ACK (Acknowledge):**
   - The client acknowledges the server's FIN packet with an ACK, completing the connection termination process.

### TCP Packet Structure

A TCP packet, also known as a TCP segment, consists of a header and data. The header contains essential control information and is usually 20 bytes long, but it can be longer if options are included.

**TCP Header Fields:**
1. **Source Port (16 bits):** The port number of the sender.
2. **Destination Port (16 bits):** The port number of the receiver.
3. **Sequence Number (32 bits):** The sequence number of the first byte in this segment.
4. **Acknowledgment Number (32 bits):** The next sequence number that the sender expects to receive.
5. **Data Offset (4 bits):** The size of the TCP header.
6. **Reserved (3 bits):** Reserved for future use and should be set to zero.
7. **Flags (9 bits):** Control flags such as SYN, ACK, FIN, RST, PSH, and URG.
8. **Window Size (16 bits):** The size of the sender's receive window (flow control).
9. **Checksum (16 bits):** Used for error-checking the header and data.
10. **Urgent Pointer (16 bits):** Indicates if any data is urgent.
11. **Options (variable):** Optional additional fields.

### Example: Establishing a TCP Connection in C++

```cpp
#include <iostream>
#include <cstring>
#include <unistd.h>
#include <arpa/inet.h>

int main() {
    int sock = 0;
    struct sockaddr_in serv_addr;
    char *hello = "Hello from client";
    char buffer[1024] = {0};

    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        std::cout << "Socket creation error" << std::endl;
        return -1;
    }

    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(8080);

    if (inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr) <= 0) {
        std::cout << "Invalid address/ Address not supported" << std::endl;
        return -1;
    }

    if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
        std::cout << "Connection failed" << std::endl;
        return -1;
    }

    send(sock, hello, strlen(hello), 0);
    std::cout << "Hello message sent" << std::endl;
    int valread = read(sock, buffer, 1024);
    std::cout << buffer << std::endl;

    close(sock);
    return 0;
}
```

### Conclusion

TCP is a fundamental protocol for reliable and ordered data transmission over IP networks. Its features such as connection-oriented communication, error checking, flow control, and congestion control make it suitable for applications where data integrity and order are critical, such as web browsing, email, file transfer, and many more.