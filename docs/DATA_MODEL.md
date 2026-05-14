# DATA_MODEL.md — Modelli Dati e Schema DB

## Tabelle dati di gioco (sync da Supabase)

### weapons
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| slug | TEXT UNIQUE | es. "gs_rathalos_blade" |
| name | TEXT | Nome visualizzato |
| weapon_type | TEXT | gs/ls/sns/db/hmr/hh/lan/gl/sa/cb/ig/bow/lbg/hbg |
| base_attack | INTEGER | Valore grezzo in-game |
| base_affinity | REAL | Es. 0.0, 0.15, -0.25 |
| element_type | TEXT? | fire/water/thunder/ice/dragon/poison/paralysis/sleep/blast |
| element_value | INTEGER? | Valore elemento grezzo |
| sharpness_max | TEXT | red/orange/yellow/green/blue/white/purple |
| rarity | INTEGER | 1-10 |
| slots | TEXT | JSON array es. [3,2,1] |
| rmv | REAL | Raw Motion Value modifier (da Weapon Modifier sheet) |
| emv | REAL | Element Motion Value modifier |
| damage_type | TEXT | cut/impact/ranged |
| burst_group | TEXT | GS_HH / DB / GL / Bowgun / Bow / Other |

### armor_pieces
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| slug | TEXT UNIQUE | |
| name | TEXT | |
| slot_type | TEXT | head/chest/arms/waist/legs |
| base_defense | INTEGER | |
| fire_res | INTEGER | |
| water_res | INTEGER | |
| thunder_res | INTEGER | |
| ice_res | INTEGER | |
| dragon_res | INTEGER | |
| rarity | INTEGER | |
| slots | TEXT | JSON array es. [2,1] |
| set_id | INTEGER FK → armor_sets | |

### armor_sets
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| slug | TEXT UNIQUE | |
| name | TEXT | Nome serie (es. "Rathalos", "Gore Magala") |

### armor_set_skills
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| set_id | INTEGER FK → armor_sets | |
| required_pieces | INTEGER | Quanti pezzi per attivare |
| skill_id | INTEGER FK → skills | |
| skill_level | INTEGER | |
| skill_category | TEXT | group / set |

### armor_piece_skills
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| armor_piece_id | INTEGER FK → armor_pieces | |
| skill_id | INTEGER FK → skills | |
| skill_level | INTEGER | Livelli forniti da questo pezzo |

### jewels
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| slug | TEXT UNIQUE | |
| name | TEXT | |
| rarity | INTEGER | 1-6 |
| slot_size | INTEGER | 1/2/3/4 |
| allowed_on | TEXT | "armor" / "weapon" — default "armor" |

### jewel_skills
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| jewel_id | INTEGER FK → jewels | |
| skill_id | INTEGER FK → skills | |
| skill_level | INTEGER | Livelli forniti (compound jewels: 2 righe per jewel) |

### skills
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK | Numeric ID from Skill.json (source of truth) |
| slug | TEXT UNIQUE | es. "attack_boost" |
| name | TEXT | Nome visualizzato (English) |
| max_level | INTEGER | |
| type1 | TEXT | armor / weapon / set / group |
| type2 | TEXT | utility (default — from Excel subcategory data) |

**type1 semantics:**
- `armor` / `weapon`: skill equippable on armor/weapon jewels (constrains jewel assignment)
- `set` / `group`: activated by equipping N armor pieces — no skill points needed

### skill_levels
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| skill_id | INTEGER FK → skills | |
| level | INTEGER | Skill rank (1, 2, 3 ...) |
| pieces_required | INTEGER? | For set/group only: armor pieces needed to activate this rank |
| bonus1_value | REAL? | |
| bonus1_type | TEXT? | Vedi tipi bonus sotto |
| bonus2_value | REAL? | |
| bonus2_type | TEXT? | |
| bonus3_value | REAL? | |
| bonus3_type | TEXT? | |
| duration_s | REAL? | Secondi attivo (per skill con uptime) |
| cooldown_s | REAL? | |

**Tipi bonus (bonus_type)**:
- `atk_multiplier` — moltiplica il raw attack
- `atk_additive` — aggiunge flat al raw attack
- `affinity_additive` — aggiunge % affinity (es. +10 = 0.10)
- `crit_bonus_multiplier` — moltiplica il danno critico
- `elem_multiplier` — moltiplica l'elemento
- `elem_additive` — aggiunge flat all'elemento
- `def_multiplier` — moltiplica la difesa
- `def_additive` — aggiunge flat alla difesa
- `elem_res_additive` — aggiunge resistenza elementale (tutti)
- `fire_res_additive`, `water_res_additive`, ecc.
- `sharpness_additive` — livelli handicraft (+10 per level)

---

## Tabelle utente (solo locale)

### talismans
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| name | TEXT | Nome custom utente |
| skill1_id | INTEGER? FK → skills | Prima skill |
| skill1_level | INTEGER? | |
| skill2_id | INTEGER? FK → skills | Seconda skill (opzionale) |
| skill2_level | INTEGER? | |
| slots | TEXT | JSON array es. [2,1] |
| created_at | INTEGER | Unix timestamp |

### builds
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| name | TEXT | Nome build |
| weapon_id | INTEGER? FK → weapons | |
| head_id | INTEGER? FK → armor_pieces | |
| chest_id | INTEGER? FK → armor_pieces | |
| arms_id | INTEGER? FK → armor_pieces | |
| waist_id | INTEGER? FK → armor_pieces | |
| legs_id | INTEGER? FK → armor_pieces | |
| talisman_id | INTEGER? FK → talismans | |
| created_at | INTEGER | |
| updated_at | INTEGER | |

### build_jewels
| Campo | Tipo | Note |
|-------|------|------|
| id | INTEGER PK autoincrement | |
| build_id | INTEGER FK → builds | |
| slot_source | TEXT | weapon/head/chest/arms/waist/legs/talisman |
| slot_index | INTEGER | 0-based index nello slot source |
| jewel_id | INTEGER FK → jewels | |

---

## sync_metadata (locale)
| Campo | Tipo | Note |
|-------|------|------|
| table_name | TEXT PK | |
| last_version | INTEGER | Versione dati scaricata |
| last_synced_at | INTEGER | Unix timestamp |

---

## Note sulle relazioni
- Una build aggrega skill da: weapon, 5 armor pieces, talisman, jewels
- I set bonus si attivano contando quanti pezzi dello stesso `set_id` sono in build
- I gioielli occupano slot fisici (weapon/head/chest/arms/waist/legs/talisman)
- Slot disponibili per fonte dipendono dal singolo equip (campo `slots` JSON)
