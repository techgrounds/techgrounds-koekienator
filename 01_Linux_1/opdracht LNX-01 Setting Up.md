# [Settings up cloud VM connectie]
Hoe kan ik een verbindinging maken met een VM in de cloud?

## Key-terms
- OS of Operating System is jouw besturingssysteem. Bij mij is het momenteel Windows.
- VM of Virtual Machine is software die een OS simuleerd in de cloud of op jouw eigen computer.
- Linux 
- Cloud
- SSH
- Key File
- PowerShell
- CLI


# Opdracht
### Gebruikte bronnen 
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/openssh.html  
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html#AccessingInstancesLinuxSSHClient  


### Ervaren problemen
Het opzetten van de benodigdheden ging soepel, geen problemen ondervonden anders dan typfouten. 
De connectie maken wel lang mee bezig geweest, gebruikte dus containernaam i.p.v. user. 

# Resultaat
## Heb ik de benodigtheden om te beginnen met een SSH connectie?  
### Is Windows PowerShell geinstalleerd en up-to-date?     
Open Windows Powershell (als administrator).   
![Screenshot Windows Powershell](../00_includes/LNX-01%20Setting%20Up/Powershell-StartScherm.jpg)

Wat is de laatste powershell versie? commmand: winget search Microsoft.PowerShell   
![screenshot Windows Powershell laatste versie](../00_includes/LNX-01%20Setting%20Up/PowerShell-Laatste-Versie.jpg) 

Update command: winget install --id Microsoft.Powershell --source winget  
Update command voor preview versie: winget install --id Microsoft.Powershell.Preview --source winget   
Bij mij zijn deze nu up-to-date.     
![screenshot Windows Powershell update](../00_includes/LNX-01%20Setting%20Up/PowerShell-Update.jpg) 

### Heb ik OpenSSH geinstalleerd en up-to-date?
Open Windows PowerShell als **administrator** en typ je de volgende command om te controleren of OpenSSH geinstalleerd is.  
Command: Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
![screenshot Is OpenSSH Geinstalleerd?](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Geinstalleerd.jpg) 

Als bij state *NotPresent* staat heb je OpenSSH niet geinstalleerd.  
Met de onderstaande commands kan je OpenSSH instaleren.   
``` Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 ```  
``` Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 ```  
![screenshot Is OpenSSH Installeren](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Installeren1.jpg)

Als je onderstaande ziet is het succesvol geinstalleerd.  
![Screenshot OpenSSH Succesvol Geinstalleerd](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Installeren-Succesvol.jpg)

## De SSH Connectie maken. 
### Connectie maken met de VM in de cloud.   
Controleer eerst of de **ssh-agent** aan staat dit is een **windows service**
Voer de volgende commands in PowerShell.  
Start de Service.  
``` Start-Service sshd ``` 

Automatisch starten aanzetten.  
``` Set-Service -Name sshd -StartupType 'Automatic' ```

Firewall instelling OpenSSH.  
``` if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
} 
```


Zet de ssh-agent service aan. 
Command: Start-Service sshd


