import '../../../core/database/database.dart';

/// Sealed union representing one of the three equipment categories that can
/// appear in the Equipment browser and detail sheet.
sealed class EquipItem {
  const EquipItem();

  String get name;
  int get rarity;
}

final class WeaponEquipItem extends EquipItem {
  const WeaponEquipItem(this.weapon);
  final Weapon weapon;

  @override
  String get name => weapon.name;
  @override
  int get rarity => weapon.rarity;
}

final class ArmorEquipItem extends EquipItem {
  const ArmorEquipItem(this.piece);
  final ArmorPiece piece;

  @override
  String get name => piece.name;
  @override
  int get rarity => piece.rarity;
}

final class CharmEquipItem extends EquipItem {
  const CharmEquipItem(this.talisman);
  final Talisman talisman;

  @override
  String get name => talisman.name;
  @override
  int get rarity => 1;
}
