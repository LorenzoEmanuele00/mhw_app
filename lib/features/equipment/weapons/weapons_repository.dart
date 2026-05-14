import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database.dart';
import '../../../core/database/tables/enums.dart';
import '../../../core/providers/database_provider.dart';

class WeaponsRepository {
  final AppDatabase _db;
  WeaponsRepository(this._db);

  Stream<List<Weapon>> watchAll() => _db.weaponsDao.watchAll();

  Stream<List<Weapon>> watchByType(WeaponType weaponType) =>
      _db.weaponsDao.watchByType(weaponType);

  Future<Weapon?> getById(int id) => _db.weaponsDao.getById(id);

  Future<Weapon?> getBySlug(String slug) => _db.weaponsDao.getBySlug(slug);

  Future<void> replaceAll(List<WeaponsCompanion> rows) =>
      _db.weaponsDao.replaceAll(rows);
}

final weaponsRepositoryProvider = Provider<WeaponsRepository>((ref) {
  return WeaponsRepository(ref.watch(databaseProvider));
});

final allWeaponsProvider = StreamProvider<List<Weapon>>((ref) {
  return ref.watch(weaponsRepositoryProvider).watchAll();
});

final weaponsByTypeProvider =
    StreamProvider.family<List<Weapon>, WeaponType>((ref, type) {
  return ref.watch(weaponsRepositoryProvider).watchByType(type);
});
