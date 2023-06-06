# [Settings up cloud VM connectie]
Hoe kan ik een verbindinging maken met een VM in de cloud?

## Key-terms
- VM
- Linux
- Cloud
- SSH
- Key File


## Opdracht
### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]

### Heb ik OpenSSH geinstalleerd?
Open Windows Powershell (als administrator).  
![Screenshot Windows Powershell](../00_includes/LNX-01%20Setting%20Up/Powershell-StartScherm.jpg)

Wat is de laatste powershell versie? commmand: winget search Microsoft.PowerShell  
![screenshot Windows Powershell laatste versie](../00_includes/LNX-01%20Setting%20Up/PowerShell-Laatste-Versie.jpg) 

Update command: winget install --id Microsoft.Powershell --source winget  
Update command voor preview versie: winget install --id Microsoft.Powershell.Preview --source winget  
Bij mij zijn deze nu up-to-date.   
![screenshot Windows Powershell update](../00_includes/LNX-01%20Setting%20Up/PowerShell-Update.jpg) 



Open de Windows PowerShell app als administrator. 