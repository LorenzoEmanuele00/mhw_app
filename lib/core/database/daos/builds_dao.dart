import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/user_tables.dart';

part 'builds_dao.g.dart';

@DriftAccessor(tables: [Builds, BuildJewels])
class BuildsDao extends DatabaseAccessor<AppDatabase> with _$BuildsDaoMixin {
  BuildsDao(super.db);

  Stream<List<Build>> watchAll() =>
      (select(builds)..orderBy([(b) => OrderingTerm.desc(b.updatedAt)])).watch();

  Future<Build?> getById(int id) =>
      (select(builds)..where((b) => b.id.equals(id))).getSingleOrNull();

  Future<List<BuildJewel>> getJewelsForBuild(int buildId) =>
      (select(buildJewels)..where((j) => j.buildId.equals(buildId))).get();

  Future<int> insertBuild(BuildsCompanion entry) => into(builds).insert(entry);

  Future<bool> updateBuild(BuildsCompanion entry) =>
      (update(builds)..where((b) => b.id.equals(entry.id.value)))
          .write(entry)
          .then((count) => count > 0);

  Future<int> deleteBuild(int id) =>
      (delete(builds)..where((b) => b.id.equals(id))).go();

  Future<void> replaceJewels(int buildId, List<BuildJewelsCompanion> rows) =>
      transaction(() async {
        await (delete(buildJewels)..where((j) => j.buildId.equals(buildId))).go();
        if (rows.isNotEmpty) {
          await batch((b) => b.insertAll(buildJewels, rows));
        }
      });
}
