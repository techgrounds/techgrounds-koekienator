# [File Permissions]
Wie heeft er toegang tot wat?

## Key-terms
**read**   
**write**   
**execute**   

## Opdracht
### Gebruikte bronnen
https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions   
https://www.digitalocean.com/community/tutorials/linux-permissions-basics-and-how-to-use-umask-on-a-vps#types-of-permissions    

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
Hoe kan je permissions lezen?
Het is verdeeld over een aantal delen.
- Filetype
- Permission classes
    - User *** de gebruiker zelf ***
    - Group *** de gehele gebruikers groep *** 
    - Other *** iedereen die niet in User of Group zit ***    

Er zijn maar 2 bestandstypen in linux. Dat zijn normal en special. Normale bestanden zijn data files waar iets in geschreven staat en worden aangegeven als **-**. Speciale bestanden worden aangegeven met letters, een map bijvoorbeeld is dan **d**.

Permissions zijn de rechten die iemand heeft. Lezen **r**, Schrijven **w**, Uitvoeren **w**.

In de screenshot is te zien dat de User en Groep mogen lezen en schrijven, Other mag alleen lezen bij deze txt bestanden. 
![Screenshot longlist](../00_includes/LNX-05/Linux-LongList.jpg)

Hier een aantal voorbeelden:
```-rw-------```: een bestand dat alleen toegankelijk is voor de gebruiker.     
```-rwxr-xr-x```: een bestand die uitvoerbaar is voor iedere gebruiker.     


