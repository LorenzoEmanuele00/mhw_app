# PROGRESS.md — Stato Avanzamento

Aggiornare questo file ad ogni sessione.

## Fase corrente: 2 — Equipment Browser

### Fase 0: Setup ✅ COMPLETATA
- [x] Progetto Flutter creato (`flutter create mhw_app`)
- [x] Cartella `/docs` creata
- [x] `CLAUDE.md` scritto
- [x] `ARCHITECTURE.md` scritto
- [x] `DATA_MODEL.md` scritto
- [x] `CALC_ENGINE.md` scritto
- [x] `pubspec.yaml` aggiornato con dipendenze (drift, supabase, riverpod, go_router, connectivity_plus)
- [x] Struttura cartelle `lib/` creata (core/features/shared)
- [x] Schema drift definito — tabelle game + user + DAO per ogni dominio
- [x] go_router configurato con StatefulShellRoute (3 tab: Equipment/Builds/Builder)
- [x] Entry point `main.dart` configurato con ProviderScope + MaterialApp.router
- [x] Codegen drift completato (zero warning, zero errori)
- [x] `flutter analyze` → No issues found

### Fase 1: Data Layer ✅ COMPLETATA (parziale — Supabase rimandato a Fase 5)
- [x] Script Python `scripts/parse_excel.py` — estrae skill, weapon mods, motion values
- [x] Seed SQL generato: `01_skills.sql` (168 skill), `02_skill_levels.sql` (427 livelli)
- [x] `03_weapon_mods.json` — RMV/EMV/sharpness per 14 tipi arma
- [x] `04_motion_values.sql` — 1216 motion value entries (per DPH futuro)
- [x] `SeedService` — carica SQL seed al primo avvio se DB vuoto
- [x] Repository layer: WeaponsRepository, ArmorRepository, JewelsRepository, TalismansRepository, BuildsRepository, SkillsRepository
- [x] Provider Riverpod per tutti i repository + StreamProvider per le liste
- [x] `main.dart` aggiornato — seedInitProvider attivo, splash durante init
- [x] `flutter analyze` → No issues found
- [ ] Supabase project creato e schema caricato (→ Fase 5)
- [ ] Sync base funzionante (→ Fase 5)

### Fase 2: Equipment Browser ⬜ DA FARE
- [ ] Weapon list screen con filtro per tipo
- [ ] Weapon detail screen
- [ ] Armor list screen con filtro per slot/serie
- [ ] Armor detail screen
- [ ] Jewel list screen
- [ ] Talisman list screen
- [ ] Talisman create/edit/delete

### Fase 3: Build System ⬜ DA FARE
- [ ] Build list screen
- [ ] Builder screen — slot weapon
- [ ] Builder screen — 5 slot armatura
- [ ] Builder screen — slot talisman
- [ ] Builder screen — slot gioielli dinamici
- [ ] Salvataggio build

### Fase 4: Stats Engine ⬜ DA FARE
- [ ] Calc Engine: aggregazione skill dalla build
- [ ] Calc Engine: True Raw
- [ ] Calc Engine: Effective Affinity
- [ ] Calc Engine: True Element
- [ ] Calc Engine: Defense + Elem Resistances
- [ ] Stats Panel live nel builder
- [ ] Stats view nel dettaglio build

### Fase 5: Supabase Sync ⬜ DA FARE
- [ ] Connectivity detection
- [ ] Versioning check
- [ ] Delta sync tabelle dati di gioco
- [ ] UI indicator sync status

### Fase 6: Polish ⬜ DA FARE
- [ ] Filtri equipment (per tipo, rarity, skill)
- [ ] Ricerca testuale
- [ ] Sorting
- [ ] UI/UX refinement

## Note di sessione

### 2026-05-05 — Sessione 1
- Progetto creato da zero su piano condiviso con l'utente
- Stack scelto: drift + supabase + riverpod + go_router
- Fonte dati principale: `/Users/loke/Downloads/Alpha Calulator.xlsx`
- Dati mancanti (armature, armi base, gioielli) da raccogliere esternamente
- MVP: statistiche aggregate (no DPH per hitzone — riservato fase futura)
- Talismani: CRUD utente, solo locale

### 2026-05-05 — Sessione 2
- Aggiornati pacchetti Flutter e dipendenze (drift 2.33.0, sqlite3 3.3.1, flutter_riverpod 3.1.0, go_router 17.x)
- Rimossi pacchetti inutilizzati o incompatibili: `sqlite3_flutter_libs`, `riverpod_annotation`, `riverpod_generator`, `custom_lint`, `riverpod_lint`
- Tutti i provider scritti manualmente (no @riverpod codegen)
- `flutter pub outdated` — tutti i pacchetti diretti all'ultima versione disponibile
- `flutter analyze` → No issues found
- Aggiornata ARCHITECTURE.md (stack, pattern provider, comando codegen)
