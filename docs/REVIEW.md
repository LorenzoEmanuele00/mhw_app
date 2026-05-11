## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per Armor browsing screen

2. Per l'app_sheet:
   - Vorrei che si aprisse e rimanesse sempre alla stressa altezza, e quindi scrollasse solo al interno.
   - l'animazione di chiusura dovrebbe richiedere meno trascinamento e non dovrebbe essere possibile per l'app_sheet bloccarsi a metà scroll
   - aggiungerei un tasto x in alto a sinsitra dell'app_sheet per chiuderlo.

3. Non serve il numero totale di oggetti a catalogo.
4. Allo startup l'app mostra per un po la schermata bianca, poi mostra un loader, per qualche stante e poi la schermatabdell'app. questa però non è responsiva per qualche secondo. vorrei che questa cosa venisse fixata nei seguenti modi: - voglio vedere il loader sempre, per dare un feedback all'utente che sta succedendo qualcosa. - l'app deve aprirsi solo quando è completamente pronta, non voglio momenti di freeze allo startup.
5. una domanda è possibilie mettere un animazione allo startup? tipo loghi aziendali o simili?

### Review progetto:

1. Guarda tutti i file, compresi quelli dentro ios/ e android/ e controlla se è necessario che siano pusati, in caso aggiungili al gitignore.

### Review traduzioni:

1. A cosa servono i file .arb? le traduzioni sono già espresse nei app_localizations ?

- alcune traduzioni in italiano non mi piacciono :
  - nodachi --> Spada Lunga
  - doppio artiglio --> Doppie Lame
  - corno caccia --> Corno da Caccia
  - ascia commutante --> Spada Ascia
  - ascia da carica --> Lama Caricata
  - insettoglaive --> Falcione Insetto
  - ballistalite --> Balestra Leggera
  - ballistagrande --> Balestra Pesante

- alcune traduzioni in italiano non mi piacciono in generale:

### Review scaffolding
