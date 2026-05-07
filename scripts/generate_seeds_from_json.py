#!/usr/bin/env python3
"""
generate_seeds_from_json.py

Source of truth: assets/output/merged/Skill.json (179 skills)
Calc data:       scripts/seeds/02_skill_levels.sql (from Excel — 168 skills, 427 levels)

Steps:
  1. Load Skill.json → all 179 skills with numeric IDs, names, ranks, kind
  2. Load existing skill_levels SQL → calc bonuses keyed by Excel slug
  3. Match JSON skills to Excel data by English name → slug comparison
  4. Write new 01_skills.sql (explicit numeric IDs from JSON)
  5. Write new 02_skill_levels.sql (FK = numeric ID, pieces_required for set/group)
  6. Copy both to assets/seeds/
"""

import json
import re
import shutil
from pathlib import Path
from typing import Optional

PROJECT_ROOT   = Path(__file__).parent.parent
SKILL_JSON     = PROJECT_ROOT / 'assets' / 'output' / 'merged' / 'Skill.json'
# Excel calc data (written by parse_excel.py, never overwritten by this script)
EXCEL_LEVELS_SQL = PROJECT_ROOT / 'scripts' / 'excel_calc_levels.sql'
OUT_DIR          = PROJECT_ROOT / 'assets' / 'seeds'
OUT_DIR.mkdir(exist_ok=True)


# ---------------------------------------------------------------------------
# Slug helpers
# ---------------------------------------------------------------------------

def to_slug(name: str) -> str:
    s = name.strip().lower()
    s = re.sub(r"[''`']", '', s)
    s = re.sub(r'[^a-z0-9]+', '_', s)
    return s.strip('_')


# Known Excel typos: JSON slug → Excel slug (for cases where automatic variants don't cover it)
# Excel strips apostrophes and keeps 's' (e.g. "Guardian's" → "guardians").
# Exception: "Gravios's" → Excel dropped the extra 's' entirely → "gravios".
_EXCEL_TYPO_MAP: dict[str, str] = {
    'mushroomancer':               'mashroomancer',
    'fortifyng_pelt':              'fortifyng_pelt',    # keep as-is (already matches)
    'fortifying_pelt':             'fortifyng_pelt',    # JSON→Excel: missing 'i'
    'blight_resistance':           'blight_reistence',  # covered by ance/ence but listed for clarity
    'gore_magalas_tyranny':        'gore_magalas_tiranny',   # 'y'→'i' typo
    'gravioss_protection':         'gravios_protection',     # Gravios's → double-s → single-s
    'exhaust_functionality':       'exhaust_funcionality',   # missing 't'
    'convert_thunder_resistance':  'convert_thunder_resistence',
}


def slug_variants(name: str) -> list[str]:
    """Return slug and common typo variants to maximise match rate."""
    base = to_slug(name)
    variants = [base]
    # Known Excel typo aliases
    if base in _EXCEL_TYPO_MAP:
        variants.append(_EXCEL_TYPO_MAP[base])
    # 'ance' → 'ence' swap (Excel often misspells "resistance" as "resistence")
    if 'ance' in base:
        variants.append(base.replace('ance', 'ence'))
    if 'ence' in base:
        variants.append(base.replace('ence', 'ance'))
    return list(dict.fromkeys(variants))  # deduplicated, order preserved


# ---------------------------------------------------------------------------
# SQL helpers
# ---------------------------------------------------------------------------

def sql_str(v) -> str:
    if v is None:
        return 'NULL'
    return "'" + str(v).replace("'", "''") + "'"

def sql_float(v) -> str:
    try:
        return str(float(v))
    except (TypeError, ValueError):
        return 'NULL'

def sql_int(v) -> str:
    if v is None:
        return 'NULL'
    return str(int(v))


# ---------------------------------------------------------------------------
# Load Excel calc data from existing skill_levels SQL
# ---------------------------------------------------------------------------

def _load_excel_levels_text(text: str) -> dict[str, list[dict]]:
    """Parse skill_levels SQL text in original Excel slug format.
    Expects: (slug_text, int_level, ...) — the format from parse_excel.py output.
    Skips rows where the first field is an integer (new numeric-ID format).
    """
    data: dict[str, list[dict]] = {}
    pattern = re.compile(
        r"\(\s*'([^']+)'\s*,\s*"         # slug (text)
        r"(\d+)\s*,\s*"                   # level
        r"([^,]+)\s*,\s*"                 # b1_value
        r"([^,]+)\s*,\s*"                 # b1_type
        r"([^,]+)\s*,\s*"                 # b2_value
        r"([^,]+)\s*,\s*"                 # b2_type
        r"([^,]+)\s*,\s*"                 # b3_value
        r"([^,]+)\s*,\s*"                 # b3_type
        r"([^,]+)\s*,\s*"                 # duration
        r"([^)]+)\s*\)"                   # cooldown
    )
    for m in pattern.finditer(text):
        slug = m.group(1)
        level = int(m.group(2))

        def parse_val(s: str):
            s = s.strip()
            return None if s.upper() == 'NULL' else float(s)

        def parse_str(s: str):
            s = s.strip()
            if s.upper() == 'NULL':
                return None
            return s.strip("'").replace("''", "'")

        entry = {
            'level':       level,
            'bonus1_value': parse_val(m.group(3)),
            'bonus1_type':  parse_str(m.group(4)),
            'bonus2_value': parse_val(m.group(5)),
            'bonus2_type':  parse_str(m.group(6)),
            'bonus3_value': parse_val(m.group(7)),
            'bonus3_type':  parse_str(m.group(8)),
            'duration_s':   parse_val(m.group(9)),
            'cooldown_s':   parse_val(m.group(10)),
        }
        data.setdefault(slug, []).append(entry)
    return data


def load_excel_levels(path: Path) -> dict[str, list[dict]]:
    """Load Excel calc data from the dedicated file written by parse_excel.py."""
    if not path.exists():
        print(f'  WARNING: {path} not found — run parse_excel.py first to extract Excel data')
        return {}
    return _load_excel_levels_text(path.read_text(encoding='utf-8'))


# ---------------------------------------------------------------------------
# Match JSON skill to Excel calc data
# ---------------------------------------------------------------------------

def find_excel_levels(
    json_name_en: str,
    excel_data: dict[str, list[dict]],
) -> Optional[list[dict]]:
    """Try several slug variants to find calc data for a JSON skill."""
    for variant in slug_variants(json_name_en):
        if variant in excel_data:
            return excel_data[variant]
    return None


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    # 1. Load JSON
    skills_json: list[dict] = json.loads(SKILL_JSON.read_text(encoding='utf-8'))
    print(f'Loaded {len(skills_json)} skills from Skill.json')

    # 2. Load Excel calc data
    excel_levels = load_excel_levels(EXCEL_LEVELS_SQL)
    print(f'Loaded calc data for {len(excel_levels)} Excel skills')

    # 3. Build merged skill list
    skills_rows: list[dict]        = []  # for 01_skills.sql
    skill_levels_rows: list[dict]  = []  # for 02_skill_levels.sql

    matched = unmatched = new_only = 0

    for skill in skills_json:
        sid   = skill['id']                         # numeric ID from JSON
        name  = skill['names']['en']
        kind  = skill['kind']                       # armor | weapon | set | group
        ranks = skill['ranks']
        slug  = to_slug(name)
        max_level = max(r['level'] for r in ranks)

        # type2 (subcategory) comes only from Excel — default to 'utility'
        excel_lvls = find_excel_levels(name, excel_levels)

        # Determine subcategory from Excel if available
        # (We don't store subcategory per-level; it's constant for the skill.
        #  Since Excel doesn't surface it here as a separate field we default.)
        # The old seeds had type2 (subcategory) in 01_skills.sql; we keep 'utility' as default
        # because the JSON doesn't carry this information.
        subcategory = 'utility'

        skills_rows.append({
            'id':          sid,
            'slug':        slug,
            'name':        name,
            'max_level':   max_level,
            'kind':        kind,
            'subcategory': subcategory,
        })

        if excel_lvls is not None:
            matched += 1
        else:
            new_only += 1

        # Build skill_levels rows
        for rank in ranks:
            level = rank['level']
            pieces_req = rank.get('set_pieces_required', None)  # only set/group

            # For armor/weapon skills: find matching Excel level for calc bonuses
            # For set/group skills: all calc data is NULL (pieces-based activation)
            calc = None
            if excel_lvls is not None and kind in ('armor', 'weapon'):
                calc = next((e for e in excel_lvls if e['level'] == level), None)
            elif excel_lvls is not None and kind in ('set', 'group'):
                # Excel level = pieces_required for set/group; map by pieces_required
                if pieces_req is not None:
                    calc = next((e for e in excel_lvls if e['level'] == pieces_req), None)

            skill_levels_rows.append({
                'skill_id':      sid,
                'level':         level,
                'pieces_required': pieces_req,
                'bonus1_value':  calc['bonus1_value']  if calc else None,
                'bonus1_type':   calc['bonus1_type']   if calc else None,
                'bonus2_value':  calc['bonus2_value']  if calc else None,
                'bonus2_type':   calc['bonus2_type']   if calc else None,
                'bonus3_value':  calc['bonus3_value']  if calc else None,
                'bonus3_type':   calc['bonus3_type']   if calc else None,
                'duration_s':    calc['duration_s']    if calc else None,
                'cooldown_s':    calc['cooldown_s']    if calc else None,
            })

    print(f'  matched to Excel:    {matched}')
    print(f'  JSON-only (no Excel): {new_only}')
    print(f'  total skill_levels:  {len(skill_levels_rows)}')

    # 4. Write 01_skills.sql
    skills_sql_path = OUT_DIR / '01_skills.sql'
    with open(skills_sql_path, 'w', encoding='utf-8') as f:
        f.write('-- Generated by generate_seeds_from_json.py\n')
        f.write('-- Source of truth: assets/output/merged/Skill.json\n\n')
        f.write('DELETE FROM skill_levels;\n')
        f.write('DELETE FROM skills;\n\n')
        f.write('INSERT INTO skills (id, slug, name, max_level, type1, type2) VALUES\n')
        rows = []
        for s in skills_rows:
            rows.append(
                f"  ({s['id']}, {sql_str(s['slug'])}, {sql_str(s['name'])}, "
                f"{s['max_level']}, {sql_str(s['kind'])}, {sql_str(s['subcategory'])})"
            )
        f.write(',\n'.join(rows))
        f.write(';\n')

    # 5. Write 02_skill_levels.sql
    levels_sql_path = OUT_DIR / '02_skill_levels.sql'
    with open(levels_sql_path, 'w', encoding='utf-8') as f:
        f.write('-- Generated by generate_seeds_from_json.py\n')
        f.write('-- Source of truth: assets/output/merged/Skill.json\n')
        f.write('-- Calc bonuses from: Alpha Calulator.xlsx via parse_excel.py\n\n')
        f.write('INSERT INTO skill_levels\n')
        f.write('  (skill_id, level, pieces_required,\n')
        f.write('   bonus1_value, bonus1_type, bonus2_value, bonus2_type,\n')
        f.write('   bonus3_value, bonus3_type, duration_s, cooldown_s)\n')
        f.write('VALUES\n')
        rows = []
        for sl in skill_levels_rows:
            rows.append(
                f"  ({sl['skill_id']}, {sl['level']}, {sql_int(sl['pieces_required'])},\n"
                f"   {sql_float(sl['bonus1_value'])}, {sql_str(sl['bonus1_type'])}, "
                f"{sql_float(sl['bonus2_value'])}, {sql_str(sl['bonus2_type'])},\n"
                f"   {sql_float(sl['bonus3_value'])}, {sql_str(sl['bonus3_type'])}, "
                f"{sql_float(sl['duration_s'])}, {sql_float(sl['cooldown_s'])})"
            )
        f.write(',\n'.join(rows))
        f.write(';\n')

    print(f'\nOutput written to:')
    print(f'  {skills_sql_path}')
    print(f'  {levels_sql_path}')
    print(f'  (Excel calc source: {EXCEL_LEVELS_SQL})')

    # 7. Report unmatched (skills in JSON with no Excel data)
    unmatched_names = []
    for skill in skills_json:
        name = skill['names']['en']
        if find_excel_levels(name, excel_levels) is None:
            unmatched_names.append(f"  [{skill['kind']}] {name}")
    if unmatched_names:
        print(f'\nSkills in JSON without Excel calc data ({len(unmatched_names)}):')
        for n in sorted(unmatched_names):
            print(n)


if __name__ == '__main__':
    main()
