# Network Commands
## 1) ping 
	Switches :- 
		 -c [count] (Linux): Specify the number of pings to send.
		 -n [count] (Windows): Number of echo requests to send.
		 -i [interval] (Linux): Set the interval between packets.
		 -t (Windows): Ping until stopped manually.
		 -w [timeout]: Time to wait for a response (Linux & Windows).	

##### What is an echo request ?
- **Echo Request**: When you run `ping`, your computer sends an **ICMP Echo Request** (Internet Control Message Protocol ) packet to the target device (e.g., `www.google.com`).
- **Echo Reply**: If the target device is reachable, it responds with an **ICMP Echo Reply** packet.
- **Result**: The `ping` tool calculates the time it took to receive the reply and reports the results, including round-trip time, packet loss, and network statistics.
### Key Differences Between Ping and Echo: 

| Feature           | **Echo**                               | **Ping**                           |
| ----------------- | -------------------------------------- | ---------------------------------- |
| **Definition**    | ICMP message type (echo request/reply) | Utility that sends echo requests   |
| **Protocol**      | Part of ICMP protocol                  | Uses ICMP protocol                 |
| **Functionality** | Basic message to test reachability     | Comprehensive tool for diagnostics |
| **Output**        | No direct output                       | Reports latency, packet loss, etc. |
| **Example**       | ICMP Echo Request/Reply                | `ping www.example.com`             |

## **2. traceroute (Linux)**

Traces the route packets take to reach a destination.

**Common switches**:

- `-d`: Do not resolve hostnames (Linux & Windows).
- `-h [max_hops]`: Set maximum hops (Linux & Windows).
- `-n` (Linux): Display numeric addresses instead of hostnames.
- `-w [timeout]`: Timeout for each reply in milliseconds (Linux & Windows).

```python
'crescent-p@Crescent-P-Laptop':~$ traceroute www.google.com
traceroute to www.google.com (142.250.196.4), 30 hops max, 60 byte packets
 1  Crescent-P-Laptop.mshome.net (192.168.144.1)  0.292 ms  0.275 ms  0.270 ms
 2  dsldevice.lan (192.168.1.1)  7.163 ms  7.153 ms  7.105 ms
 3  110.225.132.1 (110.225.132.1)  7.081 ms  7.066 ms  7.050 ms
 4  182.66.79.161 (182.66.79.161)  7.029 ms  6.997 ms 182.66.79.157 (182.66.79.157)  6.948 ms
 5  116.119.158.147 (116.119.158.147)  17.746 ms 182.79.142.222 (182.79.142.222)  24.053 ms 116.119.57.102 (116.119.57.102)  18.399 ms
 6  142.250.169.206 (142.250.169.206)  18.919 ms  19.904 ms  19.896 ms
 7  * * *
 8  74.125.253.12 (74.125.253.12)  15.432 ms 142.251.60.184 (142.251.60.184)  17.053 ms 142.251.55.60 (142.251.55.60)  17.437 ms
 9  142.251.55.43 (142.251.55.43)  20.089 ms 172.253.70.166 (172.253.70.166)  21.446 ms 142.251.55.43 (142.251.55.43)  21.544 ms
10  142.250.239.229 (142.250.239.229)  20.115 ms maa03s44-in-f4.1e100.net (142.250.196.4)  18.084 ms  18.071 ms
"Star means package server didn't send a traceroute reply to client, mainly for security reasons"
"multiple ips at hopes 4 5 8 9 10 indicate load balancing for the 3 packets that were sent"
```

## IP
**ip (Linux)**:

- `ip addr`: Show all IP addresses.
- `ip link`: Display link-layer information.
- `ip route`: Show routing table.
## DIG ( Domain Information Groper )
```c
'crescent-p@Crescent-P-Laptop':~$ dig www.google.com

; <<>> DiG 9.18.28-0ubuntu0.22.04.1-Ubuntu <<>> www.google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49620
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.google.com.                        IN      A

;; ANSWER SECTION:
www.google.com.         1       IN      A       142.250.196.4

;; Query time: 9 msec
;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
;; WHEN: Mon Jan 06 22:12:01 IST 2025
;; MSG SIZE  rcvd: 59
```