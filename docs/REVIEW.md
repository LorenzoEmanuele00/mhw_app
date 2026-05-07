## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per parte di setup e creazione tabelle:

2. Dobbiamo fare dei cambiamenti importanti. Da adesso la nostra fonte di verit`a diventeranno i file json contenuti dentro output/merged. Quello che dobbiamo fare sarà adattare cio che abbiamo per corrispondere a qui file. In sostanza, un elemento estratto dalla tabella skill, dovrà avere il formati di un oggetto dentro l'array nel file skill. Dobbiamo poi associare corretamente tutti i valori di calcolo che abbia già estratto dall'excel (che rimangono corretti) alle skill presenti nel json. Se nel json ci sono più skill di quelle di skill_levels, allora andiamo ad aggiungere una riga per quella skill con tutto a null tranne id fk e nome. **Durante questo processo fai ESTREMA ATTENZIONE a quanto scritto nel punto successivo. dovranno essere modifiche fatto in contemporanea.**
3. Dobbiamo cambiare alcune cose sulle skill. il type_1 delle skill identifica:
   - series - group: quella skill è ottenuta se ci sono i necessari pezzi armatura indicati. Nel caso di _Fulgur Anjanath's Will_ ad esempio: Per ogni livello dell'abilità vediamo sotto quanti pezzi sono necessari affinchè quella skilla a quel livello compaia tra quelle attive.
   - weapon e armor: indicano se quella skill può essere applicata ad un armatura o ad un arma. Dobbiamo quindi sapere che l'utente non potrà assegnare un jewel con una skill weapon a dei pezzi armatura e viceversa. salvo condizioni extra che esplicitermeo in seguito

**_Nei file presi dall'excel c'è una diversità sul livello, questo tipo di skill hanno come livello il numero di pezzi necessari. Questa cosa deve cambiare quando facciamo l'unificazione dei dati. Avremo una colonna che ci indica i pezzi necessari per l'attivazione di quel livello specifico._**
