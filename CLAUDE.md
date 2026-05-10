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
    database/
      tables/         ← game_tables.dart, user_tables.dart
      daos/           ← 5 DAO (weapons, armor, skills, builds, talismans)
      database.dart   ← AppDatabase drift
      seed_service.dart ← carica SQL seed al primo avvio
    providers/
      database_provider.dart
      seed_provider.dart  ← seedInitProvider (FutureProvider)
    router/
      router.dart     ← go_router shell route 3 tab
  features/
    equipment/
      weapons/
        repository/weapons_repository.dart
        weapons_screen.dart
      armor/
        repository/armor_repository.dart
        armor_screen.dart
      jewels/
        repository/jewels_repository.dart
        jewels_screen.dart
      talismans/
        repository/talismans_repository.dart
        talismans_screen.dart
    builds/
      repository/builds_repository.dart
      builds_screen.dart
    builder/
      builder_screen.dart
  shared/
    calc/
      skills_repository.dart  ← SkillsRepository + allSkillsProvider
      calc_engine.dart        ← (Fase 4)
    models/
    widgets/
docs/
  ARCHITECTURE.md   ← stack e struttura dettagliata
  DATA_MODEL.md     ← schema DB completo
  CALC_ENGINE.md    ← formule di calcolo (da Excel)
  PROGRESS.md       ← stato avanzamento fasi
scripts/
  parse_excel.py    ← estrae dati da Excel → SQL seed
  seeds/
    01_skills.sql       ← 168 skill
    02_skill_levels.sql ← 427 livelli con bonus tipizzati
    03_weapon_mods.json ← RMV/EMV/sharpness 14 tipi arma
    04_motion_values.sql ← 1216 MV per DPH futuro
assets/
  seeds/            ← copia dei seed SQL bundled nell'app
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
- Sheet "Skill Data": 168 skill, 427 livelli con bonus tipizzati (già parsati → `scripts/seeds/`)
- Sheet "Weapon Modifier": 14 armi con RMV, EMV, sharpness mods
- Sheet 4-17 (GS/LS/SnS/...): motion values per arma (per DPH futuro)
- Sheet "Calculator": formula calcolo danni completa
- Sheet "Builder": struttura skill per categoria (ARMOR/GROUP/SERIES/WEAPON)

**Dati già estratti**: 168 skill, 427 livelli skill, RMV/EMV 14 tipi arma, 1216 motion values  
**Dati mancanti** (da raccogliere esternamente): stats base armi, armature con defense/res/slot, gioielli
