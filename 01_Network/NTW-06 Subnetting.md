# [Subject]
[Geef een korte beschrijving van het onderwerp]

### Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

### Used Sources
https://www.networkworld.com/article/3588315/what-is-an-ip-address-and-what-is-your-ip-address.html  
https://www.learncisco.net/courses/icnd-1/lan-connections/network-addressing-scheme.html


## Assignment

## Results
### What is Subnetting and Subnetmasks.
IP addresses work hierarchial. In general, the numbers to the left tell you what network the device with that IP adress is on and to the right specifies the device. However the IP doesn't define where the diving line is. In addition some of the bits in an adress may be used to identify a subnetwork or subnet. 

The IP address is divided in 4 segments of 8 bits (octet). Routers determine what parts of the IP is refered to the network, subnet and devices. 

There are 3 different possible subnets.
- Class A network:  
-- Subnetmask 255.0.0.0  
-- IP range 0-127.0.0.0  
-- Up to 126^1 Networks  
-- Up to 254^3 Hosts  
-- Default prefix lenght /8  
- Class B network:   
-- Subnetmask 255.255.0.0  
-- IP range 128-191.0.0.0  
-- Up to 126^2 Networks  
-- Up to 254^2 Hosts  
-- Default prefix lenght /16  
- Class B network:  
-- Subnetmask 255.255.255.0  
-- IP range 192-223.0.0.0  
-- Up to 126^3 Networks  
-- Up to 254^1 Hosts   
-- Default prefix lenght /24  

![Screenshot subnetting](../00_includes/NTW-01/subnetting_layers.png)
![Screenshot subnetting id](../00_includes/NTW-01/subnetting_id.png)
![Screenshot subnetting example](../00_includes/NTW-01/subnetting_examples.jpg)


### How to calculate a subnet.
As stated before there is network and host within an IP. Subnetting is nothing more than a borrowing system. 

First we make our subnet in to binary.
```
255.255.255.0

11111111.11111111.11111111.00000000
```
From here we can calculate the subnetmask. We use the binary * 2 for this.
```
256 128 64 32 16 8 4 2
```
We need 30 hosts (+2 extra for  )

## Encounterd problems
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]
