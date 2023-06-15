# [OSI STACK]
[Geef een korte beschrijving van het onderwerp]

### Key-terms
OSI

### Gebruikte bronnen
https://www.cloudflare.com/learning/ddos/glossary/open-systems-interconnection-model-osi/  
https://www.youtube.com/watch?v=0y6FtKsg6J4 (ByteByteGo)  
https://www.youtube.com/watch?v=CRdL1PcherM (Network Chuck)  
https://www.iso.org/about-us.html  
https://www.comparitech.com/net-admin/ultimate-guide-tcp-ip/  

## Opdracht
- Study OSI model and its uses.
- Study TCP/IP model and its uses.

## Resultaat
### OSI Model
The OSI model or Open System Interconnection is a conceptual model created by ISO (International Organisation of Standardization.). This was created to let different OSes communicate with each other.

We can see this model as a universal language for computer networking. It is as simple as splitting up the communication in 7 abstract layers.

Nowadays TCP/IP is the default protocol as it is a simpler version than OSI. However OSI is still used to break down problems and isolate its source. In that case more layers is a better isolation of the problem.

### THE 7 LAYERS  
Each layer has a specific job to do and can only communicate with the layer above or below itself.
![Screenshot OSI 7 Layers](../00_includes/NTW-01/osi_model_7_layers.png)
#### LAYERS 7: The application layer   
This is the only layer to directly interact with the user's data input. It controls the protocols and data manipulation so the user can see meaning full data.

Example application layer protocols:  
- HTTP: HyperText Transfer Protocol  
- FTP: File Transfer Protocol   
- POP: Post Office Protocol  
- SMTP: Simple Mail Transfer Protocol  
- DNS: Domain Name System   

![Screenshot layer 7](../00_includes/NTW-01/osi_model_application_layer_7.jpg)

#### LAYER 6: The presentation layer  
This layer will prepare data so it can be presented in the application layer. It will translate, encrypt and compress data.

Translation: Put encrypted data in a readable syntax for layer 7.
Encrypt: decode and encrypt data for save data transfer.
Compressing: Compress data for optimized speed and efficiency to communicate with layer 5.

![Screenshot layer 6](../00_includes/NTW-01/osi_model_presentation_layer_6.jpg)

#### LAYER 5: The session layer  
This layer opens and closes communication between two devices. The time between opening and closing is a session. It is in control to efficiently make sessions for data transfer.

Synchronization takes place here as well via checkpoints. Example a 50mb file will be checked every 2mb. When a connection is lost, this could be a disconnect. It can restart the session at 22mb/ 50mb instead of starting over again.

![Screenshot layer 5](/00_includes/NTW-01/osi_model_session_layer_5.jpg)

#### LAYER 4: The transport layer  
This layer does the end-to-end communication between two devices. It grabs data from the session layer and sends it in segments to the network layer. The receiving devices will reassemble the segments from the network layer and ensemble it again so it can send it to the session layer.

It's also in charge of managing the flow control and error control for the inter-network. Flow control will mediate the between connections, so a high speed connection won't overflow a slow connection. Error control makes sure all data received is complete and it will request retransmission for missing if necessary.

Example transport layer protocols:
- TCP: Transmission Control Protocol
- UDP: User Datagram Protocol

![Screenshot layer 4](/00_includes/NTW-01/osi_model_transport_layer_4.jpg)

#### LAYER 3: The network layer  
This layer is responsible for facilitation of data transfer between networks. If the devices communicate via the same network this layer isn't necessary.

The network layer makes the received segments even smaller to packets, on the sender's side. For the receiving device it reasables the packages to segments.

It will find the best physical path for data to reach its destination. This is routing.

Example network layer protocols:
- IPv4: Internet Protocol version 4
- IPv6: Internet Protocol version 6
- ICMP: Internet Control Message Protocol
- IGMP: Internet Group Message Protocol

![Screenshot layer 3](../00_includes/NTW-01/osi_model_network_layer_3.jpg)

#### LAYER 2: The data link layer  
This layer is very similar to the Network layer but it's for data transfer between two devices on the same network. Here the packets from the network layer are made into smaller pieces called frames.

It also does flow and error control for the intra-network.

![Screenshot layer 2](../00_includes/NTW-01/osi_model_datalink_layer_2.jpg)

#### LAYER 1: The physical layer  
This layer includes all physical equipment involved in the data transfers. Here data will be translated to bits (base-2 language, only 1's and 0's). Both devices need to agree on a signal convention, so 1 and 0 can be distinguished.

Example equipment (electrical, mechanical, radio):
- Ethernet Cables (connectors)
- Switches
- Hubs
- Repeaters

![Screenshot layer 1](../00_includes/NTW-01/osi_model_phyisical_layer_1.png)

#### DATA FLOW  
![Screenshot OSI dataflow](../00_includes/NTW-01/osi_data_flow.jpg)

### TCP/IP
This was the original protocol that enabled the internet. It had 4 layers, Application, Transport, Network and Network interface. The official name was Internet Protocol Suite.

OSI expanded this by adding more layers and creating an even greater abstraction that is used today mainly for troubleshooting as TCP/IP is still more popular.

![Screenshot OSI vs TCP/IP](../00_includes/NTW-01/osi_vs_tcpip.jpg)


## Encountered problems
It was a lot of reading, but the basics were easy to understand.



