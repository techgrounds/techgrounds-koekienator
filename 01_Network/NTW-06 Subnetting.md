# [Subject]
[Geef een korte beschrijving van het onderwerp]

### Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

### Used Sources
https://www.networkworld.com/article/3588315/what-is-an-ip-address-and-what-is-your-ip-address.html  


## Assignment

## Results
### What is Subnetting and Subnet masks.
IP addresses work hierarchial. In general, the numbers to the left tell you what network the device with that IP adress is on and to the right specifies the device. However the IP doesn't define where the diving line is. In addition some of the bits in an adress may be used to identify a subnetwork or subnet. 

The IP address is divided in 4 segments of 8 bits (octet). Routers determine what parts of the IP is refered to the network, subnet and devices. 
![Screenshot subnetting](../00_includes/NTW-01/subnetting_layers.png)
![Screenshot subnetting id](../00_includes/NTW-01/subnetting_id.png)



### How to calculate a subnet.
First we make our subnet in to binary.
```
255.255.255.0

11111111.11111111.11111111.00000000
```
From here we can calculate the subnetmask. We use the binary * 2 for this.
```
256 128 64 32 16 8 4 2
```
We need 30 hosts (+2 extra for )

## Encounterd problems
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]
