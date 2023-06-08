# [Bash scripting]
Wat is een Bash script en hoe maak ik er één?

## Key-terms
**script** meerdere commands in een uitvoerbaar bestand. 


## Opdracht
### Gebruikte bronnen
https://www.digitalocean.com/community/tutorial_series/an-introduction-to-shell-scripting

## Resultaat
### Wat is een Bash script?
Een Bash script is een uitvoerbaar bestand waar (meerdere) regel(s) commands in staan. Hiermee kan je bijvoor beeld processen automatiseren en programma's laden tijdens het opstarten. 

### Wat is er nodig?
Bash is de standaard shell voor Linux en daarnaast hebben wij een directory nodig om onze scripts in op te slaan. Vervolgens maken wij een PATH aan voor deze directory. Dan kunnen wij zo vanaf overal een script runnen die in deze directory staat.
```
mkdir ~/scripts
sudo nano /etc/profile
PATH=$PATH:$HOME/scripts export PATH
sudo reboot
```

### Onze eerste bash script.
Even testen of alles werkt. We maken een nieuwe uitvoerbaar document aan met de ".sh" extentie en openen het bestand met onze editor **nano**.  
```
touch ~/scripts/eerstescript.sh | chmod 700 ~/scripts/eerstescript.sh
nano ~/scripts/eerstescript.sh
```
Nu we in de editor zitten moeten wij eerst aangeven dat het een bash script is met ```#!/bin/bash``` daarna kunnen wij een paar commands invoeren.
```
echo "Hey dit is mijn eerste script"
```
Met ```Ctrl+O``` slaan wij het document op en met ```ctrl+X``` sluiten wij het document. Tijd om het script te testen.
```
eerstescript.sh
```
![Screenshot ons eerste script](../00_includes/LNX-07/Bash-eerstescript.jpg)



## Ervaren problemen
Had door ontwetendheid mijn Linux "gesloopt" door iets niet goed over te typen. Geen één command kon worden uitgevoerd. Had blijkbaar mij homefolder veranderd waardoor ik niet op de normale manier commands kon gebruiken. Kon gefixt worden na wat googlen met:
```
export PATH=/usr/local/bin:/usr/bin:/bin:$HOME/bin
```


