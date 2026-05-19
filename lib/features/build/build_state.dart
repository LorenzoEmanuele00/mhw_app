import 'package:flutter/foundation.dart';
import '../../core/database/database.dart';
import '../../core/database/tables/enums.dart';
import '../../shared/calc/build_stats.dart';

@immutable
class BuildState {
  const BuildState({
    required this.build,
    this.weapon,
    this.head,
    this.chest,
    this.arms,
    this.waist,
    this.legs,
    this.talisman,
    this.jewels = const [],
    this.skills = const [],
    this.stats = BuildStats.empty,
  });

  final Build build;
  final Weapon? weapon;
  final ArmorPiece? head;
  final ArmorPiece? chest;
  final ArmorPiece? arms;
  final ArmorPiece? waist;
  final ArmorPiece? legs;
  final Talisman? talisman;
  final List<BuildJewel> jewels;
  final List<({Skill skill, int level})> skills;
  final BuildStats stats;

  ArmorPiece? pieceForSlot(ArmorSlotType slot) => switch (slot) {
        ArmorSlotType.head => head,
        ArmorSlotType.chest => chest,
        ArmorSlotType.arms => arms,
        ArmorSlotType.waist => waist,
        ArmorSlotType.legs => legs,
      };

  int? jewelIdForSlot(JewelSlotSource source, int slotIndex) {
    try {
      return jewels
          .firstWhere((j) => j.slotSource == source && j.slotIndex == slotIndex)
          .jewelId;
    } catch (_) {
      return null;
    }
  }

  int get totalDefense =>
      (head?.baseDefense ?? 0) +
      (chest?.baseDefense ?? 0) +
      (arms?.baseDefense ?? 0) +
      (waist?.baseDefense ?? 0) +
      (legs?.baseDefense ?? 0);
}
