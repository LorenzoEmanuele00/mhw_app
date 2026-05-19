import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/database/tables/enums.dart';
import 'package:mhw_app/features/equipment/models/equipment_filter.dart';

void main() {
  group('EquipmentFilters', () {
    test('default state has isDefault = true', () {
      const f = EquipmentFilters();
      expect(f.isDefault, isTrue);
    });

    test('activeFilterCount is 0 for default', () {
      const f = EquipmentFilters();
      expect(f.activeFilterCount, 0);
    });

    test('activeFilterCount increments for each active filter', () {
      final f = EquipmentFilters(
        weaponTypes: {WeaponType.gs, WeaponType.ls},
        elements: {ElementType.fire},
        rarityMin: 5,
        sortBy: EquipSortBy.attack,
      );
      // weaponTypes, elements, rarityMin, sortBy → 4
      expect(f.activeFilterCount, 4);
    });

    test('includeNoElement = false increments activeFilterCount', () {
      const f = EquipmentFilters(includeNoElement: false);
      expect(f.activeFilterCount, 1);
    });

    test('elements non-empty but includeNoElement = true → 1 count', () {
      final f = EquipmentFilters(elements: {ElementType.fire});
      expect(f.activeFilterCount, 1);
    });

    test('copyWith preserves unchanged fields', () {
      final original = EquipmentFilters(
        weaponTypes: {WeaponType.gs},
        sortBy: EquipSortBy.rarity,
      );
      final copy = original.copyWith(rarityMin: 3);
      expect(copy.weaponTypes, {WeaponType.gs});
      expect(copy.sortBy, EquipSortBy.rarity);
      expect(copy.rarityMin, 3);
    });

    test('copyWith(sortBy: ...) changes only sortBy', () {
      const f = EquipmentFilters();
      final f2 = f.copyWith(sortBy: EquipSortBy.defense);
      expect(f2.sortBy, EquipSortBy.defense);
      expect(f2.isDefault, isFalse);
    });

    test('non-default after weapon type filter added', () {
      final f = EquipmentFilters(weaponTypes: {WeaponType.hmr});
      expect(f.isDefault, isFalse);
    });
  });
}
