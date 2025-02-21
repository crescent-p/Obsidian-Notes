# Setup
	1) setup virtual machines
		1) add 3 machines, ssh_from, ssh_to, and a MIM machine (man in the middle)
		2) add all machine to internal network.
		3) Before changing to internal network. Make sure to download all the packages with NAT in network settings.
		4) ssh machines should have wireshark and net-tools installed, and ssh as well
			1) sudo apt install ssh
			2) sudo sytemctl enable ssh
			3) sudo systemctl start ssh
		5) attack machine needs hping3 installed
	2) Setting up network
		1) all need to be in internal network
		2) then go to /etc/netplan/01-network-manager-all and edit it to look like this. This creates a static ip address

```C
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.2.3/24 //use different ip for each machine.
      gateway4: 192.168.2.1
```
	3) After setting the static ip addersses run 'sudo netplan apply' to apply the changes
	4) Also at this stage make sure network adapter is set to internal network.
	5) try pinging all the ip addresse you set from a machine to check if everything is working
		1) ping 192.168.2.(2 - 4)


`ip a` to view the network settings
## SSH from Alice to Bob
	`ssh username@ipaddress` 
	- Now you have established a TCP connection from machine a to machine b.
	- Use wireshark to see the captured packets and there sequence numbers.
	- Note down the latest sequence numbers.
```C
#sudo hping3 -c 1 -V -S -p <TARGET_PORT> -a <SOURCE_IP> --rst <DEST_IP>
sudo hping3 -R -p 22 -a --seqnum <NUM> <server_ip> <client_ip>
````

## Network options in virtual machine
### NAT (Network address translation)
	VM shares the ip address of the host and access internet as a local client behind NAT. VM is not directly exposed to the internet.
### Bridget Networking
	VM gets a separate ip addresss than the host from the same DHCP server. VM is directly addressible from outside the host, making it exposed. 
	VM appears as another physical device that can commnunicate between other devices on the internet.
### Host-only Network
	VM gets a private ip that only host and other VM's can access. VM is not exposed to internet or outside the host.
### Internal Network
	VM can only communicate between other VM's on the host. Host can't communicate with VM.
