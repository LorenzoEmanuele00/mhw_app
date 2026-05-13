## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per Loadouts screen:

1. Vorrei un bordo colorato attorno al loadout attualmente attivo. Il bordo deve essere sulla card, quindi trascinandola deve rimanere attaccato ad essa.
2. Il bottone cancella non è necessario. Il bottone modifica invece può essere solo un icona

### Review widget generici:

### Review progetto:

### Review traduzioni:

### Review scafolding:

- Le folder builds e builder a cosa servono? Non vengono usate e se non sbaglio non verranno usate. Controlla che tutti ciò che c'è al loro interno sia inutilizzato e poi, nel caso, cancellale
  - Se non sbaglio il buildsRepository è usato, potrebbe diventare un LoadoutsRepository e andare nella cartella loadouts. Un loadout è una build, così come il suo plurale l'insieme dele build.

### Review da NON fare adesso:

- E se invece di aprire un listone di armi ecc, nella build vuota andassimo nella tab equip con i filtri già messi per il pezzo da cui proviene la selzione?
- Le skill offensive possono essere rosse le defensive blue e utility verdi
