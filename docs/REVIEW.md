## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per parte di setup e creazione tabelle:

1. Le tabelle hanno dei text come id —> è l’id primario (primaryKey)? Nel caso non salrebbe meglio lasciare un integer autoincrement unique che sia anche index (per velocizzare le query)? E aggiungere magari un campo slug anch’esso unique? —> Se questo ha senso allora andiamo a fare un check se questa modifica possa avere ripercussioni su altri file o metodi nel progetto e poi facciamo le dovute modifiche (probabile impatto su tabelle di build, dove la foreignKey non sarà più text e nei DAO relativi dove ci sono check su id).
2. Le tabelle hanno molti campi di testo, dove però le opzioni sono limitate e decise in precedenza. Sarebbe utile e typesafe utilizzare degli enum in modo da permettere solo l’inserto di determinati text o Type
3. Le chiavi primarie dovrebbero essere indici di default, se così non fosse, aggiungili

### Commenti generali

1. Tutto ciò che è scritto nel progetto dovrebbe essere in inglese: file, commenti, nomi e documentazione.
2. L'applicazione invecedovrà avere almeno la doppia lingua tra italiano e inglese. Questo significa che dobbiamo strutturare un processo di traduzione flessibile, per avere modo in futuro di aggiungere altre lingue se necessario.
3. Ogni parte del codice dovrebbe essere testata. Ricordati di inserire dei test automatici per ogni implementazione che esegui. Ricrdati di lanciare tutti i test automatici al termine di ogni implementazine per controllare di non aver creato ripercussioni su altre feature. **_Questa regola deve essere ferrea e rispettata sempre._**

### Domande

- Non sarebbe forse eliminare la gestione dei seed al di fuori degli ambienti di sviluppo? Non se se questa cosa sia possibile, ma mi imaginavo un flusso di questo tipo:
  1. Al primo avvio l'app necessita connessione alla rete.
  2. Scaricherà le tabelle da supabase
  3. A quel punto verranno quindi syncate e salvate sul db sqlite

  Evitiamo così la necessità di avere dei seeder interni. Possiamo comunque tenerli per adesso in modo da utilizzarli in ambiente di sviluppo, Ma per quando l'app andrà in prod vorrei slegarmi da questo metodo.
