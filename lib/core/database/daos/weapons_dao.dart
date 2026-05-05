import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/game_tables.dart';

part 'weapons_dao.g.dart';

@DriftAccessor(tables: [Weapons])
class WeaponsDao extends DatabaseAccessor<AppDatabase> with _$WeaponsDaoMixin {
  WeaponsDao(super.db);

  Stream<List<Weapon>> watchAll() => select(weapons).watch();

  Stream<List<Weapon>> watchByType(String weaponType) =>
      (select(weapons)..where((w) => w.weaponType.equals(weaponType))).watch();

  Future<Weapon?> getById(String id) =>
      (select(weapons)..where((w) => w.id.equals(id))).getSingleOrNull();

  Future<void> replaceAll(List<WeaponsCompanion> rows) => transaction(() async {
        await delete(weapons).go();
        await batch((b) => b.insertAll(weapons, rows));
      });
}
