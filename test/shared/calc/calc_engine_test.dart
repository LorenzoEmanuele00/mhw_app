import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/database/database.dart';
import 'package:mhw_app/core/database/tables/enums.dart';
import 'package:mhw_app/shared/calc/calc_engine.dart';

// ---------------------------------------------------------------------------
// Helpers — construct minimal DB rows without running a real DB
// ---------------------------------------------------------------------------

AppDatabase _db() => AppDatabase.forTesting(NativeDatabase.memory());

/// Build a minimal Weapon row with the supplied fields.
Weapon _weapon({
  int attack = 200,
  double affinity = 0,
  int? elementValue,
  ElementType? elementType,
  SharpnessLevel sharpness = SharpnessLevel.white,
}) =>
    Weapon(
      id: 1,
      slug: 'test_gs',
      name: 'Test GS',
      weaponType: WeaponType.gs,
      baseAttack: attack,
      baseAffinity: affinity,
      elementType: elementType,
      elementValue: elementValue,
      sharpnessMax: sharpness,
      rarity: 7,
      slots: '[]',
      rmv: 1.0,
      emv: 1.0,
      damageType: DamageType.cut,
      burstGroup: 'Other',
    );

Skill _skill(int id, {int maxLevel = 7}) => Skill(
      id: id,
      slug: 'skill_$id',
      name: 'Skill $id',
      maxLevel: maxLevel,
      type1: SkillCategory.armor,
      type2: SkillSubcategory.offensive,
    );

SkillLevel _level({
  required int skillId,
  required int level,
  String? b1Type,
  double? b1Val,
  String? b2Type,
  double? b2Val,
  String? b3Type,
  double? b3Val,
  double? duration,
  double? cooldown,
}) =>
    SkillLevel(
      id: skillId * 100 + level,
      skillId: skillId,
      level: level,
      piecesRequired: null,
      bonus1Type: b1Type,
      bonus1Value: b1Val,
      bonus2Type: b2Type,
      bonus2Value: b2Val,
      bonus3Type: b3Type,
      bonus3Value: b3Val,
      durationS: duration,
      cooldownS: cooldown,
    );

Map<int, List<SkillLevel>> _levelsMap(List<SkillLevel> rows) {
  final map = <int, List<SkillLevel>>{};
  for (final r in rows) {
    map.putIfAbsent(r.skillId, () => []).add(r);
  }
  return map;
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('CalcEngine — no skills', () {
    test('no weapon → zero raw', () {
      final stats = CalcEngine.compute(
        weapon: null,
        armorPieces: [],
        activeSkills: [],
        skillLevelsById: {},
      );
      expect(stats.trueRaw, 0.0);
    });

    test('weapon only, no skills → raw = baseAttack', () {
      final stats = CalcEngine.compute(
        weapon: _weapon(attack: 150),
        armorPieces: [],
        activeSkills: [],
        skillLevelsById: {},
      );
      expect(stats.trueRaw, 150.0);
    });

    test('weapon affinity passthrough', () {
      final stats = CalcEngine.compute(
        weapon: _weapon(affinity: 25),
        armorPieces: [],
        activeSkills: [],
        skillLevelsById: {},
      );
      expect(stats.effectiveAffinity, 25.0);
    });

    test('element value: base_element × 0.1', () {
      final stats = CalcEngine.compute(
        weapon: _weapon(elementValue: 300, elementType: ElementType.fire),
        armorPieces: [],
        activeSkills: [],
        skillLevelsById: {},
      );
      expect(stats.trueElement, closeTo(30.0, 0.001));
      expect(stats.elementType, ElementType.fire);
    });
  });

  group('CalcEngine — attack skills', () {
    test('atk_additive adds flat damage', () {
      final skill = _skill(1);
      final skillRow = _level(
        skillId: 1,
        level: 4,
        b1Type: 'atk_additive',
        b1Val: 12.0,
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(attack: 200),
        armorPieces: [],
        activeSkills: [(skill: skill, level: 4)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      expect(stats.trueRaw, 212.0);
    });

    test('atk_multiplier scales raw', () {
      final skill = _skill(2);
      final skillRow = _level(
        skillId: 2,
        level: 7,
        b1Type: 'atk_multiplier',
        b1Val: 1.10,
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(attack: 200),
        armorPieces: [],
        activeSkills: [(skill: skill, level: 7)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      expect(stats.trueRaw, closeTo(220.0, 0.001));
    });

    test('atk_multiplier + atk_additive combine correctly', () {
      // Attack Boost lv7: ×1.10 + 35
      final skill = _skill(3, maxLevel: 7);
      final skillRow = _level(
        skillId: 3,
        level: 7,
        b1Type: 'atk_multiplier',
        b1Val: 1.10,
        b2Type: 'atk_additive',
        b2Val: 35.0,
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(attack: 200),
        armorPieces: [],
        activeSkills: [(skill: skill, level: 7)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      // 200 × 1.10 + 35 = 255
      expect(stats.trueRaw, closeTo(255.0, 0.001));
    });

    test('multiple additive skills stack', () {
      final s1 = _skill(1);
      final s2 = _skill(2);
      final rows = [
        _level(skillId: 1, level: 3, b1Type: 'atk_additive', b1Val: 10.0),
        _level(skillId: 2, level: 2, b1Type: 'atk_additive', b1Val: 8.0),
      ];
      final stats = CalcEngine.compute(
        weapon: _weapon(attack: 100),
        armorPieces: [],
        activeSkills: [
          (skill: s1, level: 3),
          (skill: s2, level: 2),
        ],
        skillLevelsById: _levelsMap(rows),
      );
      expect(stats.trueRaw, 118.0);
    });
  });

  group('CalcEngine — affinity skills', () {
    test('affinity_additive stacks with base', () {
      final skill = _skill(10);
      final skillRow = _level(
        skillId: 10,
        level: 7,
        b1Type: 'affinity_additive',
        b1Val: 40.0,
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(affinity: 10),
        armorPieces: [],
        activeSkills: [(skill: skill, level: 7)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      expect(stats.effectiveAffinity, closeTo(50.0, 0.001));
    });

    test('affinity_additive with uptime (Agitator pattern)', () {
      final skill = _skill(11);
      // duration=30, cooldown=5 → uptime = 30/(30+5) ≈ 0.857
      final skillRow = _level(
        skillId: 11,
        level: 5,
        b1Type: 'affinity_additive',
        b1Val: 15.0,
        duration: 30.0,
        cooldown: 5.0,
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(affinity: 0),
        armorPieces: [],
        activeSkills: [(skill: skill, level: 5)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      final expectedUptime = 30 / (30 + 5);
      expect(stats.effectiveAffinity, closeTo(15.0 * expectedUptime, 0.01));
    });
  });

  group('CalcEngine — defense', () {
    test('totalDefense sums armor pieces', () {
      final db = _db();
      // Build minimal ArmorPiece rows inline (id, slug, name, slotType, setId, ...)
      final headPiece = ArmorPiece(
        id: 1, slug: 'head', name: 'Head', slotType: ArmorSlotType.head,
        baseDefense: 50, fireRes: 0, waterRes: 0, thunderRes: 0,
        iceRes: 0, dragonRes: 0, rarity: 7, slots: '[]', setId: 1,
      );
      final chestPiece = ArmorPiece(
        id: 2, slug: 'chest', name: 'Chest', slotType: ArmorSlotType.chest,
        baseDefense: 60, fireRes: 0, waterRes: 0, thunderRes: 0,
        iceRes: 0, dragonRes: 0, rarity: 7, slots: '[]', setId: 1,
      );
      db.close();
      final stats = CalcEngine.compute(
        weapon: null,
        armorPieces: [headPiece, chestPiece, null, null, null],
        activeSkills: [],
        skillLevelsById: {},
      );
      expect(stats.totalDefense, 110);
    });

    test('def_additive adds flat defense', () {
      final skill = _skill(20);
      final skillRow = _level(
        skillId: 20,
        level: 3,
        b1Type: 'def_additive',
        b1Val: 20.0,
      );
      final headPiece = ArmorPiece(
        id: 1, slug: 'head', name: 'Head', slotType: ArmorSlotType.head,
        baseDefense: 50, fireRes: 0, waterRes: 0, thunderRes: 0,
        iceRes: 0, dragonRes: 0, rarity: 7, slots: '[]', setId: 1,
      );
      final stats = CalcEngine.compute(
        weapon: null,
        armorPieces: [headPiece, null, null, null, null],
        activeSkills: [(skill: skill, level: 3)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      // 50 × 1.0 + 20 = 70
      expect(stats.totalDefense, 70);
    });

    test('def_multiplier scales base defense', () {
      final skill = _skill(21);
      final skillRow = _level(
        skillId: 21,
        level: 3,
        b1Type: 'def_multiplier',
        b1Val: 1.20,
      );
      final headPiece = ArmorPiece(
        id: 1, slug: 'head', name: 'Head', slotType: ArmorSlotType.head,
        baseDefense: 100, fireRes: 0, waterRes: 0, thunderRes: 0,
        iceRes: 0, dragonRes: 0, rarity: 7, slots: '[]', setId: 1,
      );
      final stats = CalcEngine.compute(
        weapon: null,
        armorPieces: [headPiece, null, null, null, null],
        activeSkills: [(skill: skill, level: 3)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      expect(stats.totalDefense, 120);
    });
  });

  group('CalcEngine — elemental resistances', () {
    ArmorPiece piece(
      int id,
      ArmorSlotType slot, {
      int fire = 0, int water = 0, int thunder = 0, int ice = 0, int dragon = 0,
    }) =>
        ArmorPiece(
          id: id, slug: 'piece_$id', name: 'Piece $id', slotType: slot,
          baseDefense: 0, fireRes: fire, waterRes: water, thunderRes: thunder,
          iceRes: ice, dragonRes: dragon, rarity: 7, slots: '[]', setId: 1,
        );

    test('sums fire res across pieces', () {
      final stats = CalcEngine.compute(
        weapon: null,
        armorPieces: [
          piece(1, ArmorSlotType.head, fire: 5),
          piece(2, ArmorSlotType.chest, fire: -3),
          null, null, null,
        ],
        activeSkills: [],
        skillLevelsById: {},
      );
      expect(stats.fireRes, 2);
    });

    test('fire_res_additive skill adds on top', () {
      final skill = _skill(30);
      final skillRow = _level(
        skillId: 30,
        level: 3,
        b1Type: 'fire_res_additive',
        b1Val: 15.0,
      );
      final stats = CalcEngine.compute(
        weapon: null,
        armorPieces: [piece(1, ArmorSlotType.head, fire: -5), null, null, null, null],
        activeSkills: [(skill: skill, level: 3)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      expect(stats.fireRes, 10);
    });
  });

  group('CalcEngine — sharpness', () {
    test('no bonus → effectiveSharpness = weapon sharpnessMax', () {
      final stats = CalcEngine.compute(
        weapon: _weapon(sharpness: SharpnessLevel.blue),
        armorPieces: [],
        activeSkills: [],
        skillLevelsById: {},
      );
      expect(stats.effectiveSharpness, SharpnessLevel.blue);
      expect(stats.sharpnessRawMod, CalcEngine.sharpnessMods[SharpnessLevel.blue]!.raw);
    });

    test('sharpness_additive: 1 step up', () {
      final skill = _skill(40);
      final skillRow = _level(
        skillId: 40,
        level: 3,
        b1Type: 'sharpness_additive',
        b1Val: 1.0,
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(sharpness: SharpnessLevel.blue),
        armorPieces: [],
        activeSkills: [(skill: skill, level: 3)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      expect(stats.effectiveSharpness, SharpnessLevel.white);
    });

    test('sharpness_additive clamped at purple', () {
      final skill = _skill(41);
      final skillRow = _level(
        skillId: 41,
        level: 5,
        b1Type: 'sharpness_additive',
        b1Val: 10.0, // way too much — should clamp at purple
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(sharpness: SharpnessLevel.white),
        armorPieces: [],
        activeSkills: [(skill: skill, level: 5)],
        skillLevelsById: _levelsMap([skillRow]),
      );
      expect(stats.effectiveSharpness, SharpnessLevel.purple);
    });
  });

  group('CalcEngine — set bonus activation', () {
    // Set bonuses are activated in BuildNotifier._resolve, not in CalcEngine.
    // CalcEngine simply processes whatever activeSkills it receives.
    // This test verifies that a set bonus skill (already merged in) is applied.
    test('set bonus skill contributes as a normal active skill', () {
      // Simulate: Gore Magala 2-piece bonus → adds 30 affinity
      final setBonusSkill = _skill(50, maxLevel: 1);
      final setBonusLevel = _level(
        skillId: 50,
        level: 1,
        b1Type: 'affinity_additive',
        b1Val: 30.0,
      );
      final stats = CalcEngine.compute(
        weapon: _weapon(affinity: 10),
        armorPieces: [],
        activeSkills: [(skill: setBonusSkill, level: 1)],
        skillLevelsById: _levelsMap([setBonusLevel]),
      );
      expect(stats.effectiveAffinity, closeTo(40.0, 0.001));
    });
  });

  group('CalcEngine — sharpness modifiers table', () {
    test('all seven entries are present', () {
      for (final level in SharpnessLevel.values) {
        expect(CalcEngine.sharpnessMods.containsKey(level), isTrue,
            reason: 'Missing sharpness mod for $level');
      }
    });

    test('raw modifier increases with sharpness level', () {
      final levels = SharpnessLevel.values;
      for (int i = 1; i < levels.length; i++) {
        final prev = CalcEngine.sharpnessMods[levels[i - 1]]!.raw;
        final curr = CalcEngine.sharpnessMods[levels[i]]!.raw;
        expect(curr, greaterThan(prev),
            reason: '${levels[i]} raw should > ${levels[i - 1]} raw');
      }
    });
  });
}
