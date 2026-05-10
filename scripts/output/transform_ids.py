"""
Transform game_ids to sequential DB ids across all JSON files.

For each entity:
  - game_id → id (1-based sequential by array order)
  - All FK references updated accordingly

Stage camps also get sequential ids (internal to each stage).
HuntingHornSongs get an id field (effect_id is kept as a separate type field).
"""

import json
from pathlib import Path

DIR = Path(__file__).parent / "merged"


def load(name):
    with open(DIR / name, encoding="utf-8") as f:
        return json.load(f)


def save(name, data):
    with open(DIR / name, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)


def build_map(data, field="game_id"):
    return {item[field]: i + 1 for i, item in enumerate(data)}


def remap_id(item, old_map, new_map=None):
    """Replace game_id with id in an entity dict."""
    gid = item.pop("game_id")
    item["id"] = old_map[gid]
    return item


def remap_skills_dict(skills_dict, skill_map):
    """Re-key a {game_id_str: level} dict to {new_id_str: level}."""
    if not skills_dict:
        return skills_dict
    result = {}
    for k, v in skills_dict.items():
        gid = int(k)
        new_id = skill_map.get(gid)
        if new_id is None:
            raise KeyError(f"Skill game_id {gid} not found in skill_map")
        result[str(new_id)] = v
    return result


def remap_inputs_dict(inputs_dict, item_map):
    """Re-key a {item_game_id_str: qty} dict to {new_item_id_str: qty}."""
    if not inputs_dict:
        return inputs_dict
    result = {}
    for k, v in inputs_dict.items():
        gid = int(k)
        new_id = item_map.get(gid)
        if new_id is None:
            raise KeyError(f"Item game_id {gid} not found in item_map")
        result[str(new_id)] = v
    return result


# ── Load all files ────────────────────────────────────────────────────────────

skills       = load("Skill.json")
items        = load("Item.json")
weapon_series = load("WeaponSeries.json")
stages       = load("Stage.json")
hh_melodies  = load("HuntingHornMelodies.json")
hh_echowaves = load("HuntingHornEchoWaves.json")
hh_echobubbles = load("HuntingHornEchoBubbles.json")
hh_songs     = load("HuntingHornSongs.json")
armor        = load("Armor.json")
accessory    = load("Accessory.json")
amulet       = load("Amulet.json")
charm        = load("Charm.json")
large_monsters = load("LargeMonsters.json")

weapon_files = [
    "Bow", "ChargeBlade", "DualBlades", "GreatSword", "Gunlance",
    "Hammer", "HeavyBowgun", "HuntingHorn", "InsectGlaive", "Lance",
    "LightBowgun", "LongSword", "SwitchAxe", "SwordShield",
]
weapons = {name: load(f"{name}.json") for name in weapon_files}

# ── Build ID maps ─────────────────────────────────────────────────────────────

skill_map   = build_map(skills)
item_map    = build_map(items)
series_map  = build_map(weapon_series)
stage_map   = build_map(stages)
melody_map  = build_map(hh_melodies)
echowave_map  = build_map(hh_echowaves)
echobubble_map = build_map(hh_echobubbles)

# Weapons: separate map per weapon type (game_id → new sequential id)
weapon_maps = {
    name: build_map(data) for name, data in weapons.items()
}

# ── Transform entities (add id, remove game_id) ───────────────────────────────

print("Transforming Skill.json...")
for i, s in enumerate(skills):
    s.pop("game_id")
    s["id"] = i + 1
save("Skill.json", skills)

print("Transforming Item.json...")
for i, it in enumerate(items):
    it.pop("game_id")
    it["id"] = i + 1
    # Self-referential: recipes[].inputs is a list of item game_ids
    for recipe in it.get("recipes", []):
        recipe["inputs"] = [
            item_map[gid] for gid in recipe.get("inputs", [])
        ]
save("Item.json", items)

print("Transforming WeaponSeries.json...")
for i, ws in enumerate(weapon_series):
    ws.pop("game_id")
    ws["id"] = i + 1
save("WeaponSeries.json", weapon_series)

print("Transforming Stage.json...")
for i, stage in enumerate(stages):
    stage.pop("game_id")
    stage["id"] = i + 1
    # Camps also get sequential ids (internal to each stage)
    for j, camp in enumerate(stage.get("camps", [])):
        camp.pop("game_id")
        camp["id"] = j + 1
save("Stage.json", stages)

print("Transforming HuntingHornMelodies.json...")
for i, m in enumerate(hh_melodies):
    m.pop("game_id")
    m["id"] = i + 1
    # songs array references HuntingHornSongs by effect_id — no change needed
save("HuntingHornMelodies.json", hh_melodies)

print("Transforming HuntingHornEchoWaves.json...")
for i, ew in enumerate(hh_echowaves):
    ew.pop("game_id")
    ew["id"] = i + 1
save("HuntingHornEchoWaves.json", hh_echowaves)

print("Transforming HuntingHornEchoBubbles.json...")
for i, eb in enumerate(hh_echobubbles):
    eb.pop("game_id")
    eb["id"] = i + 1
save("HuntingHornEchoBubbles.json", hh_echobubbles)

print("Transforming HuntingHornSongs.json...")
for i, song in enumerate(hh_songs):
    # effect_id is a type/category field, not a primary key — keep it
    song["id"] = i + 1
save("HuntingHornSongs.json", hh_songs)

print("Transforming Charm.json...")
for i, c in enumerate(charm):
    c.pop("game_id")
    c["id"] = i + 1
save("Charm.json", charm)

print("Transforming Accessory.json...")
for i, acc in enumerate(accessory):
    acc.pop("game_id")
    acc["id"] = i + 1
    if acc.get("skills"):
        acc["skills"] = remap_skills_dict(acc["skills"], skill_map)
save("Accessory.json", accessory)

print("Transforming Amulet.json...")
for i, am in enumerate(amulet):
    am.pop("game_id")
    am["id"] = i + 1
    for rank in am.get("ranks", []):
        if rank.get("skills"):
            rank["skills"] = remap_skills_dict(rank["skills"], skill_map)
        recipe = rank.get("recipe")
        if recipe and recipe.get("inputs"):
            recipe["inputs"] = remap_inputs_dict(recipe["inputs"], item_map)
save("Amulet.json", amulet)

print("Transforming LargeMonsters.json...")
for i, monster in enumerate(large_monsters):
    monster.pop("game_id")
    monster["id"] = i + 1
    monster["locations"] = [
        stage_map[gid] for gid in monster.get("locations", [])
    ]
save("LargeMonsters.json", large_monsters)

print("Transforming Armor.json...")
for i, arm in enumerate(armor):
    arm.pop("game_id")
    arm["id"] = i + 1

    # set_bonus FK → skill
    if arm.get("set_bonus_id") is not None:
        arm["set_bonus_id"] = skill_map[arm["set_bonus_id"]]
    if arm.get("set_bonus") and arm["set_bonus"].get("skill_id") is not None:
        arm["set_bonus"]["skill_id"] = skill_map[arm["set_bonus"]["skill_id"]]

    # group_bonus FK → skill
    if arm.get("group_bonus_id") is not None:
        arm["group_bonus_id"] = skill_map[arm["group_bonus_id"]]
    if arm.get("group_bonus") and arm["group_bonus"].get("skill_id") is not None:
        arm["group_bonus"]["skill_id"] = skill_map[arm["group_bonus"]["skill_id"]]

    for piece in arm.get("pieces", []):
        if piece.get("skills"):
            piece["skills"] = remap_skills_dict(piece["skills"], skill_map)
        crafting = piece.get("crafting", {})
        if crafting.get("inputs"):
            crafting["inputs"] = remap_inputs_dict(crafting["inputs"], item_map)

save("Armor.json", armor)

print("Transforming weapon files...")
for name, data in weapons.items():
    wmap = weapon_maps[name]
    for i, w in enumerate(data):
        w.pop("game_id")
        w["id"] = i + 1

        # series_id → WeaponSeries new id
        if w.get("series_id") is not None:
            w["series_id"] = series_map[w["series_id"]]

        # HuntingHorn-specific FKs
        if w.get("melody_id") is not None:
            w["melody_id"] = melody_map[w["melody_id"]]
        if w.get("echo_wave_id") is not None:
            w["echo_wave_id"] = echowave_map[w["echo_wave_id"]]
        if w.get("echo_bubble_id") is not None:
            w["echo_bubble_id"] = echobubble_map[w["echo_bubble_id"]]

        # Self-referential crafting FKs
        crafting = w.get("crafting", {})
        if crafting.get("previous_id") is not None:
            crafting["previous_id"] = wmap[crafting["previous_id"]]
        crafting["branches"] = [wmap[b] for b in crafting.get("branches", [])]

        # skills dict
        if w.get("skills"):
            w["skills"] = remap_skills_dict(w["skills"], skill_map)

        # crafting.inputs (item FKs)
        if crafting.get("inputs"):
            crafting["inputs"] = remap_inputs_dict(crafting["inputs"], item_map)

    save(f"{name}.json", data)
    print(f"  {name}.json done")

print("\nDone. All files transformed successfully.")
