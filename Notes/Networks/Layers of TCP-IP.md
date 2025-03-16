The TCP/IP model, also known as the Internet Protocol Suite, is a set of communication protocols used for the Internet and similar networks. It consists of four abstraction layers, each with specific functions and protocols. These layers, from lowest to highest, are:
[[OSI model]]

### 1. Link Layer (Network Interface Layer)
- **Function:** Responsible for the physical transmission of data over a network medium and managing hardware addressing. It ensures that data can be sent over a particular network link.
- **Protocols and Technologies:** Ethernet, Wi-Fi, ARP (Address Resolution Protocol), PPP (Point-to-Point Protocol), MAC (Media Access Control) addresses.
- **Example:** When a computer sends data to another device on the same local network, it uses the link layer to encapsulate the data into frames suitable for transmission over the physical medium (e.g., Ethernet cable).

### 2. Internet Layer
- **Function:** Manages logical addressing and routing of data packets across different networks. It ensures that data can travel from the source network to the destination network.
- **Protocols:** [[IP]] (Internet Protocol), ICMP (Internet Control Message Protocol), IGMP (Internet Group Management Protocol), ARP (Address Resolution Protocol).
- **Example:** IP (Internet Protocol) is used to route data packets from the sender to the recipient across multiple interconnected networks, each with its own addressing scheme.

### 3. Transport Layer
- **Function:** Provides end-to-end communication, error checking, and flow control. It ensures that data is transmitted reliably and in the correct order.
- **Protocols:** TCP (Transmission Control Protocol), UDP (User Datagram Protocol).
- **Example:** TCP provides reliable, connection-oriented communication, ensuring that data packets are delivered in the correct order and without errors. UDP provides faster, connectionless communication without error checking.

### 4. Application Layer
- **Function:** Provides protocols and services that directly support user applications and facilitate communication between software applications. It includes protocols that specify the data format and the procedures for data exchange.
- **Protocols:** [[HTTP]] (Hypertext Transfer Protocol), HTTPS (HTTP Secure), FTP (File Transfer Protocol), SMTP (Simple Mail Transfer Protocol), DNS (Domain Name System), POP3 (Post Office Protocol), IMAP (Internet Message Access Protocol), [[SSH]] (Secure Shell), Telnet.
- **Example:** HTTP is used by web browsers and servers to exchange web pages, while SMTP is used to send and receive emails.

### Summary Diagram

```
+-------------------+-----------------------------+
| Application Layer | HTTP, HTTPS, FTP, SMTP, DNS |
+-------------------+-----------------------------+
| Transport Layer   | TCP, UDP                    |
+-------------------+-----------------------------+
| Internet Layer    | IP, ICMP, IGMP, ARP         |
+-------------------+-----------------------------+
| Link Layer        | Ethernet, Wi-Fi, PPP, ARP   |
+-------------------+-----------------------------+
```

### Relationship to the OSI Model
The TCP/IP model is often compared to the OSI (Open Systems Interconnection) model, which has seven layers. The TCP/IP model is a simplified version and groups the functionalities of the OSI model's seven layers into four layers. Here is a rough mapping:

- **Application Layer:** Corresponds to the OSI model's Application, Presentation, and Session layers.
- **Transport Layer:** Corresponds to the OSI model's Transport layer.
- **Internet Layer:** Corresponds to the OSI model's Network layer.
- **Link Layer:** Corresponds to the OSI model's Data Link and Physical layers.

The [[Networks/TCP]]/[[IP]] model is more practical and widely used in real-world networking, especially on the Internet, while the OSI model is more of a theoretical framework.
![[Pasted image 20240717105714.png]]
![[Pasted image 20240717111652.png]]