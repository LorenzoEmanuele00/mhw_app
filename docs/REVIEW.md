## REVIEW DOCS

**_ATTENZIONE: Questo documento contiene le review al codice che verranno fatte. Leggile soltanto quando viene espressamente richiesto_**

### Review per Loadouts screen:

1. Vorrei un bordo colorato attorno al loadout attualmente attivo. Il bordo deve essere sulla card, quindi trascinandola deve rimanere attaccato ad essa.
2. Il bottone cancella non è necessario. Il bottone modifica invece può essere solo un icona

### Review generici:

1. Quando cambio pezzo equipaggiato vorrei togliere i jewel attaccati a quel pezzo, altrimenti cambiando pezzo, ritrovo ancora gli stessi jewel attaccati.

### Review progetto:

### Review traduzioni:

### Review scafolding:

### Review da NON fare adesso:

- Le skill offensive possono essere rosse le defensive blue e utility verdi

3. \_weaponTypeLabel e \_elementLabel duplicati
   Definiti identici in build_screen.dart:616-643 e equipment_detail_sheet.dart:592-627. Da spostare in un file utility condiviso.

4. onClear morto in \_openWeaponPicker e \_openArmorPicker
   (build_screen.dart:277, build_screen.dart:381-383)
   Entrambe le funzioni sono chiamate solo quando lo slot è vuoto → buildState.weapon != null è sempre false → onClear è sempre null. La condizione non ha effetto.

5. Future.wait con cast posizionale in \_resolve (build_notifier.dart:146-178)
   8 future in una lista List<Object?>, poi castati manualmente per posizione. Fragile se l'ordine cambia. Meglio usare future separati con named variables o un record
   tipizzato.

6. Builder ridondante in \_ArmorDetail (equipment_detail_sheet.dart:315-328)
   Wrappa solo il bottone equip per leggere buildNotifierProvider, ma il parent ConsumerWidget lo osserva già alla riga 229. Il Builder non aggiunge nulla.

7. File placeholder non usati
   lib/features/builder/builder_screen.dart e lib/features/builds/builds_screen.dart non sono importati da nessuna parte (confermato: nessun riferimento nel router). Vanno
   eliminati.

8. Swipe-to-dismiss fuorviante (loadouts*screen.dart:119-135)
   confirmDismiss: (*) async => false fa apparire il background rosso al swipe ma non elimina nulla. L'utente vede un feedback visivo che non porta a nulla. O si collega
   l'azione o si rimuove il Dismissible.

---

Note minori

9. Nome build duplicabile (build_notifier.dart:342): 'Build ${all.length + 1}' dopo una delete può generare "Build 3" due volte. Non è un crash, ma è UX scomoda.

10. \_LoadoutCard osserva liste complete (loadouts_screen.dart:152-153): ogni card fa ref.watch(allWeaponsProvider) + ref.watch(allArmorProvider) (1902 oggetti totali) per
    estrarne 1-5. Per ora è accettabile, da ottimizzare prima della Phase 6.
