An [[IP]] (Internet Protocol) address is a unique numerical identifier assigned to each device connected to a network that uses the Internet Protocol for communication. IP addresses are used to identify devices and facilitate the routing of data between them over a network, including the internet.

### Types of IP Addresses

There are two main versions of IP addresses: IPv4 and IPv6.

#### IPv4 (Internet Protocol version 4)

1. **Format**: IPv4 addresses are 32-bit numbers, typically represented in decimal format as four octets (8-bit bytes) separated by periods (e.g., 192.168.1.1).
2. **Address Space**: IPv4 provides approximately 4.3 billion unique addresses.
3. **Example**: 192.168.0.1

#### IPv6 (Internet Protocol version 6)

1. **Format**: IPv6 addresses are 128-bit numbers, represented in hexadecimal format as eight groups of four hexadecimal digits separated by colons (e.g., 2001:0db8:85a3:0000:0000:8a2e:0370:7334).
2. **Address Space**: IPv6 provides a vastly larger address space than IPv4, allowing for a virtually unlimited number of unique addresses.
3. **Example**: 2001:0db8:85a3:0000:0000:8a2e:0370:7334

### Types of IP Addressing

1. **Public IP Addresses**: These are assigned to devices that are directly connected to the internet. Public IP addresses are unique across the entire internet.
   
2. **Private IP Addresses**: These are used within private networks (e.g., home, office) and are not routable on the internet. Common private IP address ranges include:
   - 10.0.0.0 to 10.255.255.255
   - 172.16.0.0 to 172.31.255.255
   - 192.168.0.0 to 192.168.255.255

3. **Static IP Addresses**: These are permanently assigned to a device and do not change over time.

4. **Dynamic IP Addresses**: These are temporarily assigned to a device and can change over time. Dynamic IP addresses are typically assigned by DHCP (Dynamic Host Configuration Protocol) servers.

### Functions of IP Addresses

1. **Identification**: IP addresses uniquely identify devices on a network, allowing them to be located and communicated with.
   
2. **Routing**: IP addresses are used by routers to determine the best path for data to travel from the source to the destination across interconnected networks.

### Subnetting and CIDR

1. **Subnetting**: Subnetting divides a larger network into smaller sub-networks (subnets), improving network management and security. Each subnet has its own unique subnet mask that defines the network and host portions of the IP address.
   
2. **CIDR (Classless Inter-Domain Routing)**: CIDR is a method for allocating IP addresses and routing that replaces the old system of classful addressing. CIDR notation (e.g., 192.168.1.0/24) includes the IP address and the prefix length, which indicates the number of bits used for the network portion.

### NAT (Network Address Translation)

NAT is a method used to remap private IP addresses to a public IP address. This allows multiple devices on a private network to share a single public IP address for accessing the internet, conserving public IP addresses and adding a layer of security.

### Example of IP Address Usage

When you enter a URL in your web browser, the following process occurs:

1. **DNS Resolution**: The Domain Name System ([[DNS]]) translates the human-readable domain name (e.g., www.example.com) into an IP address (e.g., 93.184.216.34).
2. **Routing**: Routers use the IP address to route the data packets from your device to the web server hosting the website.
3. **Data Transmission**: The web server sends the requested web page back to your device using your IP address, completing the communication.

In summary, IP addresses are fundamental to network communication, enabling the identification, location, and routing of devices across networks, including the vast and interconnected internet.


## ==If all the devices on a private network has the same public IP address how are they differentiated?==

If all devices on a single network had the same IP address, it would create significant network issues, such as IP address conflicts, making it impossible for devices to communicate effectively. Each device on a network must have a unique IP address to facilitate proper routing and communication. However, devices on the same network use other identifiers to differentiate between each other. Here's how devices on a single network differentiate themselves:

### 1. [[MAC]] Addresses (Media Access Control Addresses)

**MAC Address:**
- Each network interface card (NIC) has a unique MAC address assigned by the manufacturer. MAC addresses are 48-bit identifiers, usually represented in hexadecimal format (e.g., 00:1A:2B:3C:4D:5E).
- MAC addresses operate at the Data Link Layer (Layer 2) of the OSI model and are used for local network communication within the same subnet.

**Address Resolution Protocol (ARP):**
- ARP is used to map IP addresses to MAC addresses within a local network. When a device knows the IP address it wants to communicate with, it uses ARP to find the corresponding MAC address.
- Example: If device A wants to communicate with device B and knows B's IP address, it sends an ARP request asking, "Who has IP address X?" Device B responds with its MAC address.

### 2. Switches and MAC Address Tables

**Switches:**
- Switches are networking devices that use MAC addresses to forward data frames to the correct destination within a local network.
- Each switch maintains a MAC address table (also called a CAM table) that maps MAC addresses to specific ports on the switch.

**Forwarding Data:**
- When a switch receives a data frame, it examines the destination MAC address and forwards the frame to the corresponding port based on its MAC address table.
- This ensures that the frame reaches the intended device without broadcasting it to all devices on the network.

### 3. Unique IP Addresses Within a Subnet

**IP Address Assignment:**
- Within a single subnet, each device is assigned a unique IP address to ensure there are no conflicts.
- IP addresses can be assigned statically (manually) or dynamically using DHCP (Dynamic Host Configuration Protocol).

**Subnetting:**
- Networks are divided into smaller subnets to manage and allocate IP addresses more efficiently.
- Subnet masks define the range of IP addresses within a subnet, ensuring that each device within the subnet has a unique IP address.

### 4. Network Address Translation (NAT) for Public and Private IP Addresses

**Private IP Addresses:**
- Devices within a private network (e.g., a home or corporate network) typically use private IP addresses defined by RFC 1918 (e.g., 192.168.x.x, 10.x.x.x, 172.16.x.x).

**Public IP Addresses:**
- When devices need to communicate with the outside world (the internet), NAT is used to translate private IP addresses to a public IP address.
- A router with NAT functionality assigns a unique port number to each internal device, allowing multiple devices to share a single public IP address while keeping their internal IP addresses distinct.

### Summary

Devices on a single network differentiate themselves primarily using unique MAC addresses and IP addresses. MAC addresses ensure unique identification at the data link layer, while IP addresses provide unique identification at the network layer. Switches and routers use these addresses to route data correctly within local and wider networks, respectively. Proper assignment and management of IP addresses, along with protocols like ARP and NAT, ensure smooth and conflict-free communication among devices.