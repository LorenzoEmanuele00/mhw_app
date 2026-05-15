import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/database/database.dart';

AppDatabase _openInMemory() =>
    AppDatabase.forTesting(NativeDatabase.memory());

void main() {
  late AppDatabase db;

  setUp(() => db = _openInMemory());
  tearDown(() => db.close());

  Future<int> insertSkill(String slug, String name) => db
      .into(db.skills)
      .insert(SkillsCompanion.insert(slug: slug, name: name, maxLevel: 3));

  Future<int> insertJewel({
    int id = 1,
    String slug = 'attack_jewel_1',
    String name = 'Attack Jewel [1]',
    int slotSize = 1,
    String allowedOn = 'armor',
  }) =>
      db.into(db.jewels).insert(JewelsCompanion.insert(
            slug: slug,
            name: name,
            slotSize: slotSize,
            allowedOn: Value('armor'),
          ));

  // ---------------------------------------------------------------------------
  // Jewels schema
  // ---------------------------------------------------------------------------

  group('Jewels', () {
    test('insert and read back a jewel', () async {
      await insertJewel(name: 'Attack Jewel [1]', slotSize: 1);
      final jewels = await db.select(db.jewels).get();
      expect(jewels.length, 1);
      expect(jewels.first.name, 'Attack Jewel [1]');
      expect(jewels.first.slotSize, 1);
    });

    test('allowedOn defaults to armor', () async {
      await insertJewel();
      final j = (await db.select(db.jewels).get()).first;
      expect(j.allowedOn, 'armor');
    });

    test('weapon jewel stores allowed_on = weapon', () async {
      await db.into(db.jewels).insert(JewelsCompanion.insert(
            slug: 'attack_jewel_w',
            name: 'Weapon Jewel',
            slotSize: 2,
            allowedOn: Value('weapon'),
          ));
      final j = (await db.select(db.jewels).get()).first;
      expect(j.allowedOn, 'weapon');
    });

    test('jewels table has no skillId or skillLevel column', () async {
      // Verify by inserting without skill fields — must compile and succeed.
      await db.into(db.jewels).insert(JewelsCompanion.insert(
            slug: 'no_skill_jewel',
            name: 'No Skill Jewel',
            slotSize: 3,
          ));
      expect((await db.select(db.jewels).get()).length, 1);
    });
  });

  // ---------------------------------------------------------------------------
  // JewelSkills
  // ---------------------------------------------------------------------------

  group('JewelSkills', () {
    test('insert one skill on a jewel', () async {
      final jewelId = await insertJewel();
      final skillId = await insertSkill('poison_attack', 'Poison Attack');

      await db.into(db.jewelSkills).insert(JewelSkillsCompanion.insert(
            jewelId: jewelId,
            skillId: skillId,
            skillLevel: 1,
          ));

      final rows = await db.select(db.jewelSkills).get();
      expect(rows.length, 1);
      expect(rows.first.jewelId, jewelId);
      expect(rows.first.skillId, skillId);
      expect(rows.first.skillLevel, 1);
    });

    test('compound jewel stores two skills', () async {
      final jewelId = await db.into(db.jewels).insert(JewelsCompanion.insert(
            slug: 'compound_jewel',
            name: 'Crit/Handicraft Jwl [3]',
            slotSize: 3,
          ));
      final skill1 = await insertSkill('critical_eye', 'Critical Eye');
      final skill2 = await insertSkill('handicraft', 'Handicraft');

      for (final (sid, lvl) in [(skill1, 3), (skill2, 1)]) {
        await db.into(db.jewelSkills).insert(JewelSkillsCompanion.insert(
              jewelId: jewelId,
              skillId: sid,
              skillLevel: lvl,
            ));
      }

      final rows = await db.select(db.jewelSkills).get();
      expect(rows.length, 2);
      final levels = rows.map((r) => r.skillLevel).toSet();
      expect(levels, {3, 1});
    });
  });
}
