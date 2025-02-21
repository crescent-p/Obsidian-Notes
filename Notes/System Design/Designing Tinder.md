# Objectives
	1) Store profiles (Images will be stored, Images per user)
	2) Recommend matches
	3) Note matches
	4) Direct messaging

	- Start with ER Diagram?
	- Start from front to back
		- think about users and what they need and build from there
## How to store images?
	- as a file or as a blob (binary large object)
	- Database offeres mutability (editable), transaction guarentees, indexing (to improve search), access control
			- mutability and ACID properites is not needed for images
			- image updates are as a whole so no need for mutability
			- image upload are atomic, no need for ACID
			- indexing, images are not searched based on content, rather on their name.
			- access control is a necessary feature though
		- Files
			- cheaper
			- faster in a way. 
			- avoids select * everything nightmare
			- CDN can be built around this
## Storing profiles
```mermaid
flowchart LR
PHONE --> |"Sends request"| server
```
	- authentication
		- profiles need to verified by the server side.
		- should you keep verification in same server as profile services?
			- NO, because then it leads to duplication of code. 
				- when you add a new service, that will also need authentication, so you end writing verification code for each new service you create
				- better way is to create a gateway that talks to all the servicess and authenticates the client
				- client only talks to the gateway, 
					- gateway then authenticates and forwars the requests to the machines.
## Direct messaging
	- should use peer to peer connections like XMPP (Extensible Messaging and Presence Protocol) rather than a server client connection like HTTP
	- 