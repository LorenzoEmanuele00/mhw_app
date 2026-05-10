#!/usr/bin/env python3
"""
generate_game_data.py

Reads game JSON files from scripts/output/merged/ and generates SQL seeds for:
  assets/seeds/03_armor.sql   → armor_sets, armor_pieces, armor_set_skills, armor_piece_skills
  assets/seeds/04_weapons.sql → weapons (all 14 types)
  assets/seeds/05_jewels.sql  → jewels, jewel_skills

Source of truth: scripts/output/merged/*.json
"""

import json
import re
from pathlib import Path
from typing import Optional

PROJECT_ROOT = Path(__file__).parent.parent
MERGED_DIR   = PROJECT_ROOT / 'scripts' / 'output' / 'merged'
OUT_DIR      = PROJECT_ROOT / 'assets' / 'seeds'
OUT_DIR.mkdir(exist_ok=True)

# ---------------------------------------------------------------------------
# Weapon kind → DB slug
# ---------------------------------------------------------------------------

WEAPON_KIND_MAP = {
    'great-sword':   'gs',
    'long-sword':    'ls',
    'sword-shield':  'sns',
    'dual-blades':   'db',
    'hammer':        'hmr',
    'hunting-horn':  'hh',
    'lance':         'lan',
    'gunlance':      'gl',
    'switch-axe':    'sa',
    'charge-blade':  'cb',
    'insect-glaive': 'ig',
    'light-bowgun':  'lbg',
    'heavy-bowgun':  'hbg',
    'bow':           'bow',
}

WEAPON_JSON_FILES = list(WEAPON_KIND_MAP.keys())

# damage_type and burst_group per weapon type (static game data)
WEAPON_TYPE_META = {
    'gs':  ('cut',    'GS_HH'),
    'ls':  ('cut',    'Other'),
    'sns': ('cut',    'Other'),
    'db':  ('cut',    'DB'),
    'hmr': ('impact', 'Other'),
    'hh':  ('impact', 'GS_HH'),
    'lan': ('cut',    'Other'),
    'gl':  ('cut',    'GL'),
    'sa':  ('cut',    'Other'),
    'cb':  ('cut',    'CB'),
    'ig':  ('cut',    'Other'),
    'lbg': ('ranged', 'Bowgun'),
    'hbg': ('ranged', 'Bowgun'),
    'bow': ('ranged', 'Bow'),
}

# rmv/emv from Excel weapon_mods (fallback = 1.0 if file not present)
def load_weapon_mods() -> dict:
    path = PROJECT_ROOT / 'scripts' / 'weapon_mods.json'
    if path.exists():
        data = json.loads(path.read_text())
        return data.get('weapon_type_mods', {})
    return {}

# ---------------------------------------------------------------------------
# Element/status type mapping
# ---------------------------------------------------------------------------

SPECIAL_TYPE_MAP = {
    'fire':        'fire',
    'water':       'water',
    'thunder':     'thunder',
    'ice':         'ice',
    'dragon':      'dragon',
    'poison':      'poison',
    'sleep':       'sleep',
    'paralysis':   'paralysis',
    'blastblight': 'blast',
}

# ---------------------------------------------------------------------------
# Sharpness helpers
# ---------------------------------------------------------------------------

SHARPNESS_ORDER = ['red', 'orange', 'yellow', 'green', 'blue', 'white', 'purple']

def max_sharpness(sharpness: dict) -> str:
    """Return the highest sharpness color with at least 1 hit."""
    result = 'red'
    for color in SHARPNESS_ORDER:
        if sharpness.get(color, 0) > 0:
            result = color
    return result

# ---------------------------------------------------------------------------
# Slug helper
# ---------------------------------------------------------------------------

_GREEK = [('α', 'alpha'), ('β', 'beta'), ('γ', 'gamma'), ('δ', 'delta')]

def to_slug(name: str) -> str:
    s = name.strip().lower()
    s = re.sub(r"[''`']", '', s)
    for greek, latin in _GREEK:
        s = s.replace(greek, latin)
    s = re.sub(r'[^a-z0-9]+', '_', s)
    return s.strip('_')

# ---------------------------------------------------------------------------
# SQL helpers
# ---------------------------------------------------------------------------

def sql_str(v) -> str:
    if v is None:
        return 'NULL'
    return "'" + str(v).replace("'", "''") + "'"

def sql_int(v) -> str:
    return 'NULL' if v is None else str(int(v))

def sql_real(v, default=None) -> str:
    if v is None:
        return 'NULL' if default is None else str(float(default))
    try:
        return str(float(v))
    except (TypeError, ValueError):
        return 'NULL'

# ---------------------------------------------------------------------------
# 04_weapons.sql
# ---------------------------------------------------------------------------

def generate_weapons():
    weapon_mods = load_weapon_mods()
    rows_weapons = []
    global_id = 0  # auto-increment across all weapon types

    for json_kind, db_slug in WEAPON_KIND_MAP.items():
        filename = json_kind.title().replace('-', '') + '.json'
        # Fix file name mismatches
        filename = {
            'Swordshield.json': 'SwordShield.json',
            'Dualbladesdb.json': 'DualBlades.json',
            'Huntinghorn.json': 'HuntingHorn.json',
            'Switchaxe.json': 'SwitchAxe.json',
            'Chargeblade.json': 'ChargeBlade.json',
            'Insectglaive.json': 'InsectGlaive.json',
            'Lightbowgun.json': 'LightBowgun.json',
            'Heavybowgun.json': 'HeavyBowgun.json',
        }.get(filename, filename)

        path = MERGED_DIR / filename
        if not path.exists():
            print(f'  WARNING: {filename} not found, skipping')
            continue

        with open(path, encoding='utf-8') as f:
            weapons = json.load(f)

        mods = weapon_mods.get(db_slug, {})
        rmv = mods.get('rmv', 1.0)
        emv = mods.get('emv', 1.0)
        damage_type, burst_group = WEAPON_TYPE_META[db_slug]

        # First pass: collect all entries; assign global sequential IDs
        weapon_entries = []
        for w in weapons:
            global_id += 1
            wid   = global_id
            name  = w['names']['en']
            slug  = f"{db_slug}_{to_slug(name)}"
            rarity = w.get('rarity', 1)
            attack = w.get('attack_raw', 0)
            affinity = (w.get('affinity', 0) or 0) / 100.0

            sharp = w.get('sharpness')
            sharpness_max = max_sharpness(sharp) if sharp else 'red'

            slots = json.dumps(w.get('slots') or [])

            specials = w.get('specials') or []
            elem_type = None
            elem_value = None
            if specials:
                sp = specials[0]
                raw_type = sp.get('element') or sp.get('status')
                elem_type = SPECIAL_TYPE_MAP.get(raw_type)
                elem_value = sp.get('raw')
                if sp.get('hidden', False):
                    elem_type = None
                    elem_value = None

            weapon_entries.append((wid, slug, name, rarity, attack, affinity,
                                   elem_type, elem_value, sharpness_max, slots))

        # Deduplicate slugs by appending _{id}
        from collections import Counter
        slug_counts = Counter(e[1] for e in weapon_entries)
        slug_seen: dict = {}
        for entry in weapon_entries:
            wid, slug, name, rarity, attack, affinity, elem_type, elem_value, sharpness_max, slots = entry
            if slug_counts[slug] > 1:
                slug = f"{slug}_{wid}"
            rows_weapons.append(
                f"  ({wid}, {sql_str(slug)}, {sql_str(name)}, {sql_str(db_slug)}, "
                f"{attack}, {sql_real(affinity, 0.0)}, "
                f"{sql_str(elem_type)}, {sql_int(elem_value)}, "
                f"{sql_str(sharpness_max)}, {rarity}, {sql_str(slots)}, "
                f"{sql_real(rmv, 1.0)}, {sql_real(emv, 1.0)}, "
                f"{sql_str(damage_type)}, {sql_str(burst_group)})"
            )

    out = OUT_DIR / '04_weapons.sql'
    with open(out, 'w', encoding='utf-8') as f:
        f.write('-- Generated by generate_game_data.py\n')
        f.write('-- Source: scripts/output/merged/<WeaponType>.json\n\n')
        f.write('DELETE FROM weapons;\n\n')
        f.write('INSERT INTO weapons\n')
        f.write('  (id, slug, name, weapon_type, base_attack, base_affinity,\n')
        f.write('   element_type, element_value, sharpness_max, rarity, slots,\n')
        f.write('   rmv, emv, damage_type, burst_group)\n')
        f.write('VALUES\n')
        f.write(',\n'.join(rows_weapons))
        f.write(';\n')

    total = sum(1 for r in rows_weapons)
    print(f'  04_weapons.sql: {total} weapons')

# ---------------------------------------------------------------------------
# 03_armor.sql
# ---------------------------------------------------------------------------

ARMOR_SLOT_KIND = {'head', 'chest', 'arms', 'waist', 'legs'}

def generate_armor():
    with open(MERGED_DIR / 'Armor.json', encoding='utf-8') as f:
        armor_sets_json = json.load(f)

    rows_sets      = []
    rows_pieces    = []
    rows_set_skills = []
    rows_piece_skills = []

    piece_id_counter = 1  # armor_pieces autoincrement simulation (use JSON-derived ID)
    # We'll use set_id * 10 + piece_index as piece ID for determinism
    # Actually better: track a running counter

    for aset in armor_sets_json:
        set_id   = aset['id']
        set_name = aset['names']['en']
        set_slug = to_slug(set_name)
        rarity   = aset.get('rarity', 1)

        rows_sets.append(
            f"  ({set_id}, {sql_str(set_slug)}, {sql_str(set_name)})"
        )

        # armor_set_skills: set_bonus + group_bonus
        for bonus_key in ('set_bonus', 'group_bonus'):
            bonus = aset.get(bonus_key)
            if not bonus:
                continue
            skill_id = bonus['skill_id']
            category = 'set' if bonus_key == 'set_bonus' else 'group'
            for rank in bonus.get('ranks', []):
                rows_set_skills.append(
                    f"  ({set_id}, {rank['pieces']}, {skill_id}, "
                    f"{rank['skill_level']}, {sql_str(category)})"
                )

        # armor_pieces
        for piece in aset.get('pieces', []):
            kind  = piece['kind']
            if kind not in ARMOR_SLOT_KIND:
                continue
            name  = piece['names']['en']
            slug  = to_slug(name)
            def_  = piece.get('defense', {})
            base_def = def_.get('base', 0) if isinstance(def_, dict) else 0
            res   = piece.get('resistances', {})
            slots_list = piece.get('slots') or []
            slots_json = json.dumps(slots_list)
            # piece id: use set_id * 10 + slot_index
            slot_idx = list(ARMOR_SLOT_KIND).index(kind) if kind in ARMOR_SLOT_KIND else 0
            # safer: generate a unique id
            piece_id = piece_id_counter
            piece_id_counter += 1  # captured via closure workaround below

            rows_pieces.append(
                f"  ({piece_id}, {sql_str(slug)}, {sql_str(name)}, {sql_str(kind)}, "
                f"{base_def}, "
                f"{res.get('fire', 0)}, {res.get('water', 0)}, "
                f"{res.get('thunder', 0)}, {res.get('ice', 0)}, {res.get('dragon', 0)}, "
                f"{rarity}, {sql_str(slots_json)}, {set_id})"
            )

            # armor_piece_skills
            for skill_id_str, skill_lvl in (piece.get('skills') or {}).items():
                rows_piece_skills.append(
                    f"  ({piece_id}, {int(skill_id_str)}, {skill_lvl})"
                )

    # Python closure doesn't work for mutable counter in list comprehension —
    # we already appended with the correct piece_id above, just need to fix the
    # counter increment. Let me rebuild with a proper approach.

    out = OUT_DIR / '03_armor.sql'
    with open(out, 'w', encoding='utf-8') as f:
        f.write('-- Generated by generate_game_data.py\n')
        f.write('-- Source: scripts/output/merged/Armor.json\n\n')
        f.write('DELETE FROM armor_piece_skills;\n')
        f.write('DELETE FROM armor_set_skills;\n')
        f.write('DELETE FROM armor_pieces;\n')
        f.write('DELETE FROM armor_sets;\n\n')

        f.write('INSERT INTO armor_sets (id, slug, name) VALUES\n')
        f.write(',\n'.join(rows_sets))
        f.write(';\n\n')

        f.write('INSERT INTO armor_pieces\n')
        f.write('  (id, slug, name, slot_type, base_defense,\n')
        f.write('   fire_res, water_res, thunder_res, ice_res, dragon_res,\n')
        f.write('   rarity, slots, set_id)\n')
        f.write('VALUES\n')
        f.write(',\n'.join(rows_pieces))
        f.write(';\n\n')

        f.write('INSERT INTO armor_set_skills\n')
        f.write('  (set_id, required_pieces, skill_id, skill_level, skill_category)\n')
        f.write('VALUES\n')
        f.write(',\n'.join(rows_set_skills))
        f.write(';\n\n')

        if rows_piece_skills:
            f.write('INSERT INTO armor_piece_skills (armor_piece_id, skill_id, skill_level) VALUES\n')
            f.write(',\n'.join(rows_piece_skills))
            f.write(';\n')

    print(f'  03_armor.sql: {len(rows_sets)} sets, {len(rows_pieces)} pieces, '
          f'{len(rows_set_skills)} set-skills, {len(rows_piece_skills)} piece-skills')

# ---------------------------------------------------------------------------
# 05_jewels.sql
# ---------------------------------------------------------------------------

def generate_jewels():
    with open(MERGED_DIR / 'Accessory.json', encoding='utf-8') as f:
        jewels_json = json.load(f)

    rows_jewels = []
    rows_jewel_skills = []

    for j in jewels_json:
        jid       = j['id']
        name      = j['names']['en']
        slug      = to_slug(name)
        rarity    = j.get('rarity', 1)
        slot_size = j.get('level', 1)
        allowed   = j.get('allowed_on', 'armor')

        rows_jewels.append(
            f"  ({jid}, {sql_str(slug)}, {sql_str(name)}, "
            f"{rarity}, {slot_size}, {sql_str(allowed)})"
        )

        for skill_id_str, skill_lvl in (j.get('skills') or {}).items():
            rows_jewel_skills.append(
                f"  ({jid}, {int(skill_id_str)}, {skill_lvl})"
            )

    out = OUT_DIR / '05_jewels.sql'
    with open(out, 'w', encoding='utf-8') as f:
        f.write('-- Generated by generate_game_data.py\n')
        f.write('-- Source: scripts/output/merged/Accessory.json\n\n')
        f.write('DELETE FROM jewel_skills;\n')
        f.write('DELETE FROM jewels;\n\n')

        f.write('INSERT INTO jewels (id, slug, name, rarity, slot_size, allowed_on) VALUES\n')
        f.write(',\n'.join(rows_jewels))
        f.write(';\n\n')

        f.write('INSERT INTO jewel_skills (jewel_id, skill_id, skill_level) VALUES\n')
        f.write(',\n'.join(rows_jewel_skills))
        f.write(';\n')

    print(f'  05_jewels.sql: {len(rows_jewels)} jewels, {len(rows_jewel_skills)} jewel-skills')

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    print('Generating game data seeds...')

    # Fix piece_id_counter: generate_armor uses a mutable counter that needs
    # to be module-level. Redefine generate_armor with nonlocal.
    generate_armor_fixed()
    generate_weapons()
    generate_jewels()

    print('\nOutput:')
    for f in sorted(OUT_DIR.glob('0[3-5]_*.sql')):
        print(f'  {f.name}: {f.stat().st_size:,} bytes')


def generate_armor_fixed():
    """generate_armor with a proper mutable counter."""
    with open(MERGED_DIR / 'Armor.json', encoding='utf-8') as f:
        armor_sets_json = json.load(f)

    rows_sets       = []
    rows_pieces     = []
    rows_set_skills = []
    rows_piece_skills = []

    piece_id = 0

    for aset in armor_sets_json:
        set_id   = aset['id']
        set_name = aset['names']['en']
        set_slug = to_slug(set_name)
        rarity   = aset.get('rarity', 1)

        rows_sets.append(
            f"  ({set_id}, {sql_str(set_slug)}, {sql_str(set_name)})"
        )

        for bonus_key in ('set_bonus', 'group_bonus'):
            bonus = aset.get(bonus_key)
            if not bonus:
                continue
            skill_id_b = bonus['skill_id']
            category = 'set' if bonus_key == 'set_bonus' else 'group'
            for rank in bonus.get('ranks', []):
                rows_set_skills.append(
                    f"  ({set_id}, {rank['pieces']}, {skill_id_b}, "
                    f"{rank['skill_level']}, {sql_str(category)})"
                )

        for piece in aset.get('pieces', []):
            kind = piece['kind']
            if kind not in ARMOR_SLOT_KIND:
                continue

            piece_id += 1
            name  = piece['names']['en']
            slug  = to_slug(name)
            def_  = piece.get('defense', {})
            base_def = def_.get('base', 0) if isinstance(def_, dict) else 0
            res   = piece.get('resistances', {})
            slots_json = json.dumps(piece.get('slots') or [])

            rows_pieces.append(
                f"  ({piece_id}, {sql_str(slug)}, {sql_str(name)}, {sql_str(kind)}, "
                f"{base_def}, "
                f"{res.get('fire', 0)}, {res.get('water', 0)}, "
                f"{res.get('thunder', 0)}, {res.get('ice', 0)}, {res.get('dragon', 0)}, "
                f"{rarity}, {sql_str(slots_json)}, {set_id})"
            )

            for skill_id_str, skill_lvl in (piece.get('skills') or {}).items():
                rows_piece_skills.append(
                    f"  ({piece_id}, {int(skill_id_str)}, {skill_lvl})"
                )

    out = OUT_DIR / '03_armor.sql'
    with open(out, 'w', encoding='utf-8') as f:
        f.write('-- Generated by generate_game_data.py\n')
        f.write('-- Source: scripts/output/merged/Armor.json\n\n')
        f.write('DELETE FROM armor_piece_skills;\n')
        f.write('DELETE FROM armor_set_skills;\n')
        f.write('DELETE FROM armor_pieces;\n')
        f.write('DELETE FROM armor_sets;\n\n')

        f.write('INSERT INTO armor_sets (id, slug, name) VALUES\n')
        f.write(',\n'.join(rows_sets))
        f.write(';\n\n')

        f.write('INSERT INTO armor_pieces\n')
        f.write('  (id, slug, name, slot_type, base_defense,\n')
        f.write('   fire_res, water_res, thunder_res, ice_res, dragon_res,\n')
        f.write('   rarity, slots, set_id)\n')
        f.write('VALUES\n')
        f.write(',\n'.join(rows_pieces))
        f.write(';\n\n')

        f.write('INSERT INTO armor_set_skills\n')
        f.write('  (set_id, required_pieces, skill_id, skill_level, skill_category)\n')
        f.write('VALUES\n')
        f.write(',\n'.join(rows_set_skills))
        f.write(';\n\n')

        if rows_piece_skills:
            f.write('INSERT INTO armor_piece_skills (armor_piece_id, skill_id, skill_level) VALUES\n')
            f.write(',\n'.join(rows_piece_skills))
            f.write(';\n')

    print(f'  03_armor.sql: {len(rows_sets)} sets, {len(rows_pieces)} pieces, '
          f'{len(rows_set_skills)} set-skills, {len(rows_piece_skills)} piece-skills')


if __name__ == '__main__':
    main()
