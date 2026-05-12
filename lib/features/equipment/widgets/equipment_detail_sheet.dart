import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database.dart';
import '../../../core/database/tables/enums.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/slots_parser.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_sheet.dart';
import '../../../shared/widgets/deco_slots_row.dart';
import '../../../shared/widgets/glyph_tile.dart';
import '../../../shared/widgets/section_label.dart';
import '../../../shared/widgets/sharpness_gauge.dart';
import '../../../shared/widgets/skill_chip.dart';
import '../../../shared/widgets/stat_bar.dart';
import '../armor/repository/armor_repository.dart';
import '../models/equip_item.dart';
import '../../build/build_notifier.dart';
import '../../jewels/widgets/jewel_picker_sheet.dart';

/// Full-screen-height content for the equipment detail bottom sheet.
class EquipmentDetailSheet extends ConsumerWidget {
  const EquipmentDetailSheet({super.key, required this.item});

  final EquipItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (item) {
      WeaponEquipItem(:final weapon) => _WeaponDetail(weapon: weapon),
      ArmorEquipItem(:final piece)  => _ArmorDetail(piece: piece),
      CharmEquipItem(:final talisman) => _CharmDetail(talisman: talisman),
    };
  }
}

// ---------------------------------------------------------------------------
// Hero header shared by all item types
// ---------------------------------------------------------------------------

class _DetailHero extends StatelessWidget {
  const _DetailHero({
    required this.kind,
    required this.name,
    required this.typeLabel,
    required this.rarity,
  });

  final String kind;
  final String name;
  final String typeLabel;
  final int rarity;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = tokens.accent;

    return Column(
      children: [
        GlyphTile(kind: kind, size: 104, borderRadius: 26),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Text(
              typeLabel.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: tokens.label2,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: isDark ? 0.14 : 0.10),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'R$rarity',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accent,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: tokens.label,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Weapon detail
// ---------------------------------------------------------------------------

class _WeaponDetail extends ConsumerWidget {
  const _WeaponDetail({required this.weapon});
  final Weapon weapon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;
    final slots = parseSlots(weapon.slots);

    final buildState = ref.watch(buildNotifierProvider).asData?.value;
    final isEquipped = buildState?.weapon?.id == weapon.id;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _DetailHero(
              kind: 'weapon',
              name: weapon.name,
              typeLabel: _weaponTypeLabel(weapon.weaponType, l10n),
              rarity: weapon.rarity,
            ),
          ),

          // Stats
          AppCard(
            child: Column(
              spacing: 14,
              children: [
                StatBar(
                  label: l10n.statAttack,
                  value: weapon.baseAttack,
                  max: 1800,
                  color: AppColors.negativeRed,
                ),
                StatBar(
                  label: l10n.statAffinity,
                  value: weapon.baseAffinity,
                  max: 50,
                  color: const Color(0xFFFF9F0A),
                  signed: true,
                  suffix: '%',
                ),
                if (weapon.elementType != null && weapon.elementValue != null)
                  StatBar(
                    label: _elementLabel(weapon.elementType!, l10n),
                    value: weapon.elementValue!,
                    max: 600,
                    color: AppColors.element(weapon.elementType!, brightness),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 6,
                  children: [
                    Text(
                      l10n.statSharpness.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: tokens.label2,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SharpnessGauge(sharpnessMax: weapon.sharpnessMax),
                  ],
                ),
              ],
            ),
          ),

          // Interactive decoration slots
          if (slots.isNotEmpty)
            _DecoSlotsCard(
              slots: slots,
              slotSource: JewelSlotSource.weapon,
              buildState: buildState,
            ),

          // Equip CTA
          _EquipButton(
            label: isEquipped ? l10n.equipped : l10n.equipTo,
            isEquipped: isEquipped,
            onTap: isEquipped
                ? null
                : () {
                    ref.read(buildNotifierProvider.notifier).equipWeapon(weapon.id);
                    Navigator.of(context).pop();
                  },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Armor detail
// ---------------------------------------------------------------------------

class _ArmorDetail extends ConsumerWidget {
  const _ArmorDetail({required this.piece});
  final ArmorPiece piece;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;
    final slots = parseSlots(piece.slots);
    final skillsAsync = ref.watch(armorPieceSkillsProvider(piece.id));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _DetailHero(
              kind: piece.slotType.name,
              name: piece.name,
              typeLabel: _armorSlotLabel(piece.slotType, l10n),
              rarity: piece.rarity,
            ),
          ),

          // Stats
          AppCard(
            child: Column(
              spacing: 14,
              children: [
                StatBar(
                  label: l10n.statDefense,
                  value: piece.baseDefense,
                  max: 250,
                  color: AppTokens.of(context).accent,
                ),
                StatBar(
                  label: l10n.resistFire,
                  value: piece.fireRes,
                  max: 20,
                  color: AppColors.element(ElementType.fire, brightness),
                  signed: true,
                ),
                StatBar(
                  label: l10n.resistWater,
                  value: piece.waterRes,
                  max: 20,
                  color: AppColors.element(ElementType.water, brightness),
                  signed: true,
                ),
                StatBar(
                  label: l10n.resistThunder,
                  value: piece.thunderRes,
                  max: 20,
                  color: AppColors.element(ElementType.thunder, brightness),
                  signed: true,
                ),
                StatBar(
                  label: l10n.resistIce,
                  value: piece.iceRes,
                  max: 20,
                  color: AppColors.element(ElementType.ice, brightness),
                  signed: true,
                ),
                StatBar(
                  label: l10n.resistDragon,
                  value: piece.dragonRes,
                  max: 20,
                  color: AppColors.element(ElementType.dragon, brightness),
                  signed: true,
                ),
              ],
            ),
          ),

          // Skills
          skillsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
            data: (entries) => entries.isEmpty
                ? const SizedBox.shrink()
                : _SkillsCard(entries: entries),
          ),

          // Interactive decoration slots
          if (slots.isNotEmpty)
            _DecoSlotsCard(
              slots: slots,
              slotSource: _armorSlotSource(piece.slotType),
              buildState: ref.watch(buildNotifierProvider).asData?.value,
            ),

          // Equip CTA
          Builder(builder: (context) {
            final buildState = ref.watch(buildNotifierProvider).asData?.value;
            final isEquipped = buildState?.pieceForSlot(piece.slotType)?.id == piece.id;
            return _EquipButton(
              label: isEquipped ? l10n.equipped : l10n.equipTo,
              isEquipped: isEquipped,
              onTap: isEquipped
                  ? null
                  : () {
                      ref.read(buildNotifierProvider.notifier).equipArmor(piece.slotType, piece.id);
                      Navigator.of(context).pop();
                    },
            );
          }),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Charm detail
// ---------------------------------------------------------------------------

class _CharmDetail extends ConsumerWidget {
  const _CharmDetail({required this.talisman});
  final Talisman talisman;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final slots = parseSlots(talisman.slots);

    final buildState = ref.watch(buildNotifierProvider).asData?.value;
    final isEquipped = buildState?.talisman?.id == talisman.id;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _DetailHero(
              kind: 'charm',
              name: talisman.name,
              typeLabel: l10n.equipCharm,
              rarity: 1,
            ),
          ),
          AppCard(
            child: Text(
              l10n.charmSkillsOnly,
              style: TextStyle(fontSize: 14, color: tokens.label2),
            ),
          ),
          if (slots.isNotEmpty)
            _DecoSlotsCard(
              slots: slots,
              slotSource: JewelSlotSource.talisman,
              buildState: buildState,
            ),
          _EquipButton(
            label: isEquipped ? l10n.equipped : l10n.equipTo,
            isEquipped: isEquipped,
            onTap: isEquipped
                ? null
                : () {
                    ref.read(buildNotifierProvider.notifier).equipCharm(talisman.id);
                    Navigator.of(context).pop();
                  },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared sub-widgets
// ---------------------------------------------------------------------------

class _SkillsCard extends StatelessWidget {
  const _SkillsCard({required this.entries});
  final List<({Skill skill, int level})> entries;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabel(text: l10n.sectionSkills),
        AppCard(
          padding: 0,
          child: Column(
            children: entries.asMap().entries.map((e) {
              final idx = e.key;
              final entry = e.value;
              final color = AppColors.skillCategory(entry.skill.type2, brightness);
              return SkillDotRow(
                name: entry.skill.name,
                level: entry.level,
                description: null,
                color: color,
                isLast: idx == entries.length - 1,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _DecoSlotsCard extends ConsumerWidget {
  const _DecoSlotsCard({
    required this.slots,
    required this.slotSource,
    required this.buildState,
  });

  final List<int> slots;
  final JewelSlotSource slotSource;
  final BuildState? buildState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabel(text: l10n.sectionDecoSlots),
        AppCard(
          padding: 0,
          child: Column(
            children: slots.asMap().entries.map((e) {
              final idx = e.key;
              final level = e.value;
              final isLast = idx == slots.length - 1;
              final jewelId = buildState?.jewelIdForSlot(slotSource, idx);
              final isFilled = jewelId != null;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: buildState == null
                    ? null
                    : () => showAppSheet(
                          context: context,
                          child: JewelPickerSheet(
                            slotSource: slotSource,
                            slotIndex: idx,
                            slotLevel: level,
                          ),
                        ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : Border(bottom: BorderSide(color: tokens.sep, width: 0.5)),
                  ),
                  child: Row(
                    spacing: 12,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: tokens.fill,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: DecoSlot(level: level, size: 18, filled: isFilled),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.detailSlot(idx + 1, level),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                                color: tokens.label2,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              isFilled ? '(Jewel #$jewelId)' : 'Empty',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isFilled ? tokens.label : tokens.label2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: tokens.label3,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _EquipButton extends StatelessWidget {
  const _EquipButton({
    required this.label,
    required this.isEquipped,
    required this.onTap,
  });

  final String label;
  final bool isEquipped;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEquipped
              ? tokens.fill
              : tokens.accent,
          foregroundColor: isEquipped
              ? tokens.label2
              : (isDark ? Colors.black : Colors.white),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

JewelSlotSource _armorSlotSource(ArmorSlotType slot) => switch (slot) {
      ArmorSlotType.head  => JewelSlotSource.head,
      ArmorSlotType.chest => JewelSlotSource.chest,
      ArmorSlotType.arms  => JewelSlotSource.arms,
      ArmorSlotType.waist => JewelSlotSource.waist,
      ArmorSlotType.legs  => JewelSlotSource.legs,
    };

String _weaponTypeLabel(WeaponType type, AppLocalizations l10n) => switch (type) {
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

String _armorSlotLabel(ArmorSlotType slot, AppLocalizations l10n) => switch (slot) {
      ArmorSlotType.head  => l10n.armorSlotHead,
      ArmorSlotType.chest => l10n.armorSlotChest,
      ArmorSlotType.arms  => l10n.armorSlotArms,
      ArmorSlotType.waist => l10n.armorSlotWaist,
      ArmorSlotType.legs  => l10n.armorSlotLegs,
    };

String _elementLabel(ElementType type, AppLocalizations l10n) => switch (type) {
      ElementType.fire      => l10n.elemFire,
      ElementType.water     => l10n.elemWater,
      ElementType.thunder   => l10n.elemThunder,
      ElementType.ice       => l10n.elemIce,
      ElementType.dragon    => l10n.elemDragon,
      ElementType.poison    => l10n.elemPoison,
      ElementType.sleep     => l10n.elemSleep,
      ElementType.paralysis => l10n.elemParalysis,
      ElementType.blast     => l10n.elemBlast,
    };
