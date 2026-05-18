# CALC_ENGINE.md — Motore di Calcolo Statistiche

Fonte: `Alpha Calulator.xlsx` (Downloads) — Sheet "Calculator" e "Builder"  
Dati già estratti in `scripts/excel_calc_levels.sql` via `scripts/parse_excel.py`.

## Flusso calcolo MVP (statistiche aggregate)

### 1. Aggregazione skill dalla build

Raccogliere tutti i livelli skill attivi nella build:
- Skill da ogni armor piece (head, chest, arms, waist, legs)
- Skill da weapon
- Skill da talisman
- Skill da jewels inseriti
- Set bonus (GROUP/SERIES) — attivati se abbastanza pezzi dello stesso set

Se la stessa skill appare su più pezzi, i livelli si sommano fino a `max_level`.

### 2. True Raw

```
true_raw = base_weapon_attack
         × Π(skill.atk_multiplier per skill attiva)
         + Σ(skill.atk_additive per skill attiva)
```

Esempio skill che impatta True Raw:
- Attack Boost lv7: ×1.10 + 35 flat
- Agitator lv5: +17 flat (uptime ~85%)
- Mega Demondrug: +10 flat (sempre attivo se usato)

### 3. Effective Affinity

```
effective_affinity = base_weapon_affinity
                   + Σ(skill.affinity_additive × skill.uptime)
```

Skill rilevanti:
- Critical Eye lv7: +40%
- Agitator lv5: +15% (uptime 0.85)
- Maximum Might lv3: +30% (uptime 0.9)
- Weakness Exploit lv3: +50% (uptime variabile — di default 1.0)
- Latent Power lv5: +40% (uptime configurabile)

### 4. Crit Multiplier effettivo

```
base_crit_multiplier = 0.25   (colpo critico = +25% raw di default)
effective_crit_multiplier = base_crit_multiplier
                          × Π(skill.crit_bonus_multiplier)
```

Skill rilevanti:
- Critical Boost lv3: ×1.30 (il +25% diventa +25%×1.30 = +32.5% extra raw)

**Damage multiplier da affinity**:
```
affinity_multiplier = 1 + (effective_affinity × effective_crit_multiplier)
```

### 5. True Element

```
true_element = base_weapon_element × 0.1   (il valore in-game va diviso per 10)
             × Π(skill.elem_multiplier)
             + Σ(skill.elem_additive)
```

Skill rilevanti per ogni tipo elemento:
- Fire/Water/Thunder/Ice/Dragon Attack lv7: vari moltiplicatori
- Critical Element: aggiunge bonus critico sull'elemento (trattato separatamente)

### 6. Sharpness effettiva

La sharpness di base dell'arma è `sharpness_max`. Handicraft aggiunge livelli.

Moltiplicatori sharpness per raw e elem:
| Sharpness | Raw Mod | Elem Mod |
|-----------|---------|----------|
| Red       | 0.50    | 0.25     |
| Orange    | 0.75    | 0.50     |
| Yellow    | 1.00    | 0.75     |
| Green     | 1.05    | 1.00     |
| Blue      | 1.20    | 1.0625   |
| White     | 1.32    | 1.15     |
| Purple    | 1.39    | 1.25     |

### 7. Defense

```
defense = base_armor_defense_sum
        × Π(skill.def_multiplier)
        + Σ(skill.def_additive)
```

base_armor_defense_sum = somma defense di tutti e 5 i pezzi armatura

### 8. Elemental Resistances

```
fire_res = Σ(armor_piece.fire_res) + Σ(skill.fire_res_additive)
```
(Uguale per water, thunder, ice, dragon)

---

## Uptime delle skill

Alcune skill sono attive solo per una frazione del tempo (uptime < 1.0):
- Il campo `duration_s` e `cooldown_s` in `skill_levels` permettono il calcolo
- Uptime = duration / (duration + cooldown)
- Per skill senza cooldown (es. Peak Performance): uptime configurabile dall'utente o fisso a 1.0
- Il Builder sheet dell'Excel mostra uptimes di riferimento per ogni skill

---

## Estensione futura: DPH per Hitzone

Aggiunta senza refactor al motore esistente:

```
raw_dph = true_raw
        × motion_value.raw_mv          ← da tabella motion_values
        × sharpness_raw_mod
        × weapon.rmv                   ← Raw Motion Value del tipo arma
        × hitzone.cut_or_impact        ← da tabella hitzone_values
        × affinity_multiplier
        × num_hits

elem_dph = true_element
         × motion_value.elem_mv
         × sharpness_elem_mod
         × weapon.emv
         × hitzone.element_type        ← fire/water/thunder/ice/dragon
         × num_hits

total_dph = raw_dph + elem_dph
```

Tabelle aggiuntive necessarie:
- `motion_values` (già nel Excel, sheet GS/LS/SnS/...)
- `hitzone_values` (sheet "Hitzone values Data")

---

## Buffs item (da Calculator sheet)

Questi sono bonus flat al raw applicati prima dei moltiplicatori skill:
| Item | Bonus |
|------|-------|
| Mega Demondrug | +10 |
| Powercharm | +6 |
| Demon Powder | +10 |
| Attack Seed | variabile |
| Food Buff | variabile |

Nella build MVP: gestiti come flag booleani nella build o come skill speciali.
