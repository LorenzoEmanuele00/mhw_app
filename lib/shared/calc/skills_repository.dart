import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/providers/database_provider.dart';

class SkillsRepository {
  final AppDatabase _db;
  SkillsRepository(this._db);

  Stream<List<Skill>> watchAll() => _db.skillsDao.watchAll();

  Future<Skill?> getById(String id) => _db.skillsDao.getById(id);

  Future<List<SkillLevel>> getLevels(String skillId) =>
      _db.skillsDao.getLevelsForSkill(skillId);

  Future<SkillLevel?> getLevel(String skillId, int level) =>
      _db.skillsDao.getSkillLevel(skillId, level);
}

final skillsRepositoryProvider = Provider<SkillsRepository>((ref) {
  return SkillsRepository(ref.watch(databaseProvider));
});

final allSkillsProvider = StreamProvider<List<Skill>>((ref) {
  return ref.watch(skillsRepositoryProvider).watchAll();
});
