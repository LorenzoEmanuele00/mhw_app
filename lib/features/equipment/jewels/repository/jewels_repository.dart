import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/providers/database_provider.dart';

class JewelsRepository {
  final AppDatabase _db;
  JewelsRepository(this._db);

  Stream<List<Jewel>> watchAll() => _db.skillsDao.watchAllJewels();
}

final jewelsRepositoryProvider = Provider<JewelsRepository>((ref) {
  return JewelsRepository(ref.watch(databaseProvider));
});

final allJewelsProvider = StreamProvider<List<Jewel>>((ref) {
  return ref.watch(jewelsRepositoryProvider).watchAll();
});
