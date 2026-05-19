import '../../core/database/database.dart';
import '../../core/database/tables/enums.dart';
import 'build_stats.dart';

/// Pure-Dart calc engine. No Flutter or Drift dependencies at runtime.
/// All DB data must be fetched by the caller and passed in.
class CalcEngine {
  // From CALC_ENGINE.md
  static const Map<SharpnessLevel, ({double raw, double elem})> sharpnessMods = {
    SharpnessLevel.red:    (raw: 0.50, elem: 0.25),
    SharpnessLevel.orange: (raw: 0.75, elem: 0.50),
    SharpnessLevel.yellow: (raw: 1.00, elem: 0.75),
    SharpnessLevel.green:  (raw: 1.05, elem: 1.00),
    SharpnessLevel.blue:   (raw: 1.20, elem: 1.0625),
    SharpnessLevel.white:  (raw: 1.32, elem: 1.15),
    SharpnessLevel.purple: (raw: 1.39, elem: 1.25),
  };

  /// Compute [BuildStats] from the active build data.
  ///
  /// [activeSkills] — fully aggregated skill list (armor + talisman + jewels + set bonuses).
  /// [skillLevelsById] — all SkillLevel rows keyed by skillId (pre-fetched once).
  /// [armorPieces] — up to 5 equipped armor pieces (nulls for empty slots).
  static BuildStats compute({
    required Weapon? weapon,
    required List<ArmorPiece?> armorPieces,
    required List<({Skill skill, int level})> activeSkills,
    required Map<int, List<SkillLevel>> skillLevelsById,
  }) {
    double atkMultiplier = 1.0;
    double atkAdditive = 0.0;
    double affinityAdditive = 0.0;
    double elemMultiplier = 1.0;
    double elemAdditive = 0.0;
    double defMultiplier = 1.0;
    double defAdditive = 0.0;
    double fireResAdd = 0.0;
    double waterResAdd = 0.0;
    double thunderResAdd = 0.0;
    double iceResAdd = 0.0;
    double dragonResAdd = 0.0;
    int sharpnessBonus = 0;

    for (final entry in activeSkills) {
      final levels = skillLevelsById[entry.skill.id] ?? [];
      final row = levels.where((l) => l.level == entry.level).firstOrNull;
      if (row == null) continue;

      // Uptime: used for time-gated affinity bonuses (Agitator, Maximum Might, etc.)
      double uptime = 1.0;
      if (row.durationS != null && row.cooldownS != null && row.cooldownS! > 0) {
        uptime = row.durationS! / (row.durationS! + row.cooldownS!);
      }

      for (final (type, value) in [
        (row.bonus1Type, row.bonus1Value),
        (row.bonus2Type, row.bonus2Value),
        (row.bonus3Type, row.bonus3Value),
      ]) {
        if (type == null || value == null) continue;
        switch (type) {
          case 'atk_multiplier':
            atkMultiplier *= value;
          case 'atk_additive':
            atkAdditive += value;
          case 'affinity_additive':
            affinityAdditive += value * uptime;
          case 'elem_multiplier':
            elemMultiplier *= value;
          case 'elem_additive':
            elemAdditive += value;
          case 'def_multiplier':
            defMultiplier *= value;
          case 'def_additive':
            defAdditive += value;
          case 'elem_res_additive':
            fireResAdd += value;
            waterResAdd += value;
            thunderResAdd += value;
            iceResAdd += value;
            dragonResAdd += value;
          case 'fire_res_additive':
            fireResAdd += value;
          case 'water_res_additive':
            waterResAdd += value;
          case 'thunder_res_additive':
            thunderResAdd += value;
          case 'ice_res_additive':
            iceResAdd += value;
          case 'dragon_res_additive':
            dragonResAdd += value;
          case 'sharpness_additive':
            sharpnessBonus += value.toInt();
        }
      }
    }

    // True Raw: base × Π(atk_multiplier) + Σ(atk_additive)
    final baseRaw = weapon?.baseAttack.toDouble() ?? 0.0;
    final trueRaw = baseRaw * atkMultiplier + atkAdditive;

    // Effective Affinity in percentage points
    final baseAff = weapon?.baseAffinity ?? 0.0;
    final effectiveAffinity = baseAff + affinityAdditive;

    // True Element: base × 0.1 × Π(elem_multiplier) + Σ(elem_additive)
    final baseElem = weapon?.elementValue?.toDouble() ?? 0.0;
    final trueElement = baseElem * 0.1 * elemMultiplier + elemAdditive;

    // Effective Sharpness (Handicraft adds steps up the SharpnessLevel enum)
    final baseSharpness = weapon?.sharpnessMax ?? SharpnessLevel.white;
    final effectiveSharpness = _applySharpnessBonus(baseSharpness, sharpnessBonus);
    final sharpMod = sharpnessMods[effectiveSharpness]!;

    // Defense: Σ(base_defense) × Π(def_multiplier) + Σ(def_additive)
    final baseDefense = armorPieces.fold(0, (sum, p) => sum + (p?.baseDefense ?? 0)).toDouble();
    final totalDefense = (baseDefense * defMultiplier + defAdditive).round();

    // Elemental Resistances: Σ(armor_piece.X_res) + Σ(X_res_additive)
    int fireResBase = 0;
    int waterResBase = 0;
    int thunderResBase = 0;
    int iceResBase = 0;
    int dragonResBase = 0;
    for (final p in armorPieces) {
      if (p == null) continue;
      fireResBase += p.fireRes;
      waterResBase += p.waterRes;
      thunderResBase += p.thunderRes;
      iceResBase += p.iceRes;
      dragonResBase += p.dragonRes;
    }

    return BuildStats(
      trueRaw: trueRaw,
      effectiveAffinity: effectiveAffinity,
      trueElement: trueElement,
      elementType: weapon?.elementType,
      effectiveSharpness: effectiveSharpness,
      sharpnessRawMod: sharpMod.raw,
      sharpnessElemMod: sharpMod.elem,
      totalDefense: totalDefense,
      fireRes: (fireResBase + fireResAdd).round(),
      waterRes: (waterResBase + waterResAdd).round(),
      thunderRes: (thunderResBase + thunderResAdd).round(),
      iceRes: (iceResBase + iceResAdd).round(),
      dragonRes: (dragonResBase + dragonResAdd).round(),
    );
  }

  static SharpnessLevel _applySharpnessBonus(SharpnessLevel base, int bonus) {
    if (bonus <= 0) return base;
    final idx = SharpnessLevel.values.indexOf(base);
    final newIdx = (idx + bonus).clamp(0, SharpnessLevel.values.length - 1);
    return SharpnessLevel.values[newIdx];
  }
}
