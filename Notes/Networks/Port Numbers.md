[[Port numbers]] are numerical identifiers used in [[networking]] to distinguish different services and applications running on a single device. They range from 0 to 65535 and are divided into three main categories:

1. **Well-Known Ports (0-1023):**
   - These ports are assigned to commonly used protocols and services. Examples include:
     - HTTP (Port 80)
     - HTTPS (Port 443)
     - FTP (Port 21)
     - SSH (Port 22)

2. **Registered Ports (1024-49151):**
   - These ports are assigned by the Internet Assigned Numbers Authority (IANA) to specific applications and services that are not as universally recognized as those in the Well-Known range. Examples include:
     - MySQL (Port 3306)
     - PostgreSQL (Port 5432)
     - Microsoft SQL Server (Port 1433)

3. **Dynamic or Private Ports (49152-65535):**
   - These ports are not assigned to any specific service and can be used dynamically by applications for temporary communication channels. They are often used for ephemeral ports, which are short-lived ports used for client-side communications.

### Key Concepts

- **Port Addressing:**
  - Ports allow a single IP address to support multiple communication sessions simultaneously. Each session is identified by a unique combination of [[IP]] address and port number.

- **Transport Layer Protocols:**
  - Port numbers are used by transport layer protocols like [[TCP]] (Transmission Control Protocol) and UDP (User Datagram Protocol) to direct traffic to the appropriate application.
  - TCP is connection-oriented and ensures reliable data transfer.
  - [[UDP]] is connectionless and faster but does not guarantee delivery.

- **Firewalls and Security:**
  - Firewalls use port numbers to control access to and from a network. Blocking or allowing traffic on specific ports can help secure a network.
  - Commonly attacked ports, like those used by certain services, are often monitored or restricted to prevent unauthorized access.

Understanding port numbers is crucial for network administration, security, and troubleshooting, as they help manage and secure the flow of data between devices on a network.