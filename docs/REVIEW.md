## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per parte di setup e creazione tabelle:

1. Le tabelle hanno dei text come id —> è l’id primario (primaryKey)? Nel caso non salrebbe meglio lasciare un integer autoincrement unique che sia anche index (per velocizzare le query)? E aggiungere magari un campo slug anch’esso unique? —> Se questo ha senso allora andiamo a fare un check se questa modifica possa avere ripercussioni su altri file o metodi nel progetto e poi facciamo le dovute modifiche (probabile impatto su tabelle di build, dove la foreignKey non sarà più text e nei DAO relativi dove ci sono check su id).
2. Le tabelle hanno molti campi di testo, dove però le opzioni sono limitate e decise in precedenza. Sarebbe utile e typesafe utilizzare degli enum in modo da permettere solo l’inserto di determinati text o Type
3. Le chiavi primarie dovrebbero essere indici di default, se così non fosse, aggiungili

### Commenti generali

1. Tutto ciò che è scritto nel progetto dovrebbe essere in inglese: file, commenti, nomi e documentazione.
2. Ogni parte del codice dovrebbe essere testata. Ricordati di inserire dei test automatici per ogni implementazione che esegui. Ricrdati di lanciare tutti i test automatici al termine di ogni implementazine per controllare di non aver creato ripercussioni su altre feature.
