# PROGRESS.md — Stato Avanzamento

Aggiornare questo file ad ogni sessione.

## Fase corrente: 0 — Setup

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

### Fase 1: Data Layer ⬜ DA FARE
- [ ] Script Python `parse_excel.py` per estrarre skill e weapon mods
- [ ] Seed SQL generato da Excel
- [ ] Repository layer (weapons, armor, skills, builds, talismans)
- [ ] Supabase project creato e schema caricato
- [ ] Sync base funzionante (con versioning)

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

### 2026-05-05
- Progetto creato da zero su piano condiviso con l'utente
- Stack scelto: drift + supabase + riverpod + go_router
- Fonte dati principale: `/Users/loke/Downloads/Alpha Calulator.xlsx`
- Dati mancanti (armature, armi base, gioielli) da raccogliere esternamente
- MVP: statistiche aggregate (no DPH per hitzone — riservato fase futura)
- Talismani: CRUD utente, solo locale
