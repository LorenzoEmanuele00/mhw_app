# ARCHITECTURE.md — Architettura Tecnica

## Stack

| Layer | Libreria | Versione target |
|-------|----------|----------------|
| UI | Flutter | 3.x |
| DB locale | drift | ^2.x |
| SQLite bindings | sqlite3_flutter_libs | ^0.x |
| Remote sync | supabase_flutter | ^2.x |
| State management | flutter_riverpod | ^2.x |
| Codegen (riverpod) | riverpod_annotation | ^2.x |
| Navigation | go_router | ^14.x |
| Connectivity | connectivity_plus | ^6.x |
| Path utilities | path_provider + path | ^2.x / ^1.x |

## Struttura `lib/`

```
lib/
  core/
    database/
      tables/           ← definizioni tabelle drift (1 file per tabella)
      daos/             ← DAO drift (query per dominio)
      database.dart     ← AppDatabase con tutti i DAO
    providers/
      database_provider.dart    ← Provider<AppDatabase>
      supabase_provider.dart    ← Provider<SupabaseClient>
      connectivity_provider.dart
    router/
      router.dart               ← go_router config, shell route
  features/
    equipment/
      weapons/
        widgets/
        weapons_screen.dart
        weapon_detail_screen.dart
      armor/
        widgets/
        armor_screen.dart
        armor_detail_screen.dart
      jewels/
        jewels_screen.dart
      talismans/
        widgets/
        talismans_screen.dart
        talisman_form_screen.dart
    builds/
      builds_screen.dart
      build_detail_screen.dart
    builder/
      widgets/
        slot_selector.dart
        jewel_slot_widget.dart
        stats_panel.dart
      builder_screen.dart
      builder_controller.dart
  shared/
    models/             ← classi pure dart (BuildStats, SkillEffect, ecc.)
    widgets/            ← widget riutilizzabili (SearchBar, FilterChips, ecc.)
    calc/
      calc_engine.dart  ← BuildStats computeStats(Build build, ...)
```

## Pattern architetturali

### Repository via Riverpod
Ogni feature espone provider Riverpod che wrappano i DAO drift:
```dart
@riverpod
WeaponsRepository weaponsRepository(WeaponsRepositoryRef ref) {
  return WeaponsRepository(ref.watch(databaseProvider));
}
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
# Generare codice drift e riverpod
flutter pub run build_runner build --delete-conflicting-outputs
```
File generati con `.g.dart` — non editare manualmente.
