import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/tables/enums.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/label_helpers.dart';
import '../../../shared/widgets/section_label.dart';
import '../equipment_screen.dart';
import '../models/equipment_filter.dart';

class EquipmentFilterSheet extends ConsumerStatefulWidget {
  const EquipmentFilterSheet({super.key, required this.category});
  final EquipmentCategory category;

  @override
  ConsumerState<EquipmentFilterSheet> createState() =>
      _EquipmentFilterSheetState();
}

class _EquipmentFilterSheetState
    extends ConsumerState<EquipmentFilterSheet> {
  late EquipmentFilters _draft;

  @override
  void initState() {
    super.initState();
    _draft = ref.read(equipmentFiltersProvider);
  }

  void _apply() {
    ref.read(equipmentFiltersProvider.notifier).apply(_draft);
    Navigator.of(context).pop();
  }

  void _reset() => setState(() => _draft = const EquipmentFilters());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final isWeapons = widget.category == EquipmentCategory.weapons;
    final isArmor = widget.category == EquipmentCategory.armor;

    final sortOptions = <(EquipSortBy, String)>[
      (EquipSortBy.name, l10n.sortByName),
      if (isWeapons) (EquipSortBy.attack, l10n.sortByAttack),
      if (isArmor) (EquipSortBy.defense, l10n.sortByDefense),
      (EquipSortBy.rarity, l10n.sortByRarity),
      if (!isWeapons && !isArmor) (EquipSortBy.newest, l10n.sortByNewest),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _reset,
                child: Text(
                  l10n.filterReset,
                  style: TextStyle(fontSize: 17, color: tokens.label2),
                ),
              ),
              Text(
                l10n.filterTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: tokens.label,
                ),
              ),
              GestureDetector(
                onTap: _apply,
                child: Text(
                  l10n.filterApply,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: tokens.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          SectionLabel(text: l10n.filterSortBy),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sortOptions.map((opt) {
              final (value, label) = opt;
              return _Chip(
                label: label,
                selected: _draft.sortBy == value,
                onTap: () =>
                    setState(() => _draft = _draft.copyWith(sortBy: value)),
              );
            }).toList(),
          ),

          if (isWeapons) ...[
            const SizedBox(height: 20),
            SectionLabel(text: l10n.filterWeaponType),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WeaponType.values.map((type) {
                final selected = _draft.weaponTypes.contains(type);
                return _Chip(
                  label: weaponTypeLabel(type, l10n),
                  selected: selected,
                  onTap: () {
                    final next = Set<WeaponType>.from(_draft.weaponTypes);
                    selected ? next.remove(type) : next.add(type);
                    setState(
                        () => _draft = _draft.copyWith(weaponTypes: next));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SectionLabel(text: l10n.filterElement),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip(
                  label: l10n.filterAny,
                  selected: _draft.elements.isEmpty && _draft.includeNoElement,
                  onTap: () => setState(() => _draft = _draft.copyWith(
                        elements: const {},
                        includeNoElement: true,
                      )),
                ),
                _Chip(
                  label: l10n.filterNoElement,
                  selected: _draft.elements.isEmpty && !_draft.includeNoElement,
                  onTap: () => setState(() => _draft = _draft.copyWith(
                        elements: const {},
                        includeNoElement: false,
                      )),
                ),
                for (final elem in _weaponElements)
                  _Chip(
                    label: _elemLabel(elem, l10n),
                    selected: _draft.elements.contains(elem),
                    onTap: () {
                      final next = Set<ElementType>.from(_draft.elements);
                      _draft.elements.contains(elem)
                          ? next.remove(elem)
                          : next.add(elem);
                      setState(() => _draft = _draft.copyWith(
                            elements: next,
                            includeNoElement: next.isNotEmpty
                                ? _draft.includeNoElement
                                : true,
                          ));
                    },
                  ),
              ],
            ),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Chip widget
// ---------------------------------------------------------------------------

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? tokens.accent.withValues(alpha: isDark ? 0.22 : 0.12)
              : tokens.fill,
          border: Border.all(
            color: selected ? tokens.accent : Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: selected ? tokens.accent : tokens.label,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const _weaponElements = [
  ElementType.fire,
  ElementType.water,
  ElementType.thunder,
  ElementType.ice,
  ElementType.dragon,
  ElementType.poison,
  ElementType.sleep,
  ElementType.paralysis,
  ElementType.blast,
];

String _elemLabel(ElementType elem, AppLocalizations l10n) => switch (elem) {
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
