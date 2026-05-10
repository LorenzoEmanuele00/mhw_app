## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per Armor browsing screen

1. aggiungerei un tasto x in alto a sinsitra del dattagio dell'equip per chiudere la banda.
2. Riguail dettaglio dell'equip: - Vorrei che si aprisse e rimanesse sempre alla stressa altezza, e quindi scrollasse solo al interno. - l'animazione di chiusura dovrebbe richiedere meno trascinamento
3. Non serve vedere quanti oggetti sono presenti in catalog. rimuovi quel dato.

4. Allo startup l'app mostra per un po la schermata bianca, poi mostra un loader, per qualche stante e poi la schermatabdell'app. questa però non è responsiva per qualche secondo. vorrei che questa cosa venisse fixata nei seguenti modi: - voglio vedere il loader sempre, per dare un feedback all'utente che sta succedendo qualcosa. - lápp deve aprirsi solo quando è completamente pronta, non voglio momenti di freeze allo startup
