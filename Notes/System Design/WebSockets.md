WebSockets are a protocol for full-duplex communication channels over a single, long-lived connection, which allows for real-time, bidirectional communication between a client (usually a web browser) and a server. This is different from the traditional HTTP request-response model, where the client initiates requests and the server responds.

### Key Features of WebSockets:

1. **Full-Duplex Communication**:
   - WebSockets enable simultaneous two-way communication between the client and server. Both parties can send messages independently without waiting for the other to respond.

2. **Single, Persistent Connection**:
   - After the initial handshake, a WebSocket connection remains open, allowing for continuous communication. This avoids the overhead of repeatedly opening and closing connections.

3. **Low Latency**:
   - WebSockets reduce latency by maintaining a persistent connection, which is ideal for real-time applications where timely data exchange is crucial, such as chat applications, live sports updates, or online gaming.

4. **Protocol Upgrade**:
   - WebSockets use the HTTP protocol for the initial handshake, upgrading the connection to the WebSocket protocol. This handshake ensures compatibility with existing HTTP infrastructure.

5. **Message Framing**:
   - Messages sent over a WebSocket connection are framed, which means they can be sent in multiple parts or "frames" if needed, allowing for more efficient data transmission.

### How WebSockets Work:

1. **Handshake**:
   - The client initiates a connection to the server using an HTTP request with an `Upgrade` header indicating that it wants to switch to the WebSocket protocol.
   - The server responds with a status code indicating acceptance, and the connection is upgraded from HTTP to WebSocket.

2. **Data Transfer**:
   - Once established, data can be sent in both directions over the WebSocket connection without additional handshakes or headers.

3. **Closing**:
   - Either the client or server can close the connection by sending a close frame. The other party acknowledges this frame, and the connection is terminated gracefully.

### Example Use Cases:

- **Real-Time Chat Applications**: WebSockets allow users to send and receive messages instantly.
- **Live Updates**: Applications that display real-time information, such as stock prices or sports scores, benefit from WebSocket's ability to push updates to clients as soon as they occur.
- **Online Games**: Games requiring frequent updates to maintain real-time interaction between players use WebSockets for smooth gameplay experiences.

### WebSocket API in JavaScript:

Here is a simple example of using WebSockets in a web application:

```javascript
// Create a new WebSocket connection
const socket = new WebSocket('ws://example.com/socketserver');

// Event handler for when the connection is opened
socket.onopen = function(event) {
    console.log('WebSocket connection established');
    // Send a message to the server
    socket.send('Hello, Server!');
};

// Event handler for when a message is received from the server
socket.onmessage = function(event) {
    console.log('Message from server:', event.data);
};

// Event handler for when the connection is closed
socket.onclose = function(event) {
    console.log('WebSocket connection closed');
};

// Event handler for errors
socket.onerror = function(error) {
    console.error('WebSocket error:', error);
};
```

### WebSocket Protocol:

- **URL Scheme**: `ws://` for unencrypted connections and `wss://` for encrypted (secure) connections.
- **Port**: Typically 80 for `ws://` and 443 for `wss://`, similar to HTTP and HTTPS.

WebSockets are a powerful tool for real-time web applications, offering significant improvements over traditional polling and HTTP-based communication methods.