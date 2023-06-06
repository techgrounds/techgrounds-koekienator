# [Settings up cloud VM connectie]
Hoe kan ik een verbindinging maken met een VM in de cloud?

## Key-terms
- VM
- Linux
- Cloud
- SSH
- Key File
- PowerShell


## Opdracht
### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

# Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]

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

### Heb ik OpenSSH geinstalleerd?
Open Windows PowerShell als administrator en typ je de volgende command om te controleren of OpenSSH geinstalleerd is.
Command: Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
![screenshot Is OpenSSH Geinstalleerd?](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Geinstalleerd.jpg) 

Als bij state NotPresent staat heb je OpenSSH niet geinstalleerd.
Met de onderstaande commands kan je OpenSSH instaleren. 
Command: Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Command: Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
![screenshot Is OpenSSH Installeren](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Installeren1.jpg)

Als je onderstaande ziet is het succesvol geinstalleerd.  
![Screenshot OpenSSH Succesvol Geinstalleerd](../00_includes/LNX-01%20Setting%20Up/OpenSSH-Installeren-Succesvol.jpg)

## De SSH Connectie maken. 
### Connectie maken met de VM in de cloud. 