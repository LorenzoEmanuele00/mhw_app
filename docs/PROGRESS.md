# PROGRESS.md — Development Progress

Update this file at every session.

## Current phase: 2 — Equipment Browser

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
- [x] go_router configured with StatefulShellRoute (3 tabs: Equipment/Builds/Builder)
- [x] `main.dart` entry point configured with ProviderScope + MaterialApp.router
- [x] Drift codegen complete (zero warnings, zero errors)
- [x] `flutter analyze` → No issues found

### Phase 1: Data Layer ✅ COMPLETE (partial — Supabase deferred to Phase 5)
- [x] Python script `scripts/parse_excel.py` — extracts skills, weapon mods, motion values
- [x] SQL seeds generated: `01_skills.sql` (168 skills), `02_skill_levels.sql` (427 levels)
- [x] `03_weapon_mods.json` — RMV/EMV/sharpness for 14 weapon types
- [x] `04_motion_values.sql` — 1216 motion value entries (for future DPH calc)
- [x] `SeedService` — loads SQL seeds on first launch if DB is empty
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
- [x] Seed `01_skills.sql` updated to lowercase type1/type2 values
- [x] All code, comments, and documentation translated to English
- [x] i18n infrastructure: flutter_localizations + intl, l10n.yaml, app_en.arb + app_it.arb
- [x] Automated tests: 27 tests (converter unit tests + DAO integration tests with in-memory DB)
- [x] `flutter analyze` → No issues found
- [x] `flutter test` → All 27 tests passed

### Phase 2: Equipment Browser ⬜ TODO
- [ ] Weapon list screen with type filter
- [ ] Weapon detail screen
- [ ] Armor list screen with slot/set filter
- [ ] Armor detail screen
- [ ] Jewel list screen
- [ ] Talisman list screen
- [ ] Talisman create/edit/delete

### Phase 3: Build System ⬜ TODO
- [ ] Build list screen
- [ ] Builder screen — weapon slot
- [ ] Builder screen — 5 armor slots
- [ ] Builder screen — talisman slot
- [ ] Builder screen — dynamic jewel slots
- [ ] Save build

### Phase 4: Stats Engine ⬜ TODO
- [ ] Calc Engine: skill aggregation from build
- [ ] Calc Engine: True Raw
- [ ] Calc Engine: Effective Affinity
- [ ] Calc Engine: True Element
- [ ] Calc Engine: Defense + Elem Resistances
- [ ] Live stats panel in builder
- [ ] Stats view in build detail

### Phase 5: Supabase Sync ⬜ TODO
- [ ] Connectivity detection
- [ ] Version check
- [ ] Delta sync for game data tables
- [ ] Sync status UI indicator

### Phase 6: Polish ⬜ TODO
- [ ] Equipment filters (by type, rarity, skill)
- [ ] Text search
- [ ] Sorting
- [ ] UI/UX refinement

## Session notes

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
