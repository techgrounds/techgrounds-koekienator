# [Azure Virtual Network (VNet)]

How do VNs work within Azure?

## Assignment

- Create a VN with 2 subnets, subnet1 no internet access
- Create a VM, attach it to subnet 2 with public IP, no SSH

### Key-terms

- NSG
- VN

### Used Sources

![Az8 Firewalls](../02_Cloud_1/AZ-08%20Firewalls.md)

## Results

### What is a Virtual Network?

A VN is a emulated network in this case in Azure. This is used to let VMs, Web app and databases communicated with each other, other users or the internet.  

VNs got different responsibilities:

- Isolation and segmentation of a network
- Internet communication
- Communication between the Azure resources
- Communication with on-premises resources
- Routing network traffic
- Filtering network traffic
- Connecting to other VN

Within a VN you can create subnets within your own private IP range.
There are three ways to connect to a on-premises network. 

- Point-to-Site VPN:  
-- The Azure VN can be reached with a VPN from a on-premise computer.  
- Site-to-Site VPN:  
-- The on-premises VPN device or gateway is used to connect to the Azure VPN gateway. This is effectively 1 big network.
- Azure Express route:  
-- This is a physical connection from you local environment to Azure.  

It's also possible to connect to Azure VN to each other with VN Peering. This can be done via UDR, user defined routing. It can be used for VN in different regions.

### Assignment 1

We create a new VN, search VN in the search bar and select Virtual Network.  
Here we can create a VN ``+create``.  

Select our own resource group and name the VN: ``Lab-Vnet``  
IP address tab we want a IPv4 address space.  

- VN 10.0.0.0/16  
-- subnet1 10.0.0.0/24  
-- subnet2 10.0.1.0/24  

Now we can review + create the VN.  
We create two new NSG for each of our networks with different rule sets.  

NSG-Lab-Vnet-Subnet1:  

- Range 10.0.0.0/24
- Connected to Subnet1
- Disabled outbound HTTP & HTTPS

NSG-Lab-Vnet-Subnet2  :

- Range 10.0.1.0/24
- Connected to Subnet2

### Assignment 2

Create a new VM attached it to subnet2.

NSG-Lab-Vnet-Subnet2:

- Disabled inbound and outbound, SSH
- Enabled outbound HTTP & HTTPS

## Encountered problems

No, it was identical to assignment 8 as far as I could tell. 