import 'package:flutter/material.dart';
import '../../../core/database/tables/enums.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/slots_parser.dart';
import '../../../shared/widgets/deco_slots_row.dart';
import '../../../shared/widgets/glyph_tile.dart';
import '../models/equip_item.dart';

/// A list row that can display a weapon, armor piece, or charm.
/// Shows a GlyphTile, name, primary stat, type label, element, deco slots,
/// an optional "Equipped" badge, and a chevron.
class EquipmentRow extends StatelessWidget {
  const EquipmentRow({
    super.key,
    required this.item,
    required this.onTap,
    this.isEquipped = false,
    this.isLast = false,
  });

  final EquipItem item;
  final VoidCallback onTap;
  final bool isEquipped;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;

    final kind = _kind(item);
    final mainStat = _mainStat(item, l10n);
    final elementInfo = _elementInfo(item, brightness);
    final slots = _slots(item);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: tokens.sep, width: 0.5)),
        ),
        child: Row(
          spacing: 12,
          children: [
            GlyphTile(kind: kind, size: 44, borderRadius: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: tokens.label,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ),
                      if (isEquipped) _EquippedBadge(),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        mainStat,
                        style: TextStyle(fontSize: 13, color: tokens.label2),
                      ),
                      if (elementInfo != null) ...[
                        Text('·', style: TextStyle(color: tokens.label2, fontSize: 13)),
                        Text(
                          elementInfo.label,
                          style: TextStyle(
                            fontSize: 13,
                            color: elementInfo.color,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            DecoSlotsRow(slots: slots, size: 13),
            Icon(Icons.chevron_right, color: tokens.label3, size: 18),
          ],
        ),
      ),
    );
  }

  String _kind(EquipItem item) => switch (item) {
        WeaponEquipItem() => 'weapon',
        ArmorEquipItem(:final piece) => piece.slotType.name,
        CharmEquipItem() => 'charm',
      };

  String _mainStat(EquipItem item, AppLocalizations l10n) => switch (item) {
        WeaponEquipItem(:final weapon) => weapon.baseAffinity != 0
            ? '${weapon.baseAttack} ${l10n.statAttack} · '
                '${weapon.baseAffinity > 0 ? '+' : ''}${weapon.baseAffinity.toStringAsFixed(0)}%'
            : '${weapon.baseAttack} ${l10n.statAttack}',
        ArmorEquipItem(:final piece) =>
          '${piece.baseDefense} ${l10n.statDefense}',
        CharmEquipItem() => '${l10n.statRarity} ${item.rarity}',
      };

  ({String label, Color color})? _elementInfo(EquipItem item, Brightness b) {
    if (item is! WeaponEquipItem) return null;
    final w = item.weapon;
    if (w.elementType == null || w.elementValue == null) return null;
    return (
      label: w.elementType!.name.capitalize(),
      color: AppColors.element(w.elementType!, b),
    );
  }

  List<int> _slots(EquipItem item) => switch (item) {
        WeaponEquipItem(:final weapon) => parseSlots(weapon.slots),
        ArmorEquipItem(:final piece) => parseSlots(piece.slots),
        CharmEquipItem(:final talisman) => parseSlots(talisman.slots),
      };
}

String weaponTypeName(WeaponType type, AppLocalizations l10n) => switch (type) {
      WeaponType.gs  => l10n.weaponTypeGs,
      WeaponType.ls  => l10n.weaponTypeLs,
      WeaponType.sns => l10n.weaponTypeSns,
      WeaponType.db  => l10n.weaponTypeDb,
      WeaponType.hmr => l10n.weaponTypeHmr,
      WeaponType.hh  => l10n.weaponTypeHh,
      WeaponType.lan => l10n.weaponTypeLan,
      WeaponType.gl  => l10n.weaponTypeGl,
      WeaponType.sa  => l10n.weaponTypeSa,
      WeaponType.cb  => l10n.weaponTypeCb,
      WeaponType.ig  => l10n.weaponTypeIg,
      WeaponType.lbg => l10n.weaponTypeLbg,
      WeaponType.hbg => l10n.weaponTypeHbg,
      WeaponType.bow => l10n.weaponTypeBow,
    };

class _EquippedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = tokens.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: isDark ? 0.14 : 0.10),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        'Equipped',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: accent,
        ),
      ),
    );
  }
}

extension on String {
  String capitalize() =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);
}
