import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/tables/enums.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/utils/slots_parser.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/app_sheet.dart';
import '../../shared/widgets/deco_slots_row.dart';
import '../../shared/widgets/glyph_tile.dart';
import '../../shared/widgets/large_title.dart';
import '../../shared/widgets/section_label.dart';
import '../../shared/widgets/sharpness_gauge.dart';
import '../../shared/widgets/skill_chip.dart';
import '../equipment/armor/repository/armor_repository.dart';
import '../equipment/models/equip_item.dart';
import '../equipment/talismans/repository/talismans_repository.dart';
import '../equipment/weapons/repository/weapons_repository.dart';
import '../equipment/widgets/equipment_detail_sheet.dart';
import '../equipment/widgets/slot_picker_sheet.dart';
import 'build_notifier.dart';

class BuildScreen extends ConsumerWidget {
  const BuildScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final buildAsync = ref.watch(buildNotifierProvider);

    return SafeArea(
      child: buildAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(l10n.initError(e), style: TextStyle(color: tokens.label2)),
        ),
        data: (buildState) {
          if (buildState == null) return const Center(child: CircularProgressIndicator());
          return _BuildContent(buildState: buildState);
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Main content
// ---------------------------------------------------------------------------

class _BuildContent extends ConsumerWidget {
  const _BuildContent({required this.buildState});
  final BuildState buildState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: LargeTitleBar(title: l10n.navBuild, subtitle: buildState.build.name),
        ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Weapon hero
              _WeaponHero(buildState: buildState),
              const SizedBox(height: 28),

              // Armor slots + charm
              SectionLabel(text: l10n.sectionArmor),
              AppCard(
                padding: 0,
                child: Column(
                  children: [
                    for (final slot in ArmorSlotType.values)
                      _ArmorSlotRow(slot: slot, buildState: buildState),
                    const Divider(height: 0),
                    _CharmSlotRow(buildState: buildState),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Active skills
              SectionLabel(text: l10n.buildActiveSkills),
              if (buildState.skills.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    l10n.buildNoSkills,
                    style: TextStyle(fontSize: 14, color: tokens.label2),
                  ),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: buildState.skills.map((entry) {
                    final color = AppColors.skillCategory(
                      entry.skill.type2,
                      Theme.of(context).brightness,
                    );
                    return SkillChip(
                      name: entry.skill.name,
                      level: entry.level,
                      max: entry.skill.maxLevel,
                      color: color,
                    );
                  }).toList(),
                ),
              const SizedBox(height: 28),

              // Quick summary
              SectionLabel(text: l10n.buildSummary),
              _QuickSummary(buildState: buildState),
            ]),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Weapon hero card
// ---------------------------------------------------------------------------

class _WeaponHero extends ConsumerWidget {
  const _WeaponHero({required this.buildState});
  final BuildState buildState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;
    final weapon = buildState.weapon;

    if (weapon == null) {
      return GestureDetector(
        onTap: () => _openWeaponPicker(context, ref),
        child: AppCard(
          child: Row(
            spacing: 12,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: tokens.fill,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: tokens.sep,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Icon(Icons.add_rounded, color: tokens.label3),
              ),
              Expanded(
                child: Text(
                  l10n.buildNoWeapon,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: tokens.label2,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final slots = parseSlots(weapon.slots);

    return GestureDetector(
      onTap: () => showAppSheet(
        context: context,
        child: EquipmentDetailSheet(item: WeaponEquipItem(weapon)),
      ),
      child: AppCard(
        padding: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14,
            children: [
              // Header
              Row(
                spacing: 12,
                children: [
                  GlyphTile(kind: 'weapon', size: 44),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weapon.name,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                            color: tokens.label,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          spacing: 6,
                          children: [
                            Text(
                              _weaponTypeLabel(weapon.weaponType, l10n),
                              style: TextStyle(fontSize: 13, color: tokens.label2),
                            ),
                            if (slots.isNotEmpty) DecoSlotsRow(slots: slots),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: tokens.label3),
                ],
              ),

              // Stats grid
              Row(
                children: [
                  _StatPill(
                    label: l10n.statAttack,
                    value: weapon.baseAttack.toString(),
                    color: AppColors.negativeRed,
                  ),
                  _StatPill(
                    label: l10n.statAffinity,
                    value: '${weapon.baseAffinity > 0 ? '+' : ''}${weapon.baseAffinity.toStringAsFixed(0)}%',
                    color: const Color(0xFFFF9F0A),
                  ),
                  if (weapon.elementType != null && weapon.elementValue != null)
                    _StatPill(
                      label: _elementLabel(weapon.elementType!, l10n),
                      value: weapon.elementValue.toString(),
                      color: AppColors.element(weapon.elementType!, brightness),
                    ),
                ],
              ),

              // Sharpness
              SharpnessGauge(sharpnessMax: weapon.sharpnessMax),
            ],
          ),
        ),
      ),
    );
  }

  void _openWeaponPicker(BuildContext context, WidgetRef ref) {
    final stream = ref.read(weaponsRepositoryProvider).watchAll()
        .map((ws) => ws.map((w) => WeaponEquipItem(w) as EquipItem).toList());
    showAppSheet(
      context: context,
      child: SlotPickerSheet(
        title: AppLocalizations.of(context).slotPickerSelectWeapon,
        itemsStream: stream,
        currentId: buildState.weapon?.id,
        onSelected: (item) {
          if (item is WeaponEquipItem) {
            ref.read(buildNotifierProvider.notifier).equipWeapon(item.weapon.id);
          }
        },
        onClear: buildState.weapon != null
            ? () => ref.read(buildNotifierProvider.notifier).equipWeapon(null)
            : null,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Armor slot row
// ---------------------------------------------------------------------------

class _ArmorSlotRow extends ConsumerWidget {
  const _ArmorSlotRow({required this.slot, required this.buildState});
  final ArmorSlotType slot;
  final BuildState buildState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final piece = buildState.pieceForSlot(slot);
    final isLast = slot == ArmorSlotType.legs;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: piece != null
          ? () => showAppSheet(
                context: context,
                child: EquipmentDetailSheet(item: ArmorEquipItem(piece)),
              )
          : () => _openArmorPicker(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: tokens.sep, width: 0.5)),
        ),
        child: Row(
          spacing: 12,
          children: [
            GlyphTile(kind: slot.name, size: 38, borderRadius: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _slotLabel(slot, l10n),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: tokens.label2,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    piece?.name ?? l10n.buildSlotEmpty,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                      color: piece != null ? tokens.label : tokens.label2,
                    ),
                  ),
                  if (piece != null) ...[
                    const SizedBox(height: 2),
                    Row(
                      spacing: 6,
                      children: [
                        Text(
                          'DEF ${piece.baseDefense}',
                          style: TextStyle(fontSize: 12, color: tokens.label2),
                        ),
                        DecoSlotsRow(slots: parseSlots(piece.slots), size: 12),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 18, color: tokens.label3),
          ],
        ),
      ),
    );
  }

  void _openArmorPicker(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stream = ref.read(armorRepositoryProvider).watchBySlot(slot)
        .map((ps) => ps.map((p) => ArmorEquipItem(p) as EquipItem).toList());
    final slotLabel = _slotLabel(slot, l10n);
    showAppSheet(
      context: context,
      child: SlotPickerSheet(
        title: l10n.slotPickerSelectArmor(slotLabel),
        itemsStream: stream,
        currentId: buildState.pieceForSlot(slot)?.id,
        onSelected: (item) {
          if (item is ArmorEquipItem) {
            ref.read(buildNotifierProvider.notifier).equipArmor(slot, item.piece.id);
          }
        },
        onClear: buildState.pieceForSlot(slot) != null
            ? () => ref.read(buildNotifierProvider.notifier).equipArmor(slot, null)
            : null,
      ),
    );
  }

  String _slotLabel(ArmorSlotType s, AppLocalizations l10n) => switch (s) {
        ArmorSlotType.head  => l10n.armorSlotHead,
        ArmorSlotType.chest => l10n.armorSlotChest,
        ArmorSlotType.arms  => l10n.armorSlotArms,
        ArmorSlotType.waist => l10n.armorSlotWaist,
        ArmorSlotType.legs  => l10n.armorSlotLegs,
      };
}

// ---------------------------------------------------------------------------
// Charm slot row
// ---------------------------------------------------------------------------

class _CharmSlotRow extends ConsumerWidget {
  const _CharmSlotRow({required this.buildState});
  final BuildState buildState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final talisman = buildState.talisman;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: talisman != null
          ? () => showAppSheet(
                context: context,
                child: EquipmentDetailSheet(item: CharmEquipItem(talisman)),
              )
          : () => _openCharmPicker(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          spacing: 12,
          children: [
            GlyphTile(kind: 'charm', size: 38, borderRadius: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.equipCharm,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: tokens.label2,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    talisman?.name ?? l10n.buildSlotEmpty,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                      color: talisman != null ? tokens.label : tokens.label2,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 18, color: tokens.label3),
          ],
        ),
      ),
    );
  }

  void _openCharmPicker(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stream = ref.read(talismansRepositoryProvider).watchAll()
        .map((ts) => ts.map((t) => CharmEquipItem(t) as EquipItem).toList());
    showAppSheet(
      context: context,
      child: SlotPickerSheet(
        title: l10n.slotPickerSelectCharm,
        itemsStream: stream,
        currentId: buildState.talisman?.id,
        onSelected: (item) {
          if (item is CharmEquipItem) {
            ref.read(buildNotifierProvider.notifier).equipCharm(item.talisman.id);
          }
        },
        onClear: buildState.talisman != null
            ? () => ref.read(buildNotifierProvider.notifier).equipCharm(null)
            : null,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick summary 2×2 grid
// ---------------------------------------------------------------------------

class _QuickSummary extends StatelessWidget {
  const _QuickSummary({required this.buildState});
  final BuildState buildState;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;
    final weapon = buildState.weapon;

    final atkValue = weapon?.baseAttack.toString() ?? '—';
    final defValue = buildState.totalDefense > 0
        ? buildState.totalDefense.toString()
        : '—';
    final affValue = weapon != null
        ? '${weapon.baseAffinity >= 0 ? '+' : ''}${weapon.baseAffinity.toStringAsFixed(0)}%'
        : '—';
    final elemValue = (weapon?.elementType != null && weapon?.elementValue != null)
        ? weapon!.elementValue.toString()
        : '—';
    final elemColor = weapon?.elementType != null
        ? AppColors.element(weapon!.elementType!, brightness)
        : tokens.label2;

    return AppCard(
      child: Row(
        children: [
          _SummaryCell(label: l10n.statAttack,   value: atkValue,  color: AppColors.negativeRed),
          _SummaryDivider(),
          _SummaryCell(label: l10n.statDefense,  value: defValue,  color: tokens.accent),
          _SummaryDivider(),
          _SummaryCell(label: l10n.statAffinity, value: affValue,  color: const Color(0xFFFF9F0A)),
          _SummaryDivider(),
          _SummaryCell(label: l10n.statElement,  value: elemValue, color: elemColor),
        ],
      ),
    );
  }
}

class _SummaryCell extends StatelessWidget {
  const _SummaryCell({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: tokens.label2,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Container(width: 0.5, height: 36, color: tokens.sep);
  }
}

// ---------------------------------------------------------------------------
// Small stat pill (weapon hero row)
// ---------------------------------------------------------------------------

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              color: tokens.label2,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Label helpers
// ---------------------------------------------------------------------------

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
