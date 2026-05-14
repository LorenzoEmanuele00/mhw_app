import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database.dart';
import '../../../core/providers/database_provider.dart';

class BuildsRepository {
  final AppDatabase _db;
  BuildsRepository(this._db);

  Stream<List<Build>> watchAll() => _db.buildsDao.watchAll();

  Future<Build?> getById(int id) => _db.buildsDao.getById(id);

  Future<List<BuildJewel>> getJewels(int buildId) =>
      _db.buildsDao.getJewelsForBuild(buildId);

  Future<int> create(BuildsCompanion entry) =>
      _db.buildsDao.insertBuild(entry);

  Future<bool> update(BuildsCompanion entry) =>
      _db.buildsDao.updateBuild(entry);

  Future<int> delete(int id) => _db.buildsDao.deleteBuild(id);

  Future<void> replaceJewels(int buildId, List<BuildJewelsCompanion> jewels) =>
      _db.buildsDao.replaceJewels(buildId, jewels);
}

final buildsRepositoryProvider = Provider<BuildsRepository>((ref) {
  return BuildsRepository(ref.watch(databaseProvider));
});

final allBuildsProvider = StreamProvider<List<Build>>((ref) {
  return ref.watch(buildsRepositoryProvider).watchAll();
});
