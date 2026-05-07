## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per parte di setup e creazione tabelle:

1. Le tabelle hanno dei text come id —> è l’id primario (primaryKey)? Nel caso non salrebbe meglio lasciare un integer autoincrement unique che sia anche index (per velocizzare le query)? E aggiungere magari un campo slug anch’esso unique? —> Questo riflette in modo più accurato la situazione che troviamo nei dai reali —> Avere lo slug inoltre ci aiuta a differenziare nei casi futuri in cui due armi o armature con lo stesso nome indichino due pezzi diversi (penso ad un eventuale potenziamento).
   Possiamo quindi andare a fare un check se questa modifica possa avere ripercussioni su altri file o metodi nel progetto e poi facciamo le dovute modifiche (probabile impatto su tabelle di build, dove la foreignKey non sarà più text e nei DAO relativi dove ci sono check su id).
2. Adesso ho aggiunto una cartella true data in assets. Li sono contenuti tutti i json con armi, skill, armature ecc. Questa diventa la nostra fonte di verità su gli elementi, mentre excel rimane la verità su tutti i calcoli, i modificatori delle skill per livello (skill_level), i modificatori delle armi, motion value, hitzone value. --> Voglio quindi che venga fatta questa operazione: le tabelle verranno aggiornate sulla base di true data
3. Dobbiamo puntualizzare alcune cose sulle skill. il type_1 delle skill identifica:
   - series - group: quella skill è ottenuta se ci sono i necessari pezzi armatura indicati. Nel caso di _Fulgur Anjanath's Will_ ad esempio: Per ogni livello dell'abilità vediamo sotto quanti pezzi sono necessari affinchè quella skilla a quel livello compaia tra quelle attive.
   - weapon e armor: indicano se quella skill può essere applicata ad un armatura o ad un arma. Dobbiamo quindi sapere che l'utente non potrà assegnare un jewel con una skill weapon a dei pezzi armatura e viceversa. salvo condizioni extra che esplicitermeo in seguito

Alla luce di questo rinominerei il type_1 in "kind" per identificare appunto il tipo di skill. Di conseguenza type_2 --> type_1.
Inoltre dobbiamo andare a fare dei cambiamoenti. Nei file presi dall'excel c'è una diversità sul livello, questo tipo di skill hanno come livello il numero di pezzi necessari. Questa cosa deve cambiare quando facciamo l'unificazione dei dati. Avremo una colonna che ci indica i pezzi necessari per l'attivazione di quel livello specifico.
