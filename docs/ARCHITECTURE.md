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

---

## Navigation — 4-tab bottom bar

The app has **4 tabs** (not 3). There is **no separate Builder tab** — build editing happens inline on the Build tab via bottom sheets.

```
Bottom Nav (4 tabs):
├── /build       ← active build view + inline slot editing (Build tab)
├── /equipment   ← browse weapons/armor/charms (Equipment tab)
├── /stats       ← detailed stats for active build (Stats tab)
└── /loadouts    ← saved build list with swipe actions (Loadouts tab)
```

go_router uses `StatefulShellRoute` with 4 branches. All editing flows (slot picker, item detail, jewel picker) are **bottom sheets** layered over the current tab — no push navigation.

### Routes
| Route | Screen | Notes |
|-------|--------|-------|
| `/build` | `BuildScreen` | Default tab |
| `/equipment` | `EquipmentScreen` | Sub-category managed with Segmented control |
| `/stats` | `StatsScreen` | Radar/Bars toggle for resistances |
| `/loadouts` | `LoadoutsScreen` | Swipeable card list |

---

## Screen inventory

### BuildScreen (`/build`)
- Large title "Build" + active build name as subtitle
- **WeaponHero card**: weapon icon, name, type tag, rarity badge, deco slots row; stat grid (Attack / Affinity / Element); sharpness gauge bar
- **ArmorSlotRow** × 5: each row shows slot icon, slot label, item name (or "Empty slot"), DEF value, deco slots row, chevron
- **Charm slot row**: same as armor but no DEF value
- **Active Skills panel**: colored skill chips with level/max (real-time aggregation from build)
- **Quick Summary**: 2×2 grid (Attack, Defense, Affinity, Element)
- Tap filled slot → opens **EquipmentDetail sheet**
- Tap empty slot → opens **SlotPicker sheet**

### EquipmentScreen (`/equipment`)
- Large title "Equipment" + item count subtitle + Filter button
- Search field (real-time filter by name)
- **Segmented control**: Weapons | Armor | Charm (3 categories — NO jewels browser)
  - Weapons: flat list
  - Armor: grouped by slot type (Head / Chest / Arms / Waist / Legs sections)
  - Charm: flat list (maps to talismans DB table)
- Each row: `EquipmentRow` (GlyphTile, name, main stat, type, element, deco slots, chevron, "Equipped" badge)
- Tap row → opens **EquipmentDetail sheet**

### StatsScreen (`/stats`)
- Large title "Stats" + active build name + Compare button (placeholder)
- Headline 2×2 grid: Attack / Defense / Affinity / Element (large colored numbers)
- **Sharpness section**: sharpness gauge bar + 7 segment labels (red→orange→yellow→green→blue→white→purple)
- **Elemental Resistances**: toggle Radar chart ↔ Bars (5 elements, signed scale)
- **Skills list**: each entry shows name, level/max badge, description, pip progress bar
- **Decoration Slots summary**: all slots from equipped gear in a single row

### LoadoutsScreen (`/loadouts`)
- Large title "Loadouts" + count subtitle + "+ New" button
- **SwipeableLoadoutRow** per saved build:
  - Card content: name + "Active" badge (if current), note subtitle, ATK/DEF mini stats, 7 slot icons (filled/empty), up to 4 skill chips + overflow count
  - Swipe left → reveals Edit (gray) + Delete (red) action buttons (iOS Mail style)
  - Tap → loads that build
  - Edit → rename via inline prompt
  - Delete → ConfirmDialog (iOS-style alert)
- Empty state when no builds exist

### Bottom Sheets (layered over any tab)
| Sheet | Trigger | Content |
|-------|---------|---------|
| **EquipmentDetail** | Tap equipped slot or equipment row | Hero icon, type/rarity, stats bars, skills list, interactive deco slots, Equip/Change CTA |
| **SlotPicker** | Tap empty slot | Cancel/Clear, search field, list of items for that kind |
| **JewelPicker** | Tap deco slot in EquipmentDetail | Cancel/Clear, slot info, search, "Available" list + "Need larger slot" dimmed list |

---

## Design tokens (Flutter theme)

Defined in `lib/shared/theme/`:

```dart
// Light/Dark semantic tokens
bg, card, card2, label, label2, label3, sep, fill, chip, overlay, barTrack, tabBar

// Accent colors (user-selectable in future): blue, orange, green, purple, graphite
// Element colors: fire, water, thunder, ice, dragon
// Skill colors: red, orange, green, blue, cyan, purple, gray
// Sharpness colors: red, orange, yellow, green, blue, white, purple
```

---

## `lib/` structure (target)

```
lib/
  core/
    database/
      tables/
        enums.dart          ← all enum types + TypeConverters (Dart-layer only)
        game_tables.dart    ← Weapons, ArmorPieces, ArmorSets, ArmorSetSkills,
                               Jewels, Skills, SkillLevels, ArmorPieceSkills, JewelSkills
        user_tables.dart    ← Talismans, Builds, BuildJewels, SyncMetadata
      daos/
        weapons_dao.dart
        armor_dao.dart
        skills_dao.dart
        jewels_dao.dart
        builds_dao.dart
        talismans_dao.dart
      database.dart         ← AppDatabase drift
      database.g.dart       ← GENERATED — do not edit
      seed_service.dart     ← loads assets/seeds/*.sql on first launch
    providers/
      database_provider.dart
      seed_provider.dart
    router/
      router.dart           ← StatefulShellRoute, 4 branches
  features/
    build/
      build_screen.dart         ← Build tab (weapon hero + armor slots + charm + skills + summary)
      widgets/
        weapon_hero.dart
        armor_slot_row.dart
        active_skills_panel.dart
        quick_summary.dart
    equipment/
      equipment_screen.dart     ← Equipment tab (segmented: weapons/armor/charm)
      widgets/
        equipment_row.dart
        equipment_detail_sheet.dart
        slot_picker_sheet.dart
      weapons/
        repository/weapons_repository.dart
      armor/
        repository/armor_repository.dart
      talismans/
        repository/talismans_repository.dart
    stats/
      stats_screen.dart         ← Stats tab (headline + sharpness + resistances + skills)
      widgets/
        resistance_radar.dart
        sharpness_gauge.dart
        skill_pip_row.dart
    loadouts/
      loadouts_screen.dart      ← Loadouts tab (swipeable build cards)
      widgets/
        loadout_card.dart
        swipeable_row.dart
    jewels/
      repository/jewels_repository.dart
      widgets/
        jewel_picker_sheet.dart
  shared/
    theme/
      app_theme.dart            ← ThemeData + token constants
    widgets/
      deco_slots_row.dart
      glyph_tile.dart
      slot_glyph.dart
      skill_chip.dart
      stat_bar.dart
      sheet.dart                ← reusable bottom sheet wrapper
      segmented_control.dart
    calc/
      calc_engine.dart          ← (Phase 4)
    models/
      build_stats.dart          ← (Phase 4 — aggregate result)
  l10n/
    app_en.arb
    app_it.arb
    app_localizations.dart      ← GENERATED
```

---

## Enum types

All limited-value text columns use typed enums with TypeConverters (Dart-layer only — SQL stores plain TEXT).

| Enum | Stored values | Used in |
|------|--------------|---------|
| `WeaponType` | gs, ls, sns, db, hmr, hh, lan, gl, sa, cb, ig, lbg, hbg, bow | Weapons.weaponType |
| `ElementType` | fire, water, thunder, ice, dragon, poison, sleep, paralysis, blast | Weapons.elementType (nullable) |
| `DamageType` | cut, impact, ranged | Weapons.damageType |
| `SharpnessLevel` | red, orange, yellow, green, blue, white, purple | Weapons.sharpnessMax |
| `ArmorSlotType` | head, chest, arms, waist, legs | ArmorPieces.slotType |
| `SkillCategory` | armor, group, set, weapon | Skills.type1 |
| `SkillSubcategory` | defensive, farming, offensive, regen, technical, utility | Skills.type2 |
| `SetSkillType` | group, set | ArmorSetSkills.skillCategory |
| `JewelSlotSource` | weapon, head, chest, arms, waist, legs, talisman | BuildJewels.slotSource |

---

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

### Build state
The active build is held in a `StateNotifierProvider<BuildNotifier, Build>`. Sheets dispatch actions (equip, setJewel, clearJewel) that the notifier applies, then persists to drift via `BuildsRepository`.

### DB reactivity
drift exposes `Stream<List<T>>` for queries — Riverpod wraps them in `StreamProvider`.

### Bottom sheets
Sheets are stateless widgets pushed over the current route via `showModalBottomSheet`. They receive a dispatch callback and do not navigate.

### Charm = Talisman
In the UI and design, the talisman slot is labeled "Charm". Internally (DB table, enum) it remains `talisman` / `talismans`.

---

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
`armor_set_skills`, `armor_piece_skills`, `jewels`, `jewel_skills`, `skills`, `skill_levels`

Tables excluded from sync: `talismans`, `builds`, `build_jewels`, `sync_metadata`

---

## Codegen

```bash
# Regenerate drift code (run after every table change)
dart run build_runner build

# Regenerate i18n (run after every .arb change)
flutter gen-l10n
```

Generated files end in `.g.dart` or are in `lib/l10n/` — do not edit manually.
Note: `--delete-conflicting-outputs` has been removed from build_runner — do not use it.

---

## Testing

```bash
flutter test
```

Test structure:
```
test/
  database/
    tables/
      enums_test.dart
    daos/
      weapons_dao_test.dart
      armor_dao_test.dart
      jewels_dao_test.dart
  widget_test.dart
```

For DAO integration tests, use `AppDatabase.forTesting(NativeDatabase.memory())`.
