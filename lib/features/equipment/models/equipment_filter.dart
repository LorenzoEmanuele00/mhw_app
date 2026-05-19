import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/tables/enums.dart';

enum EquipSortBy { name, attack, defense, rarity, newest }

@immutable
class EquipmentFilters {
  const EquipmentFilters({
    this.weaponTypes = const {},
    this.elements = const {},
    this.includeNoElement = true,
    this.rarityMin = 1,
    this.sortBy = EquipSortBy.name,
  });

  final Set<WeaponType> weaponTypes;
  final Set<ElementType> elements;
  final bool includeNoElement;
  final int rarityMin;
  final EquipSortBy sortBy;

  bool get isDefault =>
      weaponTypes.isEmpty &&
      elements.isEmpty &&
      includeNoElement &&
      rarityMin == 1 &&
      sortBy == EquipSortBy.name;

  int get activeFilterCount {
    int n = 0;
    if (weaponTypes.isNotEmpty) n++;
    if (elements.isNotEmpty || !includeNoElement) n++;
    if (rarityMin > 1) n++;
    if (sortBy != EquipSortBy.name) n++;
    return n;
  }

  EquipmentFilters copyWith({
    Set<WeaponType>? weaponTypes,
    Set<ElementType>? elements,
    bool? includeNoElement,
    int? rarityMin,
    EquipSortBy? sortBy,
  }) =>
      EquipmentFilters(
        weaponTypes: weaponTypes ?? this.weaponTypes,
        elements: elements ?? this.elements,
        includeNoElement: includeNoElement ?? this.includeNoElement,
        rarityMin: rarityMin ?? this.rarityMin,
        sortBy: sortBy ?? this.sortBy,
      );
}

class EquipmentFiltersNotifier extends Notifier<EquipmentFilters> {
  @override
  EquipmentFilters build() => const EquipmentFilters();

  void apply(EquipmentFilters filters) => state = filters;
  void reset() => state = const EquipmentFilters();
}

final equipmentFiltersProvider =
    NotifierProvider<EquipmentFiltersNotifier, EquipmentFilters>(
  EquipmentFiltersNotifier.new,
);
