# MHWilds Character Builder — CLAUDE.md

## Regola cardine
La cartella `/docs` contiene la documentazione viva del progetto. Va tenuta aggiornata ad ogni sessione. Prima di iniziare qualsiasi lavoro, leggere i file in `/docs` per riprendere il contesto.

## Panoramica progetto
App Flutter per Monster Hunter Wilds (MHW). Permette di creare e gestire build di equipaggiamento, calcolando le statistiche aggregate risultanti. Trattata come progetto standalone, non dipendente da API di gioco.

**Target**: iOS + Android  
**Working directory**: `/Users/loke/projects/mhw_app`

## Stack tecnico
- **Flutter** — framework UI cross-platform
- **drift** — ORM SQLite type-safe (migrations, query reattive, codegen)
- **supabase_flutter** — sync dati di gioco (armi, armature, skill) quando online
- **flutter_riverpod** — state management
- **go_router** — navigazione con shell routes (bottom nav)
- **connectivity_plus** — rilevamento connettività per sync

## Struttura cartelle
```
lib/
  core/
    database/       ← drift database, tables, DAOs
    providers/      ← provider globali (db, supabase, connectivity)
    router/         ← go_router config
  features/
    equipment/
      weapons/      ← list, detail, filter
      armor/        ← list, detail, filter
      jewels/       ← list, detail
      talismans/    ← CRUD utente
    builds/         ← lista build + detail read-only
    builder/        ← creazione/modifica build con stats live
  shared/
    models/         ← modelli dart puri (no drift)
    widgets/        ← widget riusabili
    calc/           ← motore di calcolo statistiche
docs/
  ARCHITECTURE.md   ← schema DB e architettura dettagliata
  DATA_MODEL.md     ← tutti i modelli e le relazioni
  CALC_ENGINE.md    ← formule di calcolo (da Excel)
  PROGRESS.md       ← stato avanzamento fasi
  SUPABASE.md       ← configurazione e schema remoto
scripts/
  parse_excel.py    ← estrae dati da Excel → SQL seed
```

## Schema DB (drift)
Vedere `/docs/DATA_MODEL.md` per schema completo.

**Tabelle dati di gioco** (sync da Supabase, read-only locale):
- `weapons`, `armor_pieces`, `armor_sets`, `jewels`
- `skills`, `skill_levels`

**Tabelle utente** (solo locale, mai sincronizzate):
- `talismans` — creati dall'utente con skill + slot custom
- `builds` — weapon + 5 slot armatura + talisman + nome
- `build_jewels` — gioielli inseriti negli slot della build

**Sync metadata**:
- `sync_metadata` — versione per tabella per delta sync

## Schermate (go_router shell)
```
Bottom Nav 3 tab:
├── /equipment          ← tab Equipment (sub-tab: weapons/armor/jewels/talismans)
├── /builds             ← lista build → /builds/:id (dettaglio)
└── /builder            ← /builder/new o /builder/:id (modifica)
```

## Motore di calcolo (MVP)
Vedere `/docs/CALC_ENGINE.md` per formule complete.

MVP calcola statistiche aggregate:
- True Raw, Effective Affinity, True Element, Defense, Elemental Resistances
- I bonus skill sono tipizzati (multiplier / additive) in `skill_levels`

**Estensione futura DPH**: tabelle `motion_values` e `hitzone_values` già previste in Supabase. Il calc engine è progettato per accettare questo layer senza refactor.

## Strategia sync Supabase
1. App start → controlla connettività
2. Se online → fetch `current_version` da Supabase
3. Se versione locale < remota → scarica tabelle aggiornate e sostituisce locale
4. Dati utente (builds, talismans) non escono mai dal device

## Fasi di sviluppo
Vedere `/docs/PROGRESS.md` per stato aggiornato.

| Fase | Descrizione |
|------|-------------|
| 0 | Setup: dipendenze, DB schema drift, routing base |
| 1 | Data layer: seed da Excel, repository, sync base |
| 2 | Equipment browser: armi/armature/gioielli + CRUD talismani |
| 3 | Build system: builder UI, slot management, salvataggio |
| 4 | Stats engine: Calc Engine MVP, stats panel live |
| 5 | Supabase sync completo con versioning |
| 6 | Polish: filtri, ricerca, sorting, UI refinement |

## Dati sorgente
**Excel**: `/Users/loke/Downloads/Alpha Calulator.xlsx`
- Sheet "Skill Data": ~200 skill con bonus tipizzati (già parsati)
- Sheet "Weapon Modifier": 14 armi con RMV, EMV, sharpness mods
- Sheet 4-17 (GS/LS/SnS/...): motion values per arma (per DPH futuro)
- Sheet "Calculator": formula calcolo danni completa
- Sheet "Builder": struttura skill per categoria (ARMOR/GROUP/SERIES/WEAPON)

**Dati mancanti** (da raccogliere): stats base armi, armature con defense/res/slot, gioielli
