#!/usr/bin/env python3
"""
parse_excel.py — Estrae dati da Alpha Calulator.xlsx e genera SQL seed.

Output (in scripts/seeds/):
  01_skills.sql         → INSERT per tabella skills
  02_skill_levels.sql   → INSERT per tabella skill_levels
  03_weapon_mods.json   → reference per RMV/EMV/sharpness per tipo arma
  04_motion_values.sql  → INSERT per tabella motion_values (uso futuro DPH)
"""

import sys
import json
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Optional

EXCEL_PATH = Path('/Users/loke/Downloads/Alpha Calulator.xlsx')
OUTPUT_DIR = Path(__file__).parent / 'seeds'
OUTPUT_DIR.mkdir(exist_ok=True)

# ─── Fogli Excel ────────────────────────────────────────────────────────────
SHEET_SKILL_DATA    = 20   # Skill Data
SHEET_WEAPON_MODS   = 19   # Weapon Modifier
WEAPON_SHEETS = {
    'gs':  (4,  'Greatsword'),
    'ls':  (5,  'Longsword'),
    'sns': (6,  'Sword and Shield'),
    'db':  (7,  'Dual Blades'),
    'hmr': (8,  'Hammer'),
    'hh':  (9,  'Hunting Horn'),
    'lan': (10, 'Lance'),
    'gl':  (11, 'Gunlance'),
    'sa':  (12, 'Switch Axe'),
    'cb':  (13, 'Charge Blade'),
    'ig':  (14, 'Insect Glaive'),
    'bow': (15, 'Bow'),
    'lbg': (16, 'Light Bowgun'),
    'hbg': (17, 'Heavy Bowgun'),
}

# ─── Normalizzazione bonus_type ──────────────────────────────────────────────
# Mappa dal testo grezzo dell'Excel al tipo standard usato dal calc engine.
# Tipi non mappati vengono mantenuti as-is (utility/meccaniche speciali).
BONUS_TYPE_MAP = {
    # Attacco raw
    'Additive (raw)':          'atk_additive',
    'Addetive (raw)':          'atk_additive',
    'additive (raw)':          'atk_additive',
    'Additive(raw)':           'atk_additive',
    'additive(raw)':           'atk_additive',
    'Addative (raw)':          'atk_additive',
    'Moltiplier (raw)':        'atk_multiplier',
    'Moltiplier (Raw)':        'atk_multiplier',
    'Moltiplier (raw damage)': 'atk_multiplier',
    'Moltiplier':              'atk_multiplier',   # Ambush/Bludgeoner/Airborne
    'Moltiplier (dmg)':        'atk_multiplier',
    'Moltiplier (damage)':     'atk_multiplier',
    'Moltipier (raw damage)':  'atk_multiplier',
    'M':                       'atk_multiplier',   # typo in Dark Arts row

    # Affinity
    'Additive (aff)':          'affinity_additive',
    'Additive(aff)':           'affinity_additive',
    'additive (aff)':          'affinity_additive',
    'Addettive (aff)':         'affinity_additive',
    'Addettive(aff)':          'affinity_additive',
    'Additive(aff)':           'affinity_additive',
    'Addettive (aff)':         'affinity_additive',
    '0.3':                     'affinity_additive',  # Buttery Leathercraft typo

    # Critico
    'Crit damage':             'crit_bonus',
    'Moltiplier (elem crit mod)': 'crit_elem_multiplier',

    # Elemento
    'Moltiplier (elem)':       'elem_multiplier',
    'Moltiplier (Elem)':       'elem_multiplier',
    'Moltiplier (elem)':       'elem_multiplier',
    'Additive (elem)':         'elem_additive',
    'Additive(elem)':          'elem_additive',
    'additive (elem)':         'elem_additive',
    'Additive(dragon)':        'elem_additive',
    'Additive (elem)':         'elem_additive',
    'Additive (Elem)':         'elem_additive',
    'Moltiplier (elem)':       'elem_multiplier',
    'Moltiplier (coatings)':   'elem_multiplier',   # Bladescale Loading
    'Moltiplier (elem)':       'elem_multiplier',

    # Difesa
    'Moltiplier (def)':        'def_multiplier',
    'Moltiplier (def)':        'def_multiplier',
    'Additive(def)':           'def_additive',
    'Additive (def)':          'def_additive',
    'Addetive (def)':          'def_additive',
    'Addetive(def)':           'def_additive',
    'Addetive (elem def)':     'def_additive',

    # Resistenza elementale
    'Additive (elem def)':     'elem_res_additive',
    'Additive(elem def)':      'elem_res_additive',
    'Additive (elem def)':     'elem_res_additive',

    # Sharpness
    'Additional (sharpness hits )': 'sharpness_additive',
    'Additional sharpness hits ':   'sharpness_additive',
    'Moltiplier (Sharpness hits)':  'sharpness_consumption_multiplier',
    'Sharpness modifier':           'sharpness_modifier',
}

def normalize_bonus_type(raw: Optional[str]) -> Optional[str]:
    if raw is None:
        return None
    return BONUS_TYPE_MAP.get(raw.strip(), raw.strip())

# ─── Utilità Excel ───────────────────────────────────────────────────────────

def get_shared_strings(z: zipfile.ZipFile) -> list[str]:
    ns = {'x': 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'}
    root = ET.fromstring(z.read('xl/sharedStrings.xml'))
    result = []
    for si in root.findall('.//x:si', ns):
        parts = si.findall('.//x:t', ns)
        result.append(''.join(p.text or '' for p in parts))
    return result

def parse_sheet(z: zipfile.ZipFile, sheet_num: int, ss: list[str]) -> list[list]:
    ns = {'x': 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'}
    root = ET.fromstring(z.read(f'xl/worksheets/sheet{sheet_num}.xml'))
    rows = []
    for row_el in root.findall('.//x:row', ns):
        row = []
        for cell in row_el.findall('x:c', ns):
            t = cell.get('t', '')
            v = cell.find('x:v', ns)
            if v is not None and v.text is not None:
                row.append(ss[int(v.text)] if t == 's' else v.text)
            else:
                row.append(None)
        rows.append(row)
    return rows

def safe_float(v) -> Optional[float]:
    try:
        return float(v) if v is not None else None
    except (ValueError, TypeError):
        return None

def sql_str(v) -> str:
    """Wrap value as SQL string or NULL."""
    if v is None:
        return 'NULL'
    return "'" + str(v).replace("'", "''") + "'"

def sql_float(v) -> str:
    f = safe_float(v)
    return str(f) if f is not None else 'NULL'

def to_slug(name: str) -> str:
    """Convert display name to slug id."""
    import re
    s = name.strip().lower()
    s = re.sub(r"[''`]", '', s)
    s = re.sub(r'[^a-z0-9]+', '_', s)
    s = s.strip('_')
    return s

# ─── Skill Data ──────────────────────────────────────────────────────────────

def parse_skills(z: zipfile.ZipFile, ss: list[str]):
    rows = parse_sheet(z, SHEET_SKILL_DATA, ss)
    # header row is row[0]: ['ID Skill','Level','Skill type 1','Skill Type 2',
    #   'Bonus 1','Type Bonus 1','Bonus 2','Type Bonus 2','Bonus 3','Type Bonus 3',
    #   'Duration (s)','Cooldown (s)']

    skills: dict[str, dict] = {}    # slug → {name, max_level, type1, type2}
    skill_levels: list[dict] = []

    for row in rows[1:]:
        # Pad row to at least 12 cols
        row = (row + [None] * 12)[:12]
        name, level_raw, type1, type2, \
            b1v, b1t, b2v, b2t, b3v, b3t, \
            duration, cooldown = row

        if not name or not level_raw:
            continue

        name = str(name).strip()
        level = int(float(level_raw))
        type1 = str(type1).strip() if type1 else 'Armor'
        type2 = str(type2).strip() if type2 else 'Utility'
        slug = to_slug(name)

        if slug not in skills:
            skills[slug] = {
                'id': slug,
                'name': name,
                'max_level': level,
                'type1': type1,
                'type2': type2,
            }
        else:
            # Aggiorna max_level se questo livello è maggiore
            if level > skills[slug]['max_level']:
                skills[slug]['max_level'] = level
            # Correggi type1/type2 se erano None
            if skills[slug]['type1'] == 'Armor' and type1 != 'Armor':
                skills[slug]['type1'] = type1
            if skills[slug]['type2'] == 'Utility' and type2 != 'Utility':
                skills[slug]['type2'] = type2

        skill_levels.append({
            'skill_id':    slug,
            'level':       level,
            'bonus1_value': safe_float(b1v),
            'bonus1_type':  normalize_bonus_type(b1t),
            'bonus2_value': safe_float(b2v),
            'bonus2_type':  normalize_bonus_type(b2t),
            'bonus3_value': safe_float(b3v),
            'bonus3_type':  normalize_bonus_type(b3t),
            'duration_s':   safe_float(duration),
            'cooldown_s':   safe_float(cooldown),
        })

    return list(skills.values()), skill_levels

def write_skills_sql(skills: list[dict], skill_levels: list[dict]):
    # File 01_skills.sql
    with open(OUTPUT_DIR / '01_skills.sql', 'w', encoding='utf-8') as f:
        f.write('-- Generato da parse_excel.py\n')
        f.write('-- Source: Alpha Calulator.xlsx, Sheet "Skill Data"\n\n')
        f.write('DELETE FROM skill_levels;\n')
        f.write('DELETE FROM skills;\n\n')
        f.write('INSERT INTO skills (id, name, max_level, type1, type2) VALUES\n')
        rows = []
        for s in skills:
            rows.append(
                f"  ({sql_str(s['id'])}, {sql_str(s['name'])}, "
                f"{s['max_level']}, {sql_str(s['type1'])}, {sql_str(s['type2'])})"
            )
        f.write(',\n'.join(rows))
        f.write(';\n')

    # File 02_skill_levels.sql
    with open(OUTPUT_DIR / '02_skill_levels.sql', 'w', encoding='utf-8') as f:
        f.write('-- Generato da parse_excel.py\n')
        f.write('-- Source: Alpha Calulator.xlsx, Sheet "Skill Data"\n\n')
        f.write('INSERT INTO skill_levels '
                '(skill_id, level, bonus1_value, bonus1_type, '
                'bonus2_value, bonus2_type, bonus3_value, bonus3_type, '
                'duration_s, cooldown_s) VALUES\n')
        rows = []
        for sl in skill_levels:
            rows.append(
                f"  ({sql_str(sl['skill_id'])}, {sl['level']}, "
                f"{sql_float(sl['bonus1_value'])}, {sql_str(sl['bonus1_type'])}, "
                f"{sql_float(sl['bonus2_value'])}, {sql_str(sl['bonus2_type'])}, "
                f"{sql_float(sl['bonus3_value'])}, {sql_str(sl['bonus3_type'])}, "
                f"{sql_float(sl['duration_s'])}, {sql_float(sl['cooldown_s'])})"
            )
        f.write(',\n'.join(rows))
        f.write(';\n')

# ─── Weapon Modifiers ────────────────────────────────────────────────────────

def parse_weapon_mods(z: zipfile.ZipFile, ss: list[str]) -> dict:
    rows = parse_sheet(z, SHEET_WEAPON_MODS, ss)
    # header: Weapon, RMV, EMV, Type of Damage, Burst modifier, Sharpness, Raw Mod, Ele Mod, ...

    SHARPNESS_ORDER = ['Red', 'Orange', 'Yellow', 'Green', 'Blue', 'White', 'Purple']

    weapon_mods = {}
    sharpness_mods = {}

    for row in rows[1:]:
        row = (row + [None] * 18)[:18]
        weapon_name = row[0]
        if not weapon_name or str(weapon_name).strip() == '':
            continue

        name_s = str(weapon_name).strip()
        if name_s in [w[1] for w in WEAPON_SHEETS.values()]:
            rmv = safe_float(row[1])
            emv = safe_float(row[2])
            dmg_type = str(row[3]).strip() if row[3] else None
            burst_group = str(row[4]).strip() if row[4] else None
            sharpness_label = str(row[5]).strip() if row[5] else None
            raw_mod = safe_float(row[6])
            elem_mod = safe_float(row[7])

            # Trova lo slug del tipo arma
            slug = None
            for k, (_, display) in WEAPON_SHEETS.items():
                if display == name_s:
                    slug = k
                    break

            if slug:
                weapon_mods[slug] = {
                    'display_name': name_s,
                    'rmv': rmv,
                    'emv': emv,
                    'damage_type': dmg_type,
                    'burst_group': burst_group,
                }

        # Sharpness mods (colonne 5-7 per alcune righe)
        sharpness_raw = str(row[5]).strip() if row[5] else None
        if sharpness_raw in SHARPNESS_ORDER:
            raw_m = safe_float(row[6])
            elem_m = safe_float(row[7])
            if raw_m is not None:
                sharpness_mods[sharpness_raw.lower()] = {
                    'raw_mod': raw_m,
                    'elem_mod': elem_m,
                }

    return {
        'weapon_type_mods': weapon_mods,
        'sharpness_mods': sharpness_mods,
    }

def write_weapon_mods(data: dict):
    path = OUTPUT_DIR / '03_weapon_mods.json'
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

# ─── Motion Values ───────────────────────────────────────────────────────────

def parse_motion_values(z: zipfile.ZipFile, ss: list[str]) -> list[dict]:
    # Schema sheet arma: Attack, Motion Value, Element, Status, Hit type,
    #   Elem Type, Number of hit, Raw Sharpness Mod, Elem Sharpness Mod, Crit
    all_mvs = []

    for weapon_slug, (sheet_num, weapon_display) in WEAPON_SHEETS.items():
        rows = parse_sheet(z, sheet_num, ss)
        for row in rows[1:]:  # skip header
            row = (row + [None] * 10)[:10]
            attack_name = row[0]
            if not attack_name or safe_float(row[1]) is None:
                continue

            all_mvs.append({
                'weapon_type':       weapon_slug,
                'attack_name':       str(attack_name).strip(),
                'motion_value':      safe_float(row[1]),
                'elem_modifier':     safe_float(row[2]),
                'status_modifier':   safe_float(row[3]),
                'hit_type':          str(row[4]).strip() if row[4] else None,
                'elem_type':         str(row[5]).strip() if row[5] else None,
                'num_hits':          int(float(row[6])) if row[6] else 1,
                'sharpness_raw_mod': safe_float(row[7]),
                'sharpness_elem_mod':safe_float(row[8]),
                'can_crit':          str(row[9]).strip().lower() == 'yes' if row[9] else True,
            })

    return all_mvs

def write_motion_values_sql(mvs: list[dict]):
    with open(OUTPUT_DIR / '04_motion_values.sql', 'w', encoding='utf-8') as f:
        f.write('-- Generato da parse_excel.py\n')
        f.write('-- Source: Alpha Calulator.xlsx, Sheets GS/LS/SnS/DB/HMR/HH/LAN/GL/SA/CB/IG/BOW/LBG/HBG\n')
        f.write('-- USO FUTURO: per calcolo DPH per hitzone (Fase 2 calc engine)\n\n')
        f.write('-- CREATE TABLE IF NOT EXISTS motion_values (\n')
        f.write('--   id INTEGER PRIMARY KEY AUTOINCREMENT,\n')
        f.write('--   weapon_type TEXT NOT NULL,\n')
        f.write('--   attack_name TEXT NOT NULL,\n')
        f.write('--   motion_value REAL NOT NULL,\n')
        f.write('--   elem_modifier REAL,\n')
        f.write('--   status_modifier REAL,\n')
        f.write('--   hit_type TEXT,\n')
        f.write('--   elem_type TEXT,\n')
        f.write('--   num_hits INTEGER DEFAULT 1,\n')
        f.write('--   sharpness_raw_mod REAL,\n')
        f.write('--   sharpness_elem_mod REAL,\n')
        f.write('--   can_crit INTEGER DEFAULT 1\n')
        f.write('-- );\n\n')
        f.write('-- INSERT INTO motion_values\n')
        f.write('--   (weapon_type, attack_name, motion_value, elem_modifier, status_modifier,\n')
        f.write('--    hit_type, elem_type, num_hits, sharpness_raw_mod, sharpness_elem_mod, can_crit)\n')
        f.write('-- VALUES\n')
        rows = []
        for mv in mvs:
            rows.append(
                f"--   ({sql_str(mv['weapon_type'])}, {sql_str(mv['attack_name'])}, "
                f"{sql_float(mv['motion_value'])}, {sql_float(mv['elem_modifier'])}, "
                f"{sql_float(mv['status_modifier'])}, {sql_str(mv['hit_type'])}, "
                f"{sql_str(mv['elem_type'])}, {mv['num_hits']}, "
                f"{sql_float(mv['sharpness_raw_mod'])}, {sql_float(mv['sharpness_elem_mod'])}, "
                f"{'1' if mv['can_crit'] else '0'})"
            )
        f.write(',\n'.join(rows))
        f.write(';\n')

# ─── Main ────────────────────────────────────────────────────────────────────

def main():
    if not EXCEL_PATH.exists():
        print(f'ERRORE: {EXCEL_PATH} non trovato', file=sys.stderr)
        sys.exit(1)

    print(f'Parsing {EXCEL_PATH.name}...')

    with zipfile.ZipFile(EXCEL_PATH, 'r') as z:
        ss = get_shared_strings(z)

        # Skills
        print('  → Skill Data (sheet 20)...')
        skills, skill_levels = parse_skills(z, ss)
        write_skills_sql(skills, skill_levels)
        print(f'     {len(skills)} skills, {len(skill_levels)} skill levels')

        # Weapon mods
        print('  → Weapon Modifier (sheet 19)...')
        weapon_data = parse_weapon_mods(z, ss)
        write_weapon_mods(weapon_data)
        wt = len(weapon_data['weapon_type_mods'])
        sm = len(weapon_data['sharpness_mods'])
        print(f'     {wt} weapon types, {sm} sharpness levels')

        # Motion values
        print('  → Motion Values (sheets 4-17)...')
        mvs = parse_motion_values(z, ss)
        write_motion_values_sql(mvs)
        print(f'     {len(mvs)} motion value entries')

    print(f'\nOutput in {OUTPUT_DIR}:')
    for f in sorted(OUTPUT_DIR.iterdir()):
        size = f.stat().st_size
        print(f'  {f.name:35s} {size:>8,} bytes')

if __name__ == '__main__':
    main()
