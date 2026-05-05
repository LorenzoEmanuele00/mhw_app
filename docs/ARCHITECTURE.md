# ARCHITECTURE.md — Architettura Tecnica

## Stack

| Layer | Libreria | Versione target |
|-------|----------|----------------|
| UI | Flutter | 3.x |
| DB locale | drift | ^2.33.x |
| Remote sync | supabase_flutter | ^2.9.x |
| State management | flutter_riverpod | ^3.1.x |
| Navigation | go_router | ^17.x |
| Connectivity | connectivity_plus | ^7.x |
| Path utilities | path_provider + path | ^2.x / ^1.x |

Note: `sqlite3_flutter_libs` rimosso — drift 2.33+ usa `sqlite3 3.x` che include SQLite bundled nativamente. `riverpod_annotation`/`riverpod_generator` rimossi — tutti i provider sono scritti manualmente (incompatibili con drift_dev per vincoli su analyzer).

## Struttura `lib/` (stato attuale)

```
lib/
  core/
    database/
      tables/
        game_tables.dart    ← Weapons, ArmorPieces, ArmorSets, ArmorSetSkills,
                               Jewels, Skills, SkillLevels
        user_tables.dart    ← Talismans, Builds, BuildJewels, SyncMetadata
      daos/
        weapons_dao.dart
        armor_dao.dart
        skills_dao.dart     ← include anche Jewels
        builds_dao.dart
        talismans_dao.dart
      database.dart         ← AppDatabase drift (schema v1)
      database.g.dart       ← GENERATO — non editare
      seed_service.dart     ← carica assets/seeds/*.sql al primo avvio
    providers/
      database_provider.dart   ← Provider<AppDatabase>
      seed_provider.dart       ← seedInitProvider (FutureProvider<void>)
    router/
      router.dart              ← StatefulShellRoute, 3 branch
  features/
    equipment/
      weapons/
        repository/weapons_repository.dart
        weapons_screen.dart      ← placeholder
      armor/
        repository/armor_repository.dart
        armor_screen.dart        ← placeholder
      jewels/
        repository/jewels_repository.dart
        jewels_screen.dart       ← placeholder
      talismans/
        repository/talismans_repository.dart
        talismans_screen.dart    ← placeholder
    builds/
      repository/builds_repository.dart
      builds_screen.dart         ← placeholder
    builder/
      builder_screen.dart        ← placeholder
  shared/
    calc/
      skills_repository.dart    ← SkillsRepository + allSkillsProvider
      calc_engine.dart          ← (Fase 4 — da implementare)
    models/                     ← (Fase 4 — classi pure dart)
    widgets/                    ← (Fase 6 — widget riutilizzabili)
```

## Pattern architetturali

### Repository via Riverpod
Ogni feature espone provider Riverpod che wrappano i DAO drift (provider manuali, no codegen):
```dart
final weaponsRepositoryProvider = Provider<WeaponsRepository>((ref) {
  return WeaponsRepository(ref.watch(databaseProvider));
});

final allWeaponsProvider = StreamProvider<List<Weapon>>((ref) {
  return ref.watch(weaponsRepositoryProvider).watchAll();
});
```

### Reattività DB
drift espone `Stream<List<T>>` per query — Riverpod li wrappa in `StreamProvider`.
Il builder screen usa `StateNotifierProvider` per stato mutable della build in corso.

### Navigazione
go_router con `ShellRoute` per bottom navigation bar a 3 tab:
- `/equipment` (con sub-tab gestiti internamente)
- `/builds` → `/builds/:id`
- `/builder` → `/builder/new`, `/builder/:id`

## Sync Supabase

```
SyncService
  ├── checkAndSync()
  │   ├── connectivity check
  │   ├── fetch remote version per tabella
  │   ├── compare con sync_metadata locale
  │   └── se outdated → downloadTable() → replaceLocal()
  └── downloadTable(tableName) → List<Map>
```

Tabelle sincronizzate (read-only): `weapons`, `armor_pieces`, `armor_sets`,
`armor_set_skills`, `jewels`, `skills`, `skill_levels`

Tabelle escluse dalla sync: `talismans`, `builds`, `build_jewels`, `sync_metadata`

## Codegen
```bash
# Generare codice drift (da eseguire dopo ogni modifica alle tabelle)
dart run build_runner build
```
File generati con `.g.dart` — non editare manualmente.
Nota: `--delete-conflicting-outputs` è stato rimosso da build_runner — non usarlo.
