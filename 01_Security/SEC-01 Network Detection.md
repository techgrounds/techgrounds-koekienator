# [Network detection]
How to detect what happens on your network?

### Key-terms
https://www.geeksforgeeks.org/nmap-command-in-linux-with-examples/  


### Used Sources
- Scan the network of your Linux machine using nmap. What do you find?
- Open Wireshark in Windows/MacOS Machine. Analyse what happens when you open an internet browser. (Tip: you will find that Zoom is constantly sending packets over the network. You can either turn off Zoom for a minute, or look for the packets sent by the browser between the packets sent by Zoom.)

## Assignment
### Nmap on Linux
Nmap is used for network exploration and security auditing. 
- Realtime information about a network
- Detailed information of all IPs activated in your network
- Number of ports in a network
- Provide a list of active hosts
- Port, OS and host scanning.

Here I used namp on my own IP. I see there are two ports in use 22 for SSH and 80 for HTTP.
![Screenshot nmap self](../00_includes/SEC-01/nmap_self.jpg)

Can also see it for all other class mates by replacing the last octat with *. With nmap -sS I can scan for TCP open ports. Here are my teammates. 

![Screenshot Kaman](../00_includes/SEC-01/nmap_kam.jpg)
![Screenshot Vincent](../00_includes/SEC-01/nmap%20vin.jpg)
![Screenshot Jordan](../00_includes/SEC-01/nmap-jor.jpg)



## Results

## Encountered problems

