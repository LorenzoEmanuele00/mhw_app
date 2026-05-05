import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/game_tables.dart';

part 'skills_dao.g.dart';

@DriftAccessor(tables: [Skills, SkillLevels, Jewels])
class SkillsDao extends DatabaseAccessor<AppDatabase> with _$SkillsDaoMixin {
  SkillsDao(super.db);

  Stream<List<Skill>> watchAll() => select(skills).watch();

  Future<Skill?> getById(String id) =>
      (select(skills)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<List<SkillLevel>> getLevelsForSkill(String skillId) =>
      (select(skillLevels)..where((sl) => sl.skillId.equals(skillId))).get();

  Future<SkillLevel?> getSkillLevel(String skillId, int level) =>
      (select(skillLevels)
            ..where((sl) => sl.skillId.equals(skillId) & sl.level.equals(level)))
          .getSingleOrNull();

  Stream<List<Jewel>> watchAllJewels() => select(jewels).watch();

  Future<void> replaceAllSkills(List<SkillsCompanion> rows) =>
      transaction(() async {
        await delete(skills).go();
        await batch((b) => b.insertAll(skills, rows));
      });

  Future<void> replaceAllSkillLevels(List<SkillLevelsCompanion> rows) =>
      transaction(() async {
        await delete(skillLevels).go();
        await batch((b) => b.insertAll(skillLevels, rows));
      });

  Future<void> replaceAllJewels(List<JewelsCompanion> rows) =>
      transaction(() async {
        await delete(jewels).go();
        await batch((b) => b.insertAll(jewels, rows));
      });
}
