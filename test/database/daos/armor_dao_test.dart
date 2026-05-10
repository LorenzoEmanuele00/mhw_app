import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/database/database.dart';
import 'package:mhw_app/core/database/tables/enums.dart';

AppDatabase _openInMemory() =>
    AppDatabase.forTesting(NativeDatabase.memory());

void main() {
  late AppDatabase db;

  setUp(() => db = _openInMemory());
  tearDown(() => db.close());

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Future<int> insertSkill(String slug, String name) => db
      .into(db.skills)
      .insert(SkillsCompanion.insert(slug: slug, name: name, maxLevel: 3));

  Future<int> insertSet({String name = 'Rathalos'}) => db
      .into(db.armorSets)
      .insert(ArmorSetsCompanion.insert(slug: 'rathalos', name: name));

  Future<int> insertPiece({
    required int setId,
    String slug = 'rathalos_helm',
    String name = 'Rathalos Helm',
    ArmorSlotType kind = ArmorSlotType.head,
  }) =>
      db.into(db.armorPieces).insert(ArmorPiecesCompanion.insert(
            slug: slug,
            name: name,
            slotType: kind,
            setId: setId,
          ));

  // ---------------------------------------------------------------------------
  // ArmorSets
  // ---------------------------------------------------------------------------

  group('ArmorSets', () {
    test('insert and query a set', () async {
      final setId = await insertSet(name: 'Rathalos');
      final sets = await db.select(db.armorSets).get();
      expect(sets.length, 1);
      expect(sets.first.name, 'Rathalos');
      expect(sets.first.id, setId);
    });
  });

  // ---------------------------------------------------------------------------
  // ArmorPieces
  // ---------------------------------------------------------------------------

  group('ArmorPieces', () {
    test('insert a piece and read it back', () async {
      final setId = await insertSet();
      final pieceId = await insertPiece(setId: setId);

      final pieces = await db.select(db.armorPieces).get();
      expect(pieces.length, 1);
      final p = pieces.first;
      expect(p.id, pieceId);
      expect(p.slotType, ArmorSlotType.head);
      expect(p.setId, setId);
    });

    test('rarity defaults to 1', () async {
      final setId = await insertSet();
      await insertPiece(setId: setId);
      final piece = (await db.select(db.armorPieces).get()).first;
      expect(piece.rarity, 1);
    });

    test('resistances default to 0', () async {
      final setId = await insertSet();
      await insertPiece(setId: setId);
      final p = (await db.select(db.armorPieces).get()).first;
      expect(p.fireRes, 0);
      expect(p.waterRes, 0);
      expect(p.thunderRes, 0);
      expect(p.iceRes, 0);
      expect(p.dragonRes, 0);
    });

    test('insert piece with resistances and slots', () async {
      final setId = await insertSet();
      await db.into(db.armorPieces).insert(ArmorPiecesCompanion.insert(
            slug: 'gore_helm',
            name: 'Gore Helm α',
            slotType: ArmorSlotType.head,
            setId: setId,
            baseDefense: Value(48),
            fireRes: Value(-3),
            waterRes: Value(2),
            thunderRes: Value(0),
            iceRes: Value(1),
            dragonRes: Value(-2),
            rarity: Value(7),
            slots: Value('[2,1]'),
          ));
      final p = (await db.select(db.armorPieces).get()).first;
      expect(p.baseDefense, 48);
      expect(p.fireRes, -3);
      expect(p.slots, '[2,1]');
    });
  });

  // ---------------------------------------------------------------------------
  // ArmorPieceSkills
  // ---------------------------------------------------------------------------

  group('ArmorPieceSkills', () {
    test('insert piece skills and query them', () async {
      final setId = await insertSet();
      final pieceId = await insertPiece(setId: setId);
      final skillId = await insertSkill('critical_eye', 'Critical Eye');

      await db.into(db.armorPieceSkills).insert(
            ArmorPieceSkillsCompanion.insert(
              armorPieceId: pieceId,
              skillId: skillId,
              skillLevel: 2,
            ),
          );

      final rows = await db.select(db.armorPieceSkills).get();
      expect(rows.length, 1);
      expect(rows.first.armorPieceId, pieceId);
      expect(rows.first.skillId, skillId);
      expect(rows.first.skillLevel, 2);
    });

    test('one piece can have multiple skills', () async {
      final setId = await insertSet();
      final pieceId = await insertPiece(setId: setId);
      final skill1 = await insertSkill('critical_eye', 'Critical Eye');
      final skill2 = await insertSkill('attack_boost', 'Attack Boost');

      for (final (sid, lvl) in [(skill1, 2), (skill2, 1)]) {
        await db.into(db.armorPieceSkills).insert(
              ArmorPieceSkillsCompanion.insert(
                armorPieceId: pieceId,
                skillId: sid,
                skillLevel: lvl,
              ),
            );
      }

      final rows = await db.select(db.armorPieceSkills).get();
      expect(rows.length, 2);
    });
  });

  // ---------------------------------------------------------------------------
  // ArmorSetSkills
  // ---------------------------------------------------------------------------

  group('ArmorSetSkills', () {
    test('insert a set bonus and read it back', () async {
      final setId = await insertSet();
      final skillId = await insertSkill('gore_magalas_tyranny', "Gore Magala's Tyranny");

      await db.into(db.armorSetSkills).insert(
            ArmorSetSkillsCompanion.insert(
              setId: setId,
              requiredPieces: 2,
              skillId: skillId,
              skillLevel: 1,
              skillCategory: SetSkillType.set,
            ),
          );

      final rows = await db.select(db.armorSetSkills).get();
      expect(rows.length, 1);
      expect(rows.first.requiredPieces, 2);
      expect(rows.first.skillCategory, SetSkillType.set);
    });

    test('group bonus uses SetSkillType.group', () async {
      final setId = await insertSet();
      final skillId = await insertSkill('guardians_protection', "Guardian's Protection");

      await db.into(db.armorSetSkills).insert(
            ArmorSetSkillsCompanion.insert(
              setId: setId,
              requiredPieces: 3,
              skillId: skillId,
              skillLevel: 1,
              skillCategory: SetSkillType.group,
            ),
          );

      final row = (await db.select(db.armorSetSkills).get()).first;
      expect(row.skillCategory, SetSkillType.group);
    });
  });
}
