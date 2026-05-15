# PROGRESS.md — Development Progress

Update this file at every session.

## Current phase: 4 — Stats Engine

### Phase 0: Setup ✅ COMPLETE
- [x] Flutter project created (`flutter create mhw_app`)
- [x] `/docs` folder created
- [x] `CLAUDE.md` written
- [x] `ARCHITECTURE.md` written
- [x] `DATA_MODEL.md` written
- [x] `CALC_ENGINE.md` written
- [x] `pubspec.yaml` updated with dependencies (drift, supabase, riverpod, go_router, connectivity_plus)
- [x] `lib/` folder structure created (core/features/shared)
- [x] Drift schema defined — game + user tables + DAO per domain
- [x] go_router configured with StatefulShellRoute (3 tabs placeholder — to be expanded to 4)
- [x] `main.dart` entry point configured with ProviderScope + MaterialApp.router
- [x] Drift codegen complete (zero warnings, zero errors)
- [x] `flutter analyze` → No issues found

### Phase 1: Data Layer ✅ COMPLETE (partial — Supabase deferred to Phase 5)
- [x] Python script `scripts/parse_excel.py` — extracts skills, weapon mods, motion values
- [x] SQL seeds: `01_skills.sql` (179 skills), `02_skill_levels.sql` (442 levels with pieces_required)
- [x] SQL seeds: `03_armor.sql` (194 sets, 714 pieces, 275 set-skills, 2119 piece-skills)
- [x] SQL seeds: `04_weapons.sql` (1188 weapons across 14 types)
- [x] SQL seeds: `05_jewels.sql` (361 jewels, 534 jewel-skill rows)
- [x] `scripts/generate_seeds_from_json.py` — skills from Skill.json + Excel calc cross-reference
- [x] `scripts/generate_game_data.py` — armor/weapons/jewels from merged JSON files
- [x] `SeedService` — loads all 5 SQL seeds on first launch if DB is empty
- [x] Repository layer: WeaponsRepository, ArmorRepository, JewelsRepository, TalismansRepository, BuildsRepository, SkillsRepository
- [x] Riverpod providers for all repositories + StreamProvider for lists
- [x] `main.dart` updated — seedInitProvider active, splash during init
- [x] `flutter analyze` → No issues found
- [ ] Supabase project created and schema loaded (→ Phase 5)
- [ ] Base sync working (→ Phase 5)

### Phase 1.5: Code quality ✅ COMPLETE
- [x] Enum types for all limited-value text columns (WeaponType, ElementType, DamageType,
      SharpnessLevel, ArmorSlotType, SkillCategory, SkillSubcategory, SetSkillType, JewelSlotSource)
- [x] TypeConverters — pure Dart-layer, no SQL schema change (stored values: lowercase snake_case)
- [x] ElementType extended: poison, sleep, paralysis, blast added
- [x] SkillCategory.series → SkillCategory.set; SetSkillType.series → SetSkillType.set
- [x] Seed `01_skills.sql` updated to lowercase type1/type2 values
- [x] All code, comments, and documentation translated to English
- [x] i18n infrastructure: flutter_localizations + intl, l10n.yaml, app_en.arb + app_it.arb
- [x] Automated tests: 43 tests (converter unit tests + DAO integration tests with in-memory DB)
- [x] `flutter analyze` → No issues found
- [x] `flutter test` → All 43 tests passed

---

### Phase 2: Equipment Browser ✅ COMPLETE

Deliver the Equipment tab. No build editing yet — items are read-only browsable.

**Routing & scaffold**
- [x] Update go_router to 4-tab StatefulShellRoute: Build / Equipment / Stats / Loadouts
- [x] Implement app-level theme tokens (light/dark, element colors, skill colors, sharpness colors)
- [x] Shared widgets: `GlyphTile`, `SlotGlyph`, `DecoSlotsRow`, `SkillChip`, `StatBar`, `SharpnessGauge`

**EquipmentScreen**
- [x] Segmented control: Weapons | Armor | Charm
- [x] Search field with real-time name filter
- [x] Weapon list: flat `EquipmentRow` list (name, attack/affinity, type, element, deco slots)
- [x] Armor list: grouped by slot type (Head / Chest / Arms / Waist / Legs) with section labels
- [x] Charm list: flat list (backed by talismans table)
- [x] `EquipmentRow` widget with "Equipped" badge support

**EquipmentDetail sheet (read-only)**
- [x] Hero: GlyphTile, type label + rarity badge, item name
- [x] Stats section: weapon → attack/affinity/element bars + sharpness gauge; armor → defense + 5 elemental res bars; charm → text note
- [x] Skills section: list with colored dot, name, description, +level
- [x] Decoration Slots section (read-only — no JewelPicker yet)

**Tests**
- [x] `ArmorDao.getPieceSkills` join query (3 tests)
- [x] Widget tests for EquipmentRow (weapon / armor / charm variants — 13 tests)
- [x] `flutter test` → 59/59 passed

---

### Phase 3: Build System ✅ COMPLETE

Deliver the Build tab and Loadouts tab with full slot management.

**BuildScreen**
- [x] WeaponHero card: icon tile, name, type label, deco slots row, Attack/Affinity/Element stat grid, SharpnessGauge
- [x] Empty weapon state: placeholder with "No weapon equipped"
- [x] ArmorSlotRow × 5 (head/chest/arms/waist/legs): slot icon, label, item name (or "Empty slot"), DEF value, deco slots, chevron
- [x] Charm slot row (no DEF value)
- [x] Active Skills panel: colored SkillChip list (sorted by level desc)
- [x] Quick Summary card: 2×2 grid (Attack, Defense, Affinity, Element)

**SlotPicker sheet**
- [x] Opens when tapping an empty slot (weapon/head/chest/arms/waist/legs/charm)
- [x] Clear button
- [x] Search field
- [x] Filtered list of items for that slot kind

**EquipmentDetail sheet (interactive)**
- [x] Interactive Decoration Slots (tap slot → opens JewelPicker)
- [x] "Equip" CTA when item not equipped; "Equipped" when already equipped
- [x] Equip actions call BuildNotifier and close sheet
- [x] Deco slots show jewels only for the equipped item; all others show empty slots

**JewelPicker sheet**
- [x] Slot info header (slot index + level)
- [x] Clear button
- [x] Search field (filter by jewel name or skill name)
- [x] "Available" section: jewels with level ≤ slot level
- [x] "Need a larger slot" section: jewels too large (dimmed, not tappable)
- [x] Checkmark on currently selected jewel

**Build state management**
- [x] `BuildNotifier` (Riverpod 3 `Notifier`) holding active build + decoration map
- [x] `ActiveBuildIdNotifier` (StateProvider replacement)
- [x] Actions: equipWeapon, equipArmor, equipCharm, setJewel, clearJewel
- [x] newBuild, loadBuild, renameBuild, deleteBuild
- [x] Persist to drift via BuildsRepository on every action
- [x] Skill aggregation from armor pieces + talisman + jewels (set bonuses → Phase 4)
- [x] Equipping a new piece clears its jewel slots automatically

**LoadoutsScreen**
- [x] Card list per saved build
- [x] LoadoutCard: name + "Active" badge, ATK/DEF mini stats, 7 slot dots (filled/empty)
- [x] Dialog actions: Rename (inline dialog), Delete (with ConfirmDialog)
- [x] "+ New" button → creates empty build + activates it
- [x] Empty state when no builds

**Tests**
- [x] Pre-existing 59 tests still passing
- [x] `flutter analyze` → No issues found
- [x] `flutter test` → 59/59 passed

---

### Phase 4: Stats Engine ⬜ TODO

Deliver the Stats tab with a live calc engine powering all stat displays.

**CalcEngine** (`lib/shared/calc/calc_engine.dart`)
- [ ] Skill aggregation: sum from weapon + 5 armor pieces + charm + jewels, capped at max_level per skill
- [ ] Set bonus activation: count armor pieces with same set_id, apply group/set skill levels
- [ ] True Raw: `base_attack × Π(atk_multiplier) + Σ(atk_additive)`
- [ ] Effective Affinity: `base_affinity + Σ(affinity_additive × uptime)`
- [ ] Crit multiplier: `0.25 × Π(crit_bonus_multiplier)` → affinity damage factor
- [ ] True Element: `base_element × 0.1 × Π(elem_multiplier) + Σ(elem_additive)`
- [ ] Sharpness: apply sharpness_max + handicraft levels → lookup raw/elem sharpness modifiers
- [ ] Defense: `Σ(armor_piece.base_defense) × Π(def_multiplier) + Σ(def_additive)`
- [ ] Elemental Resistances: `Σ(armor_piece.X_res) + Σ(X_res_additive)` for each element
- [ ] `BuildStats` model (pure Dart, no drift dependency)

**StatsScreen**
- [ ] Headline 2×2 card: Attack (red) / Defense (accent) / Affinity (orange/red) / Element (element color + type label)
- [ ] Sharpness section with SharpnessGauge + 7 segment labels
- [ ] Elemental Resistances: toggle Radar ↔ Bars
  - Radar: pentagon SVG chart, element labels + signed values at vertices
  - Bars: 5 signed StatBars, red fill for negatives
- [ ] Skills list: name, `Lv X / max` badge, description text, pip progress bar (colored segments)
- [ ] Decoration Slots summary: all slots from full build in a single DecoSlotsRow
- [ ] Compare button → placeholder alert (Phase 6)

**BuildScreen updates**
- [ ] Quick Summary uses real CalcEngine values (not raw weapon.attack)
- [x] Active Skills panel includes jewel skill contributions (set bonuses still Phase 4)

**Tests**
- [ ] CalcEngine unit tests: skill aggregation, true raw, effective affinity, defense, elemental res
- [ ] Set bonus activation test (2/4/5 piece combinations)
- [ ] `flutter test` → all pass

---

### Phase 5: Supabase Sync ⬜ TODO
- [ ] Supabase project created and schema loaded
- [ ] Connectivity detection (connectivity_plus)
- [ ] Version check: fetch `current_version` per table from Supabase
- [ ] Delta sync: if local version < remote → download + replace local rows
- [ ] Sync status UI indicator (small badge or inline text)

---

### Phase 6: Polish ⬜ TODO
- [ ] Equipment filters: by weapon type, rarity, element, skill
- [ ] Sorting: by name / attack / defense / rarity
- [ ] Filter UI (sheet or popover)
- [ ] Compare mode: side-by-side two builds on StatsScreen
- [ ] Talisman create/edit/delete UI (currently charm slots can only use seeded talismans)
- [ ] UI/UX refinement: animations, transitions, empty states

---

### Phase 7: Analytics — PostHog ⬜ TODO

Add product analytics via PostHog before production release. No PII collected — all events are anonymous game-app usage patterns.

**Package & setup**
- [ ] Add `posthog_flutter: ^5.x` to `pubspec.yaml`
- [ ] Add `shared_preferences: ^2.x` to `pubspec.yaml` (for persisting anonymous user ID)
- [ ] Create PostHog project (cloud or self-hosted) and obtain API key
- [ ] Add `POSTHOG_API_KEY` to `.env` / build config (never commit the key)

**AnalyticsService abstraction** (`lib/core/analytics/`)
- [ ] `analytics_service.dart` — abstract class with `capture()`, `identify()`, `screen()`, `reset()` methods
- [ ] `posthog_analytics_service.dart` — `PostHogAnalyticsService implements AnalyticsService`
- [ ] `noop_analytics_service.dart` — `NoopAnalyticsService` used in tests and debug builds
- [ ] `analytics_provider.dart` — Riverpod `Provider<AnalyticsService>` (returns PostHog in release, Noop in test)
- [ ] `anonymous_id_service.dart` — generates UUID v4 on first launch, persists via SharedPreferences

**Initialization** (`lib/main.dart`)
- [ ] Init PostHog before `runApp` with `PostHogConfig` (apiKey, host, captureApplicationLifecycleEvents: true, sessionReplay: false)
- [ ] Generate/load anonymous user ID; call `analyticsService.identify(anonymousId)` at startup
- [ ] Disable analytics in debug builds (or use a dev PostHog project)

**Navigation tracking** (`lib/core/router/router.dart`)
- [ ] Add `NavigatorObserver` subclass `AnalyticsNavigatorObserver` that calls `analyticsService.screen(routeName)` on each route change
- [ ] Register observer in `GoRouter` configuration
- Events tracked: `screen_viewed` with property `screen` (build / equipment / stats / loadouts)

**Build actions** (`lib/features/build/build_notifier.dart`)
- [ ] `build_created` — when `newBuild()` is called
- [ ] `build_loaded` — when `loadBuild()` is called (property: `build_id` hashed, not raw)
- [ ] `build_renamed` — when `renameBuild()` is called
- [ ] `build_deleted` — when `deleteBuild()` is called
- [ ] `item_equipped` — on `equipWeapon`, `equipArmor`, `equipCharm` (property: `slot_type`)
- [ ] `item_cleared` — on clear actions (property: `slot_type`)
- [ ] `jewel_equipped` — on `setJewel` (property: `slot_level`)
- [ ] `jewel_cleared` — on `clearJewel`

**Equipment search** (`lib/features/equipment/equipment_screen.dart`)
- [ ] `equipment_searched` — debounced, fired after 500ms of no input (properties: `segment`: weapons/armor/charm, `query_length`, `has_results`)

**Sync tracking** (Phase 5, `lib/core/sync/sync_service.dart`)
- [ ] `sync_completed` — properties: `tables_updated` count, `duration_ms`
- [ ] `sync_skipped` — when version already up-to-date
- [ ] `sync_failed` — property: `error_type` (no stack trace content)

**Error tracking**
- [ ] `error_occurred` — property: `feature_area` (build / equipment / stats / sync), `error_type` string (no user-identifiable content)
- [ ] Wire into top-level `FlutterError.onError` and `PlatformDispatcher.instance.onError` in `main.dart`

**Tests**
- [ ] Unit test `AnonymousIdService`: generates ID on first call, returns same ID on subsequent calls
- [ ] Unit test `NoopAnalyticsService`: all methods are no-ops, no throws
- [ ] Widget/integration tests: inject `NoopAnalyticsService` via provider override — no PostHog calls in test suite
- [ ] `flutter test` → all pass

---

## Session notes

### 2026-05-15 — Session 10
- Review fixes applied (from REVIEW.md — generic):
  - Equipping a new piece now clears its jewel slots: `equipWeapon/equipArmor/equipCharm` call `_clearJewelsForSource` before persisting if the item ID changed
  - Equipment tab deco slots: `_DecoSlotsCard` receives `buildState: null` for non-equipped items → empty slots, tap disabled
- Jewel skill contributions added to Build skill aggregation:
  - `_resolve` in `BuildNotifier` now fetches `jewel_skills`, builds a per-jewel lookup map, and folds each equipped jewel's skills into the shared `skillMap` with the same cap logic
  - Phase 4 remaining: set bonus activation, CalcEngine for stats
- `flutter analyze` → No issues found
- `flutter test` → 59/59 passed

### 2026-05-14 — Session 9
- Doc review and consistency check against real codebase
- Fixed `database.dart` `_seedSyncMetadata()`: added missing `armor_piece_skills` and `jewel_skills`
- Fixed `DATA_MODEL.md`: added missing `rarity` field to `jewels` table
- Written `docs/SUPABASE.md`: Postgres DDL, seed import order, RLS policies, Flutter config, SyncService outline
- Folder structure cleanup:
  - Deleted 4 stale placeholder screens (`armor_screen`, `weapons_screen`, `talismans_screen`, `jewels_screen`)
  - Consolidated `features/builds/` into `features/build/repository/` (was split inconsistently)
  - Flattened `features/equipment/{type}/repository/{type}_repository.dart` → `features/equipment/{type}/{type}_repository.dart`
  - Moved `features/jewels/widgets/jewel_picker_sheet.dart` → `features/equipment/widgets/jewel_picker_sheet.dart`
  - Removed now-empty `features/builds/` and `features/jewels/` folders
  - Updated all import paths across 4 callers; `flutter analyze` + `flutter test` → 59/59 ✓
- Updated `ARCHITECTURE.md` lib/ structure section to reflect current (not aspirational) state

### 2026-05-12 — Session 8
- Phase 3 (Build System) implemented from scratch
- `BuildNotifier` uses Riverpod 3.x `Notifier` (StateNotifier removed in 3.x)
- `ActiveBuildIdNotifier` replaces `StateProvider` (also removed in 3.x)
- `BuildScreen`: WeaponHero, ArmorSlotRow ×5, CharmSlotRow, Active Skills, Quick Summary
- `SlotPickerSheet`: generic sheet for weapon/armor/charm selection with search + clear
- `JewelPickerSheet`: per-slot deco picker with available/too-large sections, skill name search
- `EquipmentDetailSheet`: updated with "Equip" CTA and interactive deco slots
- `LoadoutsScreen`: card list with rename/delete dialogs and empty state
- `SkillsDao`: added `JewelSkills` to `@DriftAccessor`, added `getAllJewelSkills()` method
- `JewelsRepository`: added `allJewelSkillsProvider`
- l10n: 30+ new strings in EN + IT, `flutter gen-l10n` regenerated
- `dart run build_runner build` → 133 outputs (skills_dao.g.dart updated)
- `flutter analyze` → No issues found
- `flutter test` → 59/59 passed

### 2026-05-10 — Session 7
- Applied review fixes from REVIEW.md (equipment browsing screen):
  1. Weapons list now grouped by weapon type (14 sublists) — weapon type label removed from row
  2. Armor rows no longer show slot type label (redundant with section header)
  3. StatBar: signed bar center divider is now black; fill rectangle rounded at trailing end
- `equipment_row.dart`: removed `_typeLabel`, removed `_armorSlotName`, made `weaponTypeName` public
- `equipment_screen.dart`: replaced flat weapons list with grouped-by-type list
- Widget tests updated to match new row behavior (2 tests inverted)
- `flutter test` → 59/59 passed

### 2026-05-10 — Session 6
- Phase 2 tests completed: `ArmorDao.getPieceSkills` join tests (3) + `EquipmentRow` widget tests (13 — weapon/armor/charm variants)
- `flutter test` → 59/59 passed
- PROGRESS.md updated: Phase 2 marked ✅ COMPLETE, current phase set to 3

### 2026-05-10 — Session 5
- Design prototype reviewed (Claude Design zip in `/docs/mhw_app_design/`)
- Navigation revised: 3 tabs → 4 tabs (Build / Equipment / Stats / Loadouts)
- Builder tab removed — build editing is inline on Build tab via bottom sheets
- Jewels are NOT browseable in Equipment tab — accessible only through JewelPicker sheet
- Charm = Talisman in UI (label "Charm", DB table `talismans`)
- Phases 2–4 completely rewritten to match the actual design
- `ARCHITECTURE.md` updated: 4-tab routing, screen inventory, design tokens, lib structure
- `PROGRESS.md` updated: phases 2–6 task lists aligned to prototype

### 2026-05-07 — Session 4
- Review from REVIEW.md applied: source of truth for skills changed to `scripts/output/merged/Skill.json`
- `SkillCategory.series` → `SkillCategory.set`; `SetSkillType.series` → `SetSkillType.set`
- `ElementType` extended with poison, sleep, paralysis, blast
- `SkillLevels` table: added `pieces_required` nullable int (set/group activation threshold)
- `Jewels` table: replaced `skill_id`/`skill_level` with `allowed_on` text field (default "armor")
- New tables: `armor_piece_skills` (armor innate skills), `jewel_skills` (supports compound jewels)
- Schema bumped v3→v4; migrations: ALTER skill_levels + drop/recreate jewels + create 2 new tables
- `scripts/generate_seeds_from_json.py` — 179 skills from JSON, Excel cross-ref for calc bonuses
- `scripts/generate_game_data.py` — full game data from merged JSON files:
  - `03_armor.sql`: 194 sets, 714 pieces, 275 set-skills, 2119 piece-skills
  - `04_weapons.sql`: 1188 weapons across 14 types
  - `05_jewels.sql`: 361 jewels, 534 jewel-skill rows (173 compound jewels)
- Game JSON source files moved to `scripts/output/merged/` (not bundled in app)
- Automated tests expanded to 43 (added armor DAO tests + jewel DAO tests)
- `flutter analyze` → No issues found
- `flutter test` → All 43 tests passed

### 2026-05-05 — Session 1
- Project created from scratch on shared plan with user
- Stack chosen: drift + supabase + riverpod + go_router
- Primary data source: `/Users/loke/Downloads/Alpha Calulator.xlsx`
- Missing data (armor, base weapons, jewels) to be gathered externally
- MVP: aggregate stats (no DPH per hitzone — reserved for future phase)
- Talismans: user CRUD, local-only

### 2026-05-05 — Session 2
- Updated Flutter packages and dependencies (drift 2.33.0, sqlite3 3.3.1, flutter_riverpod 3.1.0, go_router 17.x)
- Removed unused or incompatible packages: `sqlite3_flutter_libs`, `riverpod_annotation`, `riverpod_generator`, `custom_lint`, `riverpod_lint`
- All providers written manually (no @riverpod codegen)
- `flutter pub outdated` — all direct packages at latest available version
- `flutter analyze` → No issues found
- Updated ARCHITECTURE.md (stack, provider pattern, codegen command)

### 2026-05-06 — Session 3
- Added enum types for all limited-value text columns + TypeConverters (Dart-layer only, no DB schema change)
- Updated seeds to use lowercase values for type1/type2 in skills table
- Set up i18n: flutter_localizations, intl, l10n.yaml, app_en.arb, app_it.arb
- Translated all Italian comments in code and documentation to English
- Added automated tests: 20 converter unit tests + 7 DAO integration tests (in-memory DB)
- `flutter analyze` → No issues found
- `flutter test` → 27/27 passed
