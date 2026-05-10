import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/providers/database_provider.dart';

class TalismansRepository {
  final AppDatabase _db;
  TalismansRepository(this._db);

  Stream<List<Talisman>> watchAll() => _db.talismansDao.watchAll();

  Future<Talisman?> getById(int id) => _db.talismansDao.getById(id);

  Future<int> create(TalismansCompanion entry) =>
      _db.talismansDao.insert(entry);

  Future<bool> update(TalismansCompanion entry) =>
      _db.talismansDao.updateTalisman(entry);

  Future<int> delete(int id) => _db.talismansDao.deleteById(id);
}

final talismansRepositoryProvider = Provider<TalismansRepository>((ref) {
  return TalismansRepository(ref.watch(databaseProvider));
});

final allTalismansProvider = StreamProvider<List<Talisman>>((ref) {
  return ref.watch(talismansRepositoryProvider).watchAll();
});
