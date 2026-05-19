# SUPABASE.md — Setup e Sync del Progetto Supabase

## Panoramica

Supabase ospita i **dati di gioco** (armi, armature, gioielli, skill) in sola lettura.
L'app scarica queste tabelle al primo avvio o quando rileva una versione più recente.

I dati utente (build, talismani) rimangono **solo sul device** e non toccano mai Supabase.

---

## 1. Creare il progetto Supabase

1. Vai su [supabase.com](https://supabase.com) → New project
2. Nome suggerito: `mhw-wilds` (o simile)
3. Scegli una regione europea (Frankfurt / Paris)
4. Annota:
   - **Project URL**: `https://xxxxxxxxxxxx.supabase.co`
   - **Anon key**: `eyJ...` (dalla sezione Settings → API)

---

## 2. Schema DDL (esegui nell'SQL Editor di Supabase)

Esegui in quest'ordine per rispettare le FK.

> **Nota auto-increment**: Le tabelle `skills`, `armor_sets`, `armor_pieces`, `weapons`, `jewels`
> usano `INTEGER PRIMARY KEY` con ID espliciti nei seed (sono stabili e source-of-truth).
> Le tabelle `skill_levels`, `armor_set_skills`, `armor_piece_skills`, `jewel_skills`
> usano `GENERATED ALWAYS AS IDENTITY` perché i seed non includono la colonna `id`.

```sql
-- ─── Versioning (non sincronizzata nell'app) ───────────────────────────────
CREATE TABLE data_versions (
  table_name   TEXT PRIMARY KEY,
  version      INTEGER NOT NULL DEFAULT 1,
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Skills ───────────────────────────────────────────────────────────────
CREATE TABLE skills (
  id             INTEGER PRIMARY KEY,  -- ID numerico da Skill.json (source of truth)
  slug           TEXT UNIQUE NOT NULL,
  name           TEXT NOT NULL,
  description    TEXT,                 -- descrizione generale (English)
  description_it TEXT,                 -- descrizione generale (Italian)
  max_level      INTEGER NOT NULL,
  type1          TEXT NOT NULL DEFAULT 'armor',   -- armor/weapon/set/group
  type2          TEXT NOT NULL DEFAULT 'utility'  -- utility (subcategory)
);

CREATE TABLE skill_levels (
  id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  skill_id        INTEGER NOT NULL REFERENCES skills(id),
  level           INTEGER NOT NULL,
  description     TEXT,               -- descrizione del livello (English)
  description_it  TEXT,               -- descrizione del livello (Italian)
  pieces_required INTEGER,            -- solo per skill set/group
  bonus1_value    REAL,
  bonus1_type     TEXT,
  bonus2_value    REAL,
  bonus2_type     TEXT,
  bonus3_value    REAL,
  bonus3_type     TEXT,
  duration_s      REAL,
  cooldown_s      REAL
);

-- ─── Armor ────────────────────────────────────────────────────────────────
CREATE TABLE armor_sets (
  id    INTEGER PRIMARY KEY,
  slug  TEXT UNIQUE NOT NULL,
  name  TEXT NOT NULL
);

CREATE TABLE armor_pieces (
  id            INTEGER PRIMARY KEY,
  slug          TEXT UNIQUE NOT NULL,
  name          TEXT NOT NULL,
  slot_type     TEXT NOT NULL,          -- head/chest/arms/waist/legs
  base_defense  INTEGER NOT NULL DEFAULT 0,
  fire_res      INTEGER NOT NULL DEFAULT 0,
  water_res     INTEGER NOT NULL DEFAULT 0,
  thunder_res   INTEGER NOT NULL DEFAULT 0,
  ice_res       INTEGER NOT NULL DEFAULT 0,
  dragon_res    INTEGER NOT NULL DEFAULT 0,
  rarity        INTEGER NOT NULL DEFAULT 1,
  slots         TEXT NOT NULL DEFAULT '[]',  -- JSON array es. [2,1]
  set_id        INTEGER NOT NULL REFERENCES armor_sets(id)
);

CREATE TABLE armor_set_skills (
  id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  set_id          INTEGER NOT NULL REFERENCES armor_sets(id),
  required_pieces INTEGER NOT NULL,
  skill_id        INTEGER NOT NULL REFERENCES skills(id),
  skill_level     INTEGER NOT NULL,
  skill_category  TEXT NOT NULL  -- group/set
);

CREATE TABLE armor_piece_skills (
  id             INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  armor_piece_id INTEGER NOT NULL REFERENCES armor_pieces(id),
  skill_id       INTEGER NOT NULL REFERENCES skills(id),
  skill_level    INTEGER NOT NULL
);

-- ─── Weapons ──────────────────────────────────────────────────────────────
CREATE TABLE weapons (
  id             INTEGER PRIMARY KEY,
  slug           TEXT UNIQUE NOT NULL,
  name           TEXT NOT NULL,
  weapon_type    TEXT NOT NULL,          -- gs/ls/sns/db/hmr/hh/lan/gl/sa/cb/ig/lbg/hbg/bow
  base_attack    INTEGER NOT NULL,
  base_affinity  REAL NOT NULL DEFAULT 0.0,
  element_type   TEXT,                   -- fire/water/thunder/ice/dragon/poison/sleep/paralysis/blast
  element_value  INTEGER,
  sharpness_max  TEXT NOT NULL DEFAULT 'white',  -- red/orange/yellow/green/blue/white/purple
  rarity         INTEGER NOT NULL DEFAULT 1,
  slots          TEXT NOT NULL DEFAULT '[]',
  rmv            REAL NOT NULL DEFAULT 1.0,
  emv            REAL NOT NULL DEFAULT 1.0,
  damage_type    TEXT NOT NULL DEFAULT 'cut',    -- cut/impact/ranged
  burst_group    TEXT NOT NULL DEFAULT 'Other'
);

-- ─── Jewels ───────────────────────────────────────────────────────────────
CREATE TABLE jewels (
  id         INTEGER PRIMARY KEY,
  slug       TEXT UNIQUE NOT NULL,
  name       TEXT NOT NULL,
  rarity     INTEGER NOT NULL DEFAULT 1,
  slot_size  INTEGER NOT NULL,           -- 1/2/3/4
  allowed_on TEXT NOT NULL DEFAULT 'armor'  -- armor/weapon
);

CREATE TABLE jewel_skills (
  id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  jewel_id    INTEGER NOT NULL REFERENCES jewels(id),
  skill_id    INTEGER NOT NULL REFERENCES skills(id),
  skill_level INTEGER NOT NULL
);
```

---

## 3. Seed dati iniziali

I file seed sono già pronti in `assets/seeds/`. Sono SQL standard compatibile con Postgres.
Eseguili **in ordine** nell'SQL Editor di Supabase (uno alla volta o concatenati):

| Ordine | File                  | Contenuto                                           |
| ------ | --------------------- | --------------------------------------------------- |
| 1      | `01_skills.sql`       | 179 skill                                           |
| 2      | `02_skill_levels.sql` | 442 livelli con bonus tipizzati                     |
| 3      | `03_armor.sql`        | 194 set, 714 pezzi, 275 set-skill, 2119 piece-skill |
| 4      | `04_weapons.sql`      | 1188 armi                                           |
| 5      | `05_jewels.sql`       | 361 gioielli, 534 jewel-skill row                   |

Dopo il seeding, inserisci le versioni iniziali:

```sql
INSERT INTO data_versions (table_name, version) VALUES
  ('skills', 1),
  ('skill_levels', 1),
  ('armor_sets', 1),
  ('armor_pieces', 1),
  ('armor_set_skills', 1),
  ('armor_piece_skills', 1),
  ('weapons', 1),
  ('jewels', 1),
  ('jewel_skills', 1);
```

> **Nota FK — prima esecuzione su DB vuoto**: nessun problema, esegui i file nell'ordine indicato.
>
> **Nota FK — ri-esecuzione su dati esistenti**: il file `01_skills.sql` inizia con
> `DELETE FROM skill_levels; DELETE FROM skills;` che su Postgres fallisce per le FK.
> Usa invece `TRUNCATE skill_levels, skills, armor_set_skills, armor_piece_skills, jewel_skills CASCADE;`
> prima di ri-importare, oppure esegui i file in ordine inverso (prima i figli).
>
> **Nota seed formato**: i file `.sql` sono generati per SQLite (usati dal SeedService in-app).
> Su Postgres il dialetto è compatibile tranne per `AUTOINCREMENT` (usa `SERIAL` o `GENERATED ALWAYS`).
> I seed in `assets/seeds/` sono già compatibili Postgres perché non usano `AUTOINCREMENT` esplicito
> nei VALUES — gli id sono espliciti nei file 01/02, e gli altri file usano INSERT senza id.

---

## 4. Row Level Security (RLS)

Tutti i dati di gioco sono pubblicamente leggibili — nessuna autenticazione necessaria.

```sql
-- Abilita RLS su tutte le tabelle di gioco
ALTER TABLE skills             ENABLE ROW LEVEL SECURITY;
ALTER TABLE skill_levels       ENABLE ROW LEVEL SECURITY;
ALTER TABLE armor_sets         ENABLE ROW LEVEL SECURITY;
ALTER TABLE armor_pieces       ENABLE ROW LEVEL SECURITY;
ALTER TABLE armor_set_skills   ENABLE ROW LEVEL SECURITY;
ALTER TABLE armor_piece_skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE weapons            ENABLE ROW LEVEL SECURITY;
ALTER TABLE jewels             ENABLE ROW LEVEL SECURITY;
ALTER TABLE jewel_skills       ENABLE ROW LEVEL SECURITY;
ALTER TABLE data_versions      ENABLE ROW LEVEL SECURITY;

-- Policy lettura pubblica (anon key)
CREATE POLICY "public read" ON skills             FOR SELECT USING (true);
CREATE POLICY "public read" ON skill_levels       FOR SELECT USING (true);
CREATE POLICY "public read" ON armor_sets         FOR SELECT USING (true);
CREATE POLICY "public read" ON armor_pieces       FOR SELECT USING (true);
CREATE POLICY "public read" ON armor_set_skills   FOR SELECT USING (true);
CREATE POLICY "public read" ON armor_piece_skills FOR SELECT USING (true);
CREATE POLICY "public read" ON weapons            FOR SELECT USING (true);
CREATE POLICY "public read" ON jewels             FOR SELECT USING (true);
CREATE POLICY "public read" ON jewel_skills       FOR SELECT USING (true);
CREATE POLICY "public read" ON data_versions      FOR SELECT USING (true);
```

Nessuna policy INSERT/UPDATE/DELETE dai client — i dati di gioco si aggiornano solo via SQL Editor
o script amministrativi.

---

## 5. Configurazione Flutter

Crea `lib/core/supabase/supabase_config.dart`:

```dart
class SupabaseConfig {
  static const url = 'https://xxxxxxxxxxxx.supabase.co';
  static const anonKey = 'eyJ...';
}
```

> La anon key è una chiave pubblica — non è un segreto, può stare nel repo.

In `main.dart`, prima di `runApp()`:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/supabase/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  // ... seedInitProvider, runApp, ecc.
}
```

---

## 6. SyncService (da implementare in Phase 5)

```
lib/core/sync/
  sync_service.dart
```

Logica:

```dart
class SyncService {
  Future<void> checkAndSync() async {
    // 1. Controlla connettività (connectivity_plus)
    // 2. Fetch data_versions da Supabase (unica query, tutti i record)
    // 3. Per ogni tabella: confronta remote.version con local sync_metadata.last_version
    // 4. Se remote > local: scarica tutti i record della tabella → replaceLocal()
    // 5. Aggiorna sync_metadata.last_version + last_synced_at
  }
}
```

Le 9 tabelle sincronizzate (in ordine di dipendenza FK):

1. `skills`
2. `skill_levels`
3. `armor_sets`
4. `armor_pieces`
5. `armor_set_skills`
6. `armor_piece_skills`
7. `weapons`
8. `jewels`
9. `jewel_skills`

Il replace locale avviene all'interno di una transazione drift (`transaction()`):
DELETE all rows → INSERT new rows → UPDATE sync_metadata.

---

## 7. Aggiornare i dati di gioco (workflow futuro)

Quando escono nuovi dati (patch di gioco):

1. Rigenera i seed con gli script Python in `scripts/`
2. Carica i nuovi dati nel SQL Editor di Supabase (DELETE + INSERT)
3. Bumpa la versione:

```sql
UPDATE data_versions
SET version = version + 1, updated_at = NOW()
WHERE table_name IN ('weapons', 'armor_pieces'); -- solo le tabelle cambiate
```

4. Al prossimo avvio, l'app rileva il delta e scarica solo le tabelle aggiornate.
