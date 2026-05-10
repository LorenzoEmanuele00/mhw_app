# PROGRESS.md — Development Progress

Update this file at every session.

## Current phase: 3 — Build System

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

### Phase 3: Build System ⬜ TODO

Deliver the Build tab and Loadouts tab with full slot management.

**BuildScreen**
- [ ] WeaponHero card: icon tile, name, type + rarity badge, deco slots row, Attack/Affinity/Element stat grid, SharpnessGauge
- [ ] Empty weapon state: dashed placeholder with "No weapon equipped"
- [ ] ArmorSlotRow × 5 (head/chest/arms/waist/legs): slot icon, label, item name (or "Empty slot"), DEF value, deco slots, chevron
- [ ] Charm slot row (no DEF value)
- [ ] Active Skills panel: colored SkillChip list (sorted by level desc)
- [ ] Quick Summary card: 2×2 grid (Attack, Defense, Affinity, Element)

**SlotPicker sheet**
- [ ] Opens when tapping an empty slot (weapon/head/chest/arms/waist/legs/charm)
- [ ] Cancel + Clear buttons
- [ ] Search field
- [ ] Filtered list of items for that slot kind

**EquipmentDetail sheet (interactive)**
- [ ] Interactive Decoration Slots (tap slot → opens JewelPicker)
- [ ] "Equip to {buildName}" CTA when item not equipped
- [ ] "Change" CTA when item already equipped (navigates to Equipment tab filtered to that category)

**JewelPicker sheet**
- [ ] Slot info header (slot index + level)
- [ ] Cancel + Clear buttons
- [ ] Search field (filter by jewel name or skill name)
- [ ] "Available" section: jewels with level ≤ slot level
- [ ] "Need a larger slot" section: jewels too large (dimmed, not tappable)
- [ ] Checkmark on currently selected jewel

**Build state management**
- [ ] `BuildNotifier` (StateNotifier) holding active build + decoration map
- [ ] Actions: equip, clearSlot, setJewel, clearJewel
- [ ] Persist to drift via BuildsRepository on every action

**LoadoutsScreen**
- [ ] Swipeable card list with iOS Mail-style swipe-left actions
- [ ] LoadoutCard: name + "Active" badge, note, ATK/DEF mini stats, 7 slot icons (filled/empty), up to 4 skill chips + overflow count
- [ ] Swipe actions: Edit (rename via prompt), Delete (with ConfirmDialog)
- [ ] "+ New" button → creates empty build + activates it + switches to Build tab
- [ ] Empty state when no builds

**Tests**
- [ ] BuildNotifier unit tests (equip, setJewel, clearJewel, newBuild, deleteBuild)
- [ ] `flutter test` → all pass

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
- [ ] Active Skills panel uses CalcEngine aggregation (includes jewels + set bonuses)

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

## Session notes

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
