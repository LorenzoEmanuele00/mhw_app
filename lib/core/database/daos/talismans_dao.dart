import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/user_tables.dart';

part 'talismans_dao.g.dart';

@DriftAccessor(tables: [Talismans])
class TalismansDao extends DatabaseAccessor<AppDatabase>
    with _$TalismansDaoMixin {
  TalismansDao(super.db);

  Stream<List<Talisman>> watchAll() =>
      (select(talismans)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Future<Talisman?> getById(int id) =>
      (select(talismans)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insert(TalismansCompanion entry) => into(talismans).insert(entry);

  Future<bool> updateTalisman(TalismansCompanion entry) =>
      (update(talismans)..where((t) => t.id.equals(entry.id.value)))
          .write(entry)
          .then((count) => count > 0);

  Future<int> deleteById(int id) =>
      (delete(talismans)..where((t) => t.id.equals(id))).go();
}
