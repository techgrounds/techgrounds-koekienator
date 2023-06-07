# [Files en Directories]
[Geef een korte beschrijving van het onderwerp]

## Key-terms  
Terminal is de CLI van Linux
Root is de basis folder van Linux
Prompt is iets invoeren in een CLI

# Opdracht  
### Gebruikte bronnen  
https://ubuntu.com/tutorials/command-line-for-beginners#1-overview

### Ervaren problemen  
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

# Resultaat  
## De Linux Terminal  
Zo ziet een lege terminal er uit    
![Screenshot empty terminal](../00_includes/LNX-02%20Files%20and%20directories/Linux-Terminal-Empty.jpg)

Dit is onze CLI, je begint automatisch in jouw home directory tenzei anders ingesteld. 

### Basis commands in Linux
- **whoami** username.
- **pwd** print working directory. 
- **ls** list.
- **ls > text.txt** make a new text file.
- **rm** remove a file.
- **cd** change direcotry.
- **mv** rename or move file/directory.
- **mkdir** make directory.
- **rmdir** remove directory.
- **cat** display contents of a file (not open file).
- **echo** write a line of text.
- **--help** write this after any command for help options. 

### Handige hotkeys
- **CTRL-L** maak je terminal leeg.
- **Pijltje omhoog/omlaag** zoek door je promt geschiedenis. 

## Hoe is mijn mappen structuur?
Met **pwd** kan je zien waar je nu bent in Linux.
Met **ls** kan je de mappen zien als je **-a** toevoegd zie je ook verborgen mappen. 
![screenshot linux home list](../00_includes/LNX-02%20Files%20and%20directories/Linux-home-list.jpg)

## Hoe kan ik een map maken
We willen een nieuwe map aanmaken.
Daarvoor is **mkdir <naam van map>** 
Met **cd <naam van map>** kunnen wij deze map in.
![screenshot linux nieuwe map](../00_includes/LNX-02%20Files%20and%20directories/Linux-Nieuwe-Map.jpg)

## Hoe kan ik een text bestand maken
We willen een text bestand aanmaken.
Dat kan op twee manieren met **ls** kan je er een aanmaken maar niet meteen in schrijven of via **echo** dan kan er ook direct in gescreven worden.  
''' 
**ls > naam.extentie** 
''' 
''' 
**echo "plaats hier uw text" naam.extentie**
'''
![screenshot linux new doc](../00_includes/LNX-02%20Files%20and%20directories/Linux-New-Doc.jpg)

## Relatief en absolute paths
Er zijn twee manieren om een path aan te geven.
Relatief:
''' 
**cd techgrounds**
'''  
Absoluut:
'''
**cd /home/username/techgrounds**
'''   
![Screenshot linux pathing](../00_includes/LNX-02%20Files%20and%20directories/Linux-Pathing.jpg)

##
