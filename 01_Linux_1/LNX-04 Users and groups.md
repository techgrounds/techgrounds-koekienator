# [Onderwerp]
[Geef een korte beschrijving van het onderwerp]

### Key-terms   
**Sudo** superuser, de admin van linux


### Gebruikte bronnen
https://www.digitalocean.com/community/tutorials/how-to-create-a-new-sudo-enabled-user-on-ubuntu-22-04-quickstart   https://www.digitalocean.com/community/tutorials/how-to-view-system-users-in-linux-on-ubuntu#how-to-view-available-users    
https://www.digitalocean.com/community/tutorials/how-to-use-passwd-and-adduser-to-manage-passwords-on-a-linux-vps   


## Resultaat
### Gebruiker toevoegen
Als je sudo rechten hebt kan je een nieuwe gebruiker aanmaken met **adduser**.  
Heb zelf een passwordt ingesteld, je kan ook enter doen zonder password.    
```
sudo adduser techgrounds_user1
```
![Screenshot add new user](../00_includes/LNX-04/Linux-add-new-user.jpg)

### Gebruiker rechten geven
Geef gebruiker sudo rechten met **usermod -aG**     
```
sudo usermod -aG sudo techgrounds_user1
```
![Screenshot](../00_includes/LNX-04/Linux-give-sudo-rights.jpg)

Als je van gebruikt wilt wisselen kan dat met **su**.   
Kunnen wij meteen testen of hij sudo rechten heeft en in de rootfolder kan kijken. 
```
sudo su techgrounds_user1
``` 
```
sudo ls -la /root
```
![Screenshot login other user](../00_includes/LNX-04/Linux-login-other-user.jpg)

### Waar staan gebruikers opgeslagen?
Alle gebruikers en services staan in **/etc/passwd** dit is onzichtbaar met ls -a. We kunnen er wel in kijken. Dit kan met **cat** en komt alles in de terminal maar dat is niet handig met **less** wordt het bestand geopend als het waren in een nieuw scherm. Met  **q** kan dit scherm weer gesloten worden. Mijn eigen account en techgrounds_user01 zijn beide zichtbaar in dit bestand!
```
less /etc/passwd
```
![Screenshot all users](../00_includes/LNX-04/Linux-all-users.jpg)


## Ervaren problemen
Hoofdletter gevoeligheid, een a of een A heeft letterlijk een andere functie. 
