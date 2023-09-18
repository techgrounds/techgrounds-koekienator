# User Stories v1.1

| De klant wilt een loadbalancer gebruiken voor de web server |  
|---|---|  
| Epic | exploratie |  
| Beschrijving | Uitzoeken hoe een loadbalancer werkt en wat alle beveiligings opties zijn |  
| Deliverable |  |  

| De klant wilt meer beveiliging, HTTPS, TLS1.2 |  
|---|---|  
| Epic | exploratie |  
| Beschrijving | Uitzoeken hoe certificaten werken en hoe TLS1.2 te implementeren |  
| Deliverable |  |  

| De klant wilt een proxy tussen de web server en het internet |  
|---|---|  
| Epic | v1.1 |  
| Beschrijving | De web server moet via een proxy verbinding maken met internet, en mag de web server geen publiek IP aderess meer hebben |  
| Deliverable |  |  

| De klant wilt dat de web server alleen bereikbaar is via HTTPS |  
|---|---|  
| Epic | v1.1 |  
| Beschrijving | De loadbalancer van de web server moet http requests automatisch omzetten naar https requests |  
| Deliverable |  |  

| De klant wilt een loadbalancer gebruiken om piek momenten op te vangen |  
|---|---|  
| Epic | v1.1 |  
| Beschrijving | De loadbalancer moet bij x% een extra web server opstarten voor x minuten. Aannamen 80% workload, iedere 15 minuten controleren of de extra server nog nodig is. Er is in het verleden nooit meer nodig geweest dan 3 web servers tegelijk. |  
| Deliverable |  |  

| De klant wilt regelmatige health checks van de web server |  
|---|---|  
| Epic | v1.1 |  
| Beschrijving | De web server moet regelmatige health checks ondergaan, bij het falen van een health check moet de server automatisch hersteld worden |  
| Deliverable |  |  





Nieuwe Eisen: 
De klant wilt graag gebruik maken van meer mogelijkheden van de cloud. Daarnaast heeft de klant ook aangegeven dat deze graag aan meer security best practices wil voldoen die in de huidige versie nog niet zijn geïmplementeerd. Samen met de consultant heeft de klant het volgende opgesteld:
De webserver moet niet meer “naakt” op het internet te benaderen zijn. Het liefst ziet de klant dat er een proxy tussen komt. Ook zal de server geen publiek IP adres meer moeten hebben.
Mocht een gebruiker via HTTP verbinding maken met de load balancer dan zou deze verbinding automatisch geüpgraded moeten worden naar HTTPS.
Hierbij moet de verbinding beveiligd zijn met minimaal TLS 1.2 of hoger.
De webserver moet met enige regelmaat een ‘health check’ ondergaan.
Mocht de webserver deze health check falen dan zou de server automatisch hersteld moeten worden.
Mocht de webserver onder aanhoudende belasting komen te staan, dan zou er een tijdelijke extra server opgestart moeten worden. De klant denkt dat er nooit meer dan 3 servers totaal nodig zijn gezien de gebruikersaantallen in het verleden.

Note: Omdat we niet voor iedereen een domeinnaam willen aanschaffen, is het lastig om op de juiste manier een HTTPS-verbinding tot stand te brengen. Je mag hiervoor een self-signed certificate gebruiken. Je krijgt dan wel een waarschuwing in je browser, maar de verbinding wordt wel versleuteld.
Deliverables:
De volgende objecten moeten geleverd worden voor v1.1 van je applicatie:
Geüpdate versies van de volgende documenten:
Architectuurtekening
De onderbouwing van de nieuwe gebruikte diensten in het ontwerpdocument
Een MVP van v1.1
Doorgaand:
Je daglog met je bevindingen
De tussentijdse presentaties
De eindpresentatie



|  |  
|---|---|  
| Epic | v1.1 |  
| Beschrijving |  |  
| Deliverable |  |  
