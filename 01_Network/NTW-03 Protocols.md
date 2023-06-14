# [Subject]
[Geef een korte beschrijving van het onderwerp]

### Key-terms
- **ARP** Adress Resolution Protocol. 

### Used Sources
https://www.wireshark.org/docs/wsug_html/
https://www.youtube.com/watch?v=-rSqbgI7oZM (NetworkChuck)
https://www.geeksforgeeks.org/application-layer-in-osi-model/  
https://www.geeksforgeeks.org/presentation-layer-in-osi-model/  
https://www.geeksforgeeks.org/session-layer-in-osi-model/  
https://www.geeksforgeeks.org/transport-layer-responsibilities/  
https://www.geeksforgeeks.org/difference-between-network-layer-protocols-and-application-layer-protocols/  
https://www.geeksforgeeks.org/examples-of-data-link-layer-protocols/  
https://www.techopedia.com/definition/24961/osi-protocols  
https://www.comptia.org/content/guides/what-is-a-network-protocol  
https://www.comptia.org/content/articles/what-is-wireshark-and-how-to-use-it  



## Assignment
- Identify several other protocols and their associated OSI layer. Name at least one for each layer.
- Figure out who determines what protocols we use and what is needed to introduce your own protocol.
- Look into wireshark and install this program. Try and capture a bit of your own network data. Search for a protocol you know and try to understand how it functions


## Results
### Identify protocols
#### Physical layer protocols
- **TelNed** is a Tele Communications Protocol, is used to facilitate communication between two hosts using the CLI. Port:23.  
- **DNS** is Domain name system, is used to translate domain names to their corresponding IP address. Port:53.
- **DHCP** is a Dynamic Host Configuration Protocol, is used to provive IP addresses to hosts. Port:67 and 68.
- **FTP** is a File Tranfer Protocol, its used to download, upload and transfer files between two devices over the internet. Port:20(Data) and Port:21(Control)
- **TFTP** is a lightweight FTP, is mainly used to reading and writing files to or from a remote server. Port:69. 
- **SMTP** is a Simple Mail Transfer Protocol, its necessary for the completion of email-related jobs. Port:25. 
- **HTTP** is a Hyper Text Transfer Protocol, its the foundation of the WorldWideWeb. It is a client server model. Port:80.
- **NFS** is a Network File System, is mainly used to share files remotely between servers of a network. Its portable across different machines, OS, network architectures and transport protocols. Port:2049
- **SNMP** is a Simple Network Management Protocol, is mainly used to gather data by polling the device from the network to the management station on a fixed or random interval. Port:161(TCP) or Port:162(UDP).

#### Presentation layer protocols  
- **AFP** is Apple Filing Protocol and is the proprietary network protocol for macOS. Basicly the network file control protocol. 
- **LPP** is Lightweight Presentation Protocol, its the used to provide ISO presentation services on the top of the TCP/IP based protocol stack.
- **NCP** is NetWare Core Protocol, its the network protocol wich is used to access file,print,directory, clock sync, messaging, remote command execution and other network service functions.
- **NDR** is Network Data Respresentation, its basiclly the implementation of the present layer in the OSI model. Which provides or defines various primitive data types, constructed data types and also several types of data representation.
- **XDR** is External Data Representation, its the standard for description and encoding of data. Its usefull for tranferring data between diffrent computer architectures and machines. Local -> XDR = encoding, XDR -> Local = decoding. 
- **SSL** is Secure Socket Layer protocol, its used to provide security to the data dat is being transffered between web browser and server. SSL encrypts the link between a web server and webbrowser. 

#### Session layer protocols  
- **ADSP**
- **RTCP**
- **PPTP**
- **PAP**
- **RPCP**
- **SDP**

#### Transport layer protocols   
- **TCP**
- **UDP**
- **SCTP**
- **DCCP**
- **ATP**
- **FCP**
- **RDP**
- **RUDP**
- **SST**
- **SPX**

#### Network layer protocols
- **IP**
- **ICMP**
- **ARP**
- **RIP**
- **OSPF**

#### Data link layer protocols
- **SDLC**
- **HDLC**
- **SLIP**
- **PPP**
- **LCP**
- **LAP**
- **NCP**

#### Physical layer protocols
- **Bluetooth**
- **PON**
- **OTN**
- **DSL**
- **IEEE.802.11**
- **IEEE.802.3**
- **L431**
- **TIA 449**   

### Who determines what protocols we use?
These are the institues that create standards.
- **The Institute of Electrical and Electronics Engineers (IEEE)** It develops consensus standards through an open process that engages industry and brings together a broad stakeholder community.  
- **The Internet Engineering Task Force (IETF)** In the most simple terms, the primary work of the IETF is to ensure that the internet works better. The organization does this by creating relevant and high-quality technical documents that can change how everyone uses, designs and manages the internet.
- **The International Telecommunications Union (ITU)**  promotes the shared global use of the radio spectrum, facilitates international cooperation in assigning satellite orbits, assists in developing and coordinating worldwide technical standards, and works to improve telecommunication infrastructure in the developing world.
- **The World Wide Web Consortium (W3C)** an international community where Member organizations, a full-time staff, and the public work together to develop Web standards

Then the ISO standarizes the standards. 
- **The International Organization for Standardization (ISO)** an independent, non-governmental organization that develops standards to ensure the quality, safety and efficiency of products, services and systems.

### Wireshark
Wireshark is a safte tool to troubleshoot network issues. It is also a good learning tool for new network/cloud engineers. You can use it to understand network traffic analysis, how communication takes place when protocols are involved and where it goes wrong where certain issues occur. 

Default color codes problems:
- Light purple = TCP
- Light blue = UDP
- Black = Packets with errors
- Light green = HTTP traffic
- Light yellow = Windows-specific traffic
- Dark yellow = Routing
- Dark gray = TCP SYN, FIN and ACK traffic

TCP uses a three-way handshake to establish a reliable connection. The connection is full duplex, and both sides synchronize (SYN) and acknowledge (ACK) each other.

![!Screenshot](../00_includes/NTW-01/tcp-threeway-handshake.jpg)

A recoding I made:
![Screenshot wireshark](../00_includes/NTW-01/wireshark_testing.jpg)

The line I selected shows a few things:
- **bytes on wire** physical layer tranfering data.
- **bytes caputerd** on a loopback NPF(firewall).
- **IPV4** goes from localhost to localhost a loopback.
- **TCP** sended data from a dynamic/private port to an other dynamic/private port.

## Encounterd problems

