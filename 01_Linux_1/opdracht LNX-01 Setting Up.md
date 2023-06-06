# [Settings up cloud VM connectie]
Hoe kan ik een verbindinging maken met een VM in de cloud?

## Key-terms
- **OS** of Operating System is jouw besturingssysteem. Bij mij is het momenteel Windows.
- **VM** of Virtual Machine is software die een OS simuleerd in de cloud of op jouw eigen computer.
- **Linux** is een gratis open source OS gebaseerd op de Unix besturingsystemen. 
- **Cloud** is in het kort een online opslag die overal ter wereld berijkbaar is via internet.
- **SSH** of Secure Socket Shell is een netwerk communicatie protocol zodat er tussen twee computers gecommuniceerd kan worden. 
- **Key File** is een geencrypte sleutel. 
- **CLI** is command line interface om commandos te geven aan jouw OS. 
- **GUI** is graphical user interface is de gebruiksvriendelijke versie van CLI. Windows is hier een goed voorbeeld van. Je kan met muis en toetsenbord alles bedienen i.p.v. alleen met commandos. 
- **PowerShell** is een moderne opdrachtshell zoals DOS



# Opdracht
### Gebruikte bronnen 
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/openssh.html  
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html#AccessingInstancesLinuxSSHClient  

# Resultaat
## Heb ik de benodigtheden om te beginnen met een SSH connectie?  
### Is Windows PowerShell geinstalleerd en up-to-date?     
Open Windows Powershell. Dit doe je altijd als ***administrator***  

![Screenshot Windows Powershell](../00_includes/LNX-01%20Setting%20Up/PowerShell-StartScherm.jpg)

Eerst kijken wij of er al een installatie is.  
```
 winget search Microsoft.PowerShell 
 ```  

![screenshot Windows Powershell laatste versie](../00_includes/LNX-01%20Setting%20Up/PowerShell-Laatste-Versie.jpg) 

Daarna gaan wij beide versies downloaden en updaten  
``` 
winget install --id Microsoft.Powershell --source winget 
```  
``` 
winget install --id Microsoft.Powershell.Preview --source winget 
```  
Zelf had ik de preview versie nog niet.  
![screenshot Windows Powershell update](../00_includes/LNX-01%20Setting%20Up/PowerShell-Update.jpg) 

### Heb ik OpenSSH geinstalleerd en is het up-to-date?  
Open Windows PowerShell en typ je de volgende command om te controleren of OpenSSH geinstalleerd is.  
``` 
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*' 
```

![screenshot Is OpenSSH Geinstalleerd?](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Geinstalleerd.jpg) 

Als bij state *NotPresent* staat heb je OpenSSH niet geinstalleerd.  
We kunnen de client en server instaleren en updaten.  
``` 
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```  
``` 
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```  

![screenshot Is OpenSSH Installeren](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Installeren1.jpg)

Als je onderstaande ziet is het succesvol geinstalleerd.  

![Screenshot OpenSSH Succesvol Geinstalleerd](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Installeren-Succesvol.jpg)

## De SSH Connectie maken. 
### Controleer of de SSH service aanstaat.  
Controleer eerst of de **ssh-agent** aan staat dit is een **windows service**  
Voer de volgende commands in PowerShell.  

Start de Service.  
``` 
Start-Service sshd 
```  

Automatisch starten aanzetten. Dit is optioneel maar misschien wel handig.  
``` 
Set-Service -Name sshd -StartupType 'Automatic' 
```  

Firewall instelling OpenSSH.  
```
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}
```  

### Connectie maken met de VM in de cloud.  
Via de volgende command kunnen wij inloggen met de VM.  
``` 
ssh -i '/path/key-pair-name.pem' instance-user-name@instance-public-dns-name -p port
 ```  

Bij -i vullen wij de locatie van jouw **key** in.  
Daarna volgd het domein. **Gebruikersnaam**@**Domein**  
bij -p vul je de poort waarmee wij de VM kunnen bereiken.  

Nu ben je succesvol ingelogd in de VM.  
![screenshot succesvol ingelogd](../00_includes/LNX-01%20Setting%20Up/SSH-Connected-Succesvol.jpg)

## Problemen die ik tegen kwam.  
Had in eerste instantie **Containernaam**@**Domein** gedaan.  
Dan krijg je dus de volgende error.  
![screenshot acces denied error](../00_includes/LNX-01%20Setting%20Up/SSH-Access-Denied-Error.jpg)

Toen voegde ik een trouble shoot command toe -vvv aan mijn SSH command.  
Hier door werdt de verwarring als maar groter.  
Waren 40+ regels met errors, misschien handig voor later als ik dit goed snap.  
``` 
ssh -vvv -i '/path/key-pair-name.pem' instance-user-name@instance-public-dns-name -p port 
```  

Uit eindelijk met overleg kwam ik er achter dat ik het excelsheet niet goed gelezen had.  
Er stond gewoon een colom Users tussen, toen was de connectie figuurlijk en letterlijk zo gemaakt.  





