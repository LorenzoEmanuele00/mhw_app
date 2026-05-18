## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per Loadouts screen:

### Review generici:

### Review progetto:

- servirebbe una tab impostazioni:
  - Possibilità di cambiare lingua.
  - Possibilità di impostare il tema bianco/nero/affine al device
  - Info varie
  - Mail a supporto

### Review traduzioni:

### Review scafolding:

### Review da NON fare adesso:

- Le skill offensive possono essere rosse le defensive blue e utility verdi
- Pensare a un integrazione di PostHog (Vedere i costi superati il 1M di logs. Imagino che non ci arriveremo... ma non si sa mai)
- Installare la skill dei graficini e mappe per caludio. potrebbe fare belle cose.
- Iniziare a pensare alla gestione del dps mostro ecc.
- Ma glielo diamo un nome a st'app o no??
- Utilizzo delle icone
  - Appena attachiamo il supabase vedi come se ne vanno qui cazzo di script di merda..... - A quel punto vorrò una bella schermata di loading. mi faccio anche il logo. chissà se claudio designer sa fare i video da mettere nel codice per fare animazioni. nel caso lo fa lui... una bella V di vermillion.....
- Login, auth e $:
  - Ad una certa dovremmo pensare di integrare una sorta di account/login con google, apple ecc
  - Dalla parte sopra arriva anche l'implementazione di un eventuale acquisto per avere no pubblicità e slot infiniti per le build. (Da capire a quanto limitarli 5? 10?) -- (Anche i charm potrebbero essere limitati a 5-10). Senza account ovviamente non andiamo da nessuna parte. Questa è roba delicata, non so se vorrei avere un IDP.. ma forse non se ne esce, e google e apple.
  - Potremmo arrivare ad avere una specie di sistema di push di build (per che si è pagato qui 0.99$). Vuoi condividere la tua build, bravo mandala easy e si completa (pensare alla gestione charm.. ma forse basta che li generiamo con un iconcina extra per quelli generati che richiede approvazione o modifica.)

### Appunti per supabase:

- Ricordiamoci di modificare le skill off/def/utils:
  - Off - armat = aranc // off - weap = rosso
  - def - armat = blue // def - weap = viola
  - utils = verde
