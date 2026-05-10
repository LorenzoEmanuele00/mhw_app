# ARCHITECTURE.md — Technical Architecture

## Stack

| Layer | Library | Target version |
|-------|---------|----------------|
| UI | Flutter | 3.x |
| Local DB | drift | ^2.33.x |
| Remote sync | supabase_flutter | ^2.9.x |
| State management | flutter_riverpod | ^3.1.x |
| Navigation | go_router | ^17.x |
| Connectivity | connectivity_plus | ^7.x |
| Path utilities | path_provider + path | ^2.x / ^1.x |
| i18n | flutter_localizations + intl | SDK / any |

Note: `sqlite3_flutter_libs` removed — drift 2.33+ uses `sqlite3 3.x` which includes SQLite bundled natively. `riverpod_annotation`/`riverpod_generator` removed — all providers are written manually (incompatible with drift_dev due to analyzer constraints).

## `lib/` structure (current state)

```
lib/
  core/
    database/
      tables/
        enums.dart          ← all enum types + TypeConverters (Dart-layer only)
        game_tables.dart    ← Weapons, ArmorPieces, ArmorSets, ArmorSetSkills,
                               Jewels, Skills, SkillLevels
        user_tables.dart    ← Talismans, Builds, BuildJewels, SyncMetadata
      daos/
        weapons_dao.dart
        armor_dao.dart
        skills_dao.dart     ← includes Jewels
        builds_dao.dart
        talismans_dao.dart
      database.dart         ← AppDatabase drift (schema v1)
      database.g.dart       ← GENERATED — do not edit
      seed_service.dart     ← loads assets/seeds/*.sql on first launch
    providers/
      database_provider.dart   ← Provider<AppDatabase>
      seed_provider.dart       ← seedInitProvider (FutureProvider<void>)
    router/
      router.dart              ← StatefulShellRoute, 3 branches
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
  l10n/
    app_en.arb               ← English strings template
    app_it.arb               ← Italian strings
    app_localizations.dart   ← GENERATED — do not edit
  shared/
    calc/
      skills_repository.dart    ← SkillsRepository + allSkillsProvider
      calc_engine.dart          ← (Phase 4 — to implement)
    models/                     ← (Phase 4 — pure dart classes)
    widgets/                    ← (Phase 6 — reusable widgets)
```

## Enum types

All limited-value text columns use typed enums with TypeConverters (Dart-layer only — SQL stores plain TEXT, no schema change needed).

| Enum | Stored values | Used in |
|------|--------------|---------|
| `WeaponType` | gs, ls, sns, db, hmr, hh, lan, gl, sa, cb, ig, lbg, hbg, bow | Weapons.weaponType |
| `ElementType` | fire, water, thunder, ice, dragon | Weapons.elementType (nullable) |
| `DamageType` | cut, impact, ranged | Weapons.damageType |
| `SharpnessLevel` | red, orange, yellow, green, blue, white, purple | Weapons.sharpnessMax |
| `ArmorSlotType` | head, chest, arms, waist, legs | ArmorPieces.slotType |
| `SkillCategory` | armor, group, series, weapon | Skills.type1 |
| `SkillSubcategory` | defensive, farming, offensive, regen, technical, utility | Skills.type2 |
| `SetSkillType` | group, series | ArmorSetSkills.skillCategory |
| `JewelSlotSource` | weapon, head, chest, arms, waist, legs, talisman | BuildJewels.slotSource |

## Architectural patterns

### Repository via Riverpod
Each feature exposes Riverpod providers wrapping drift DAOs (manual providers, no codegen):
```dart
final weaponsRepositoryProvider = Provider<WeaponsRepository>((ref) {
  return WeaponsRepository(ref.watch(databaseProvider));
});

final allWeaponsProvider = StreamProvider<List<Weapon>>((ref) {
  return ref.watch(weaponsRepositoryProvider).watchAll();
});
```

### DB reactivity
drift exposes `Stream<List<T>>` for queries — Riverpod wraps them in `StreamProvider`.
The builder screen uses `StateNotifierProvider` for mutable in-progress build state.

### Navigation
go_router with `ShellRoute` for bottom navigation bar with 3 tabs:
- `/equipment` (with sub-tabs managed internally)
- `/builds` → `/builds/:id`
- `/builder` → `/builder/new`, `/builder/:id`

### i18n
`flutter_localizations` + `intl`. Strings in `lib/l10n/app_en.arb` and `lib/l10n/app_it.arb`.
Generated code in `lib/l10n/app_localizations.dart` — do not edit manually.
To add a new language: add `app_XX.arb` and run `flutter gen-l10n`.

## Supabase sync

```
SyncService
  ├── checkAndSync()
  │   ├── connectivity check
  │   ├── fetch remote version per table
  │   ├── compare with local sync_metadata
  │   └── if outdated → downloadTable() → replaceLocal()
  └── downloadTable(tableName) → List<Map>
```

Tables synced (read-only): `weapons`, `armor_pieces`, `armor_sets`,
`armor_set_skills`, `jewels`, `skills`, `skill_levels`

Tables excluded from sync: `talismans`, `builds`, `build_jewels`, `sync_metadata`

## Codegen

```bash
# Regenerate drift code (run after every table change)
dart run build_runner build

# Regenerate i18n (run after every .arb change)
flutter gen-l10n
```

Generated files end in `.g.dart` or are in `lib/l10n/` — do not edit manually.
Note: `--delete-conflicting-outputs` has been removed from build_runner — do not use it.

## Testing

```bash
flutter test
```

Test structure:
```
test/
  database/
    tables/
      enums_test.dart    ← TypeConverter unit tests (pure Dart, no Flutter deps)
    daos/
      weapons_dao_test.dart  ← DAO integration tests (in-memory drift DB)
  widget_test.dart
```

For DAO integration tests, use `AppDatabase.forTesting(NativeDatabase.memory())`.
