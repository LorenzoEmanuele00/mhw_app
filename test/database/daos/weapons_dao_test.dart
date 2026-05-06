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

  group('WeaponsDao', () {
    Future<void> insertGreatsword() => db.weaponsDao.replaceAll([
          WeaponsCompanion.insert(
            id: 'gs_iron_1',
            name: 'Iron Greatsword I',
            weaponType: WeaponType.gs,
            baseAttack: 100,
          ),
        ]);

    test('replaceAll inserts rows and watchAll emits them', () async {
      await insertGreatsword();
      final weapons = await db.weaponsDao.watchAll().first;
      expect(weapons.length, 1);
      expect(weapons.first.id, 'gs_iron_1');
      expect(weapons.first.weaponType, WeaponType.gs);
    });

    test('watchByType filters by weapon type', () async {
      await db.weaponsDao.replaceAll([
        WeaponsCompanion.insert(
          id: 'gs_iron_1',
          name: 'Iron Greatsword I',
          weaponType: WeaponType.gs,
          baseAttack: 100,
        ),
        WeaponsCompanion.insert(
          id: 'ls_iron_1',
          name: 'Iron Longsword I',
          weaponType: WeaponType.ls,
          baseAttack: 120,
        ),
      ]);

      final greatswords = await db.weaponsDao.watchByType(WeaponType.gs).first;
      expect(greatswords.length, 1);
      expect(greatswords.first.weaponType, WeaponType.gs);

      final longswords = await db.weaponsDao.watchByType(WeaponType.ls).first;
      expect(longswords.length, 1);
      expect(longswords.first.weaponType, WeaponType.ls);
    });

    test('getById returns null for unknown id', () async {
      final result = await db.weaponsDao.getById('nonexistent');
      expect(result, isNull);
    });

    test('getById returns the weapon when found', () async {
      await insertGreatsword();
      final weapon = await db.weaponsDao.getById('gs_iron_1');
      expect(weapon, isNotNull);
      expect(weapon!.name, 'Iron Greatsword I');
    });

    test('replaceAll clears existing rows before inserting', () async {
      await insertGreatsword();
      await db.weaponsDao.replaceAll([
        WeaponsCompanion.insert(
          id: 'new_weapon',
          name: 'New Weapon',
          weaponType: WeaponType.sns,
          baseAttack: 90,
        ),
      ]);
      final weapons = await db.weaponsDao.watchAll().first;
      expect(weapons.length, 1);
      expect(weapons.first.id, 'new_weapon');
    });

    test('enum round-trip: WeaponType is preserved through DB', () async {
      for (final type in WeaponType.values) {
        await db.weaponsDao.replaceAll([
          WeaponsCompanion.insert(
            id: 'test_${type.name}',
            name: 'Test ${type.name}',
            weaponType: type,
            baseAttack: 100,
          ),
        ]);
        final weapons = await db.weaponsDao.watchAll().first;
        expect(weapons.first.weaponType, type,
            reason: 'WeaponType.${type.name} failed round-trip through DB');
      }
    });
  });
}
