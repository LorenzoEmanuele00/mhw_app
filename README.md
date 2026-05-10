# MHW Builder

Character builder per **Monster Hunter Wilds**. Permette di creare e gestire build di equipaggiamento calcolando le statistiche aggregate risultanti (True Raw, Effective Affinity, True Element, Defense, Elemental Resistances).

Progetto standalone — non dipende da API di gioco.

---

## Funzionalità

- **Equipment browser** — sfoglia armi, armature, gioielli e talismani
- **Talisman manager** — crea e gestisce talismani custom con skill e slot personalizzati
- **Build creator** — assembla una build scegliendo weapon + 5 pezzi armatura + talisman + gioielli
- **Stats panel** — visualizza le statistiche calcolate in tempo reale durante la costruzione
- **Sync automatico** — quando disponibile la connessione, scarica dati di gioco aggiornati da Supabase

---

## Stack tecnico

| Layer | Libreria |
|-------|----------|
| UI | Flutter 3.x (iOS + Android) |
| DB locale | drift (SQLite type-safe) |
| Remote sync | supabase_flutter |
| State management | flutter_riverpod |
| Navigation | go_router |
| Connectivity | connectivity_plus |

---

## Prerequisiti

- Flutter SDK ≥ 3.9.x
- Dart SDK ≥ 3.9.x
- Python 3.9+ (solo per rigenerare i seed dall'Excel)

---

## Avvio rapido

```bash
# 1. Installa le dipendenze
flutter pub get

# 2. Avvia su simulatore o device
flutter run
```

Al primo avvio l'app carica automaticamente i dati di skill e weapon modifiers dal seed bundled (`assets/seeds/`). Non è richiesta connessione internet.

---

## Struttura del progetto

```
mhw_app/
├── lib/
│   ├── core/
│   │   ├── database/       ← schema drift, DAO, SeedService
│   │   ├── providers/      ← provider database e seed init
│   │   └── router/         ← go_router (3 tab shell)
│   ├── features/
│   │   ├── equipment/      ← weapons / armor / jewels / talismans
│   │   ├── builds/         ← lista e dettaglio build
│   │   └── builder/        ← creazione/modifica build
│   └── shared/
│       └── calc/           ← SkillsRepository, CalcEngine (Fase 4)
├── assets/
│   └── seeds/              ← SQL seed bundled (skills, skill_levels)
├── scripts/
│   ├── parse_excel.py      ← estrae dati dall'Excel sorgente
│   └── seeds/              ← output dello script (SQL + JSON)
└── docs/
    ├── ARCHITECTURE.md     ← stack e struttura dettagliata
    ├── DATA_MODEL.md       ← schema DB completo
    ├── CALC_ENGINE.md      ← formule di calcolo
    └── PROGRESS.md         ← stato avanzamento fasi
```

---

## Comandi utili

```bash
# Rigenerare codice drift dopo modifiche alle tabelle
dart run build_runner build --delete-conflicting-outputs

# Analisi statica
flutter analyze

# Rigenerare i seed dall'Excel sorgente
python3 scripts/parse_excel.py
# → output in scripts/seeds/
# → copiare 01_skills.sql e 02_skill_levels.sql in assets/seeds/
```

---

## Dati di gioco

I dati di skill (168 skill, 427 livelli) e weapon modifiers (14 tipi arma + sharpness) sono stati estratti da `Alpha Calulator.xlsx` tramite `scripts/parse_excel.py`.

I dati di armature, armi (stats base) e gioielli sono ancora da raccogliere e verranno aggiunti a Supabase nelle fasi successive.

---

## Roadmap

| Fase | Stato | Descrizione |
|------|-------|-------------|
| 0 — Setup | ✅ | Progetto, dipendenze, DB schema, routing |
| 1 — Data layer | ✅ | Seed Excel, repository, SeedService |
| 2 — Equipment browser | ⏳ | Liste armi/armature/gioielli + CRUD talismani |
| 3 — Build system | ⬜ | Builder UI, slot management, salvataggio |
| 4 — Stats engine | ⬜ | Calc Engine MVP, stats panel live |
| 5 — Supabase sync | ⬜ | Sync dati di gioco con versioning |
| 6 — Polish | ⬜ | Filtri, ricerca, sorting, UI refinement |

Vedere `docs/PROGRESS.md` per il dettaglio delle singole task.
