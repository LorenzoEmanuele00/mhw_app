import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/database/tables/enums.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/app_sheet.dart';
import '../../shared/widgets/large_title.dart';
import '../../shared/widgets/search_field.dart';
import '../../shared/widgets/section_label.dart';
import '../../shared/widgets/segmented_control.dart';
import 'armor/armor_repository.dart';
import 'models/equipment_filter.dart';
import 'talismans/talismans_repository.dart';
import 'weapons/weapons_repository.dart';
import 'models/equip_item.dart';
import 'widgets/equipment_detail_sheet.dart';
import 'widgets/equipment_filter_sheet.dart';
import 'widgets/equipment_row.dart';
import 'widgets/talisman_editor_sheet.dart';

enum EquipmentCategory { weapons, armor, charm }

class EquipmentCategoryNotifier extends Notifier<EquipmentCategory> {
  @override
  EquipmentCategory build() => EquipmentCategory.weapons;

  /// Set the active category. Call this before navigating to /equipment to pre-select a tab.
  void set(EquipmentCategory category) => state = category;
}

final equipmentCategoryProvider =
    NotifierProvider<EquipmentCategoryNotifier, EquipmentCategory>(
  EquipmentCategoryNotifier.new,
);

/// Equipment tab: browse weapons, armor, and charms with search and grouping.
class EquipmentScreen extends ConsumerStatefulWidget {
  const EquipmentScreen({super.key});

  @override
  ConsumerState<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends ConsumerState<EquipmentScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _switchCategory(EquipmentCategory cat) {
    if (cat == ref.read(equipmentCategoryProvider)) return;
    setState(() {
      _query = '';
      _searchCtrl.clear();
    });
    ref.read(equipmentCategoryProvider.notifier).set(cat);
  }

  void _openFilterSheet(BuildContext context, EquipmentCategory category) {
    showAppSheet(
      context: context,
      child: EquipmentFilterSheet(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(equipmentCategoryProvider);
    final filters = ref.watch(equipmentFiltersProvider);

    // Reset search when the category is changed from outside (e.g. from Build tab)
    ref.listen<EquipmentCategory>(equipmentCategoryProvider, (prev, next) {
      if (prev != next) setState(() { _query = ''; _searchCtrl.clear(); });
    });

    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final weapons = ref.watch(allWeaponsProvider);
    final armor = ref.watch(allArmorProvider);
    final charms = ref.watch(allTalismansProvider);
    final filterCount = filters.activeFilterCount;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LargeTitleBar(
            title: l10n.navEquipment,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                if (category == EquipmentCategory.charm)
                  HeaderAction(
                    label: '+ ${l10n.charmNew}',
                    isPrimary: true,
                    onTap: () => showAppSheet(
                      context: context,
                      child: const TalismanEditorSheet(),
                    ),
                  ),
                GestureDetector(
                  onTap: () => _openFilterSheet(context, category),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      Text(
                        l10n.filterButton,
                        style: TextStyle(
                          fontSize: 17,
                          color: tokens.accent,
                        ),
                      ),
                      if (filterCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: tokens.accent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$filterCount',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          AppSearchField(
            controller: _searchCtrl,
            placeholder: l10n.searchEquipment,
            onChanged: (q) => setState(() => _query = q),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
            child: AppSegmentedControl<EquipmentCategory>(
              options: [
                (value: EquipmentCategory.weapons, label: l10n.equipWeapons),
                (value: EquipmentCategory.armor,   label: l10n.equipArmor),
                (value: EquipmentCategory.charm,   label: l10n.equipCharm),
              ],
              selected: category,
              onChanged: _switchCategory,
            ),
          ),

          Expanded(
            child: switch (category) {
              EquipmentCategory.weapons => _buildWeaponsList(context, weapons.asData?.value ?? [], filters, l10n, tokens),
              EquipmentCategory.armor   => _buildArmorList(context, armor.asData?.value ?? [], filters, l10n, tokens),
              EquipmentCategory.charm   => _buildCharmList(context, charms.asData?.value ?? [], filters, l10n, tokens),
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Weapons list — grouped by weapon type
  // ---------------------------------------------------------------------------

  Widget _buildWeaponsList(
    BuildContext context,
    List<Weapon> weapons,
    EquipmentFilters filters,
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    // Which types to show
    final typeOrder = filters.weaponTypes.isEmpty
        ? WeaponType.values.toList()
        : WeaponType.values
            .where((t) => filters.weaponTypes.contains(t))
            .toList();

    final hasAny = typeOrder.any((type) =>
        _filterWeapons(weapons, type, _query, filters).isNotEmpty);

    if (!hasAny && (_query.isNotEmpty || !filters.isDefault)) {
      return _EmptySearch(query: _query, l10n: l10n, tokens: tokens);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        for (final type in typeOrder)
          ..._buildWeaponGroup(context, weapons, type, filters, l10n, tokens),
      ],
    );
  }

  List<Weapon> _filterWeapons(
    List<Weapon> all,
    WeaponType type,
    String query,
    EquipmentFilters filters,
  ) {
    var list = all.where((w) => w.weaponType == type).toList();
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((w) => w.name.toLowerCase().contains(q)).toList();
    }
    if (filters.rarityMin > 1) {
      list = list.where((w) => w.rarity >= filters.rarityMin).toList();
    }
    // Element filter
    final anyElemFilter =
        filters.elements.isNotEmpty || !filters.includeNoElement;
    if (anyElemFilter) {
      list = list.where((w) {
        if (w.elementType == null) return filters.includeNoElement;
        return filters.elements.isEmpty ||
            filters.elements.contains(w.elementType);
      }).toList();
    }
    // Sort
    _sortWeapons(list, filters.sortBy);
    return list;
  }

  void _sortWeapons(List<Weapon> list, EquipSortBy sortBy) {
    switch (sortBy) {
      case EquipSortBy.name:
        list.sort((a, b) => a.name.compareTo(b.name));
      case EquipSortBy.attack:
        list.sort((a, b) => b.baseAttack.compareTo(a.baseAttack));
      case EquipSortBy.rarity:
        list.sort((a, b) => b.rarity.compareTo(a.rarity));
      default:
        list.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  List<Widget> _buildWeaponGroup(
    BuildContext context,
    List<Weapon> allWeapons,
    WeaponType type,
    EquipmentFilters filters,
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    final filtered = _filterWeapons(allWeapons, type, _query, filters);
    if (filtered.isEmpty) return [];

    return [
      SectionLabel(text: weaponTypeName(type, l10n)),
      AppCard(
        padding: 0,
        child: Column(
          children: filtered.asMap().entries.map((e) {
            final idx = e.key;
            final w = e.value;
            return EquipmentRow(
              item: WeaponEquipItem(w),
              isLast: idx == filtered.length - 1,
              onTap: () => _openDetail(context, WeaponEquipItem(w)),
            );
          }).toList(),
        ),
      ),
      const SizedBox(height: 20),
    ];
  }

  // ---------------------------------------------------------------------------
  // Armor list — grouped by slot type
  // ---------------------------------------------------------------------------

  Widget _buildArmorList(
    BuildContext context,
    List<ArmorPiece> allPieces,
    EquipmentFilters filters,
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    const slotOrder = [
      ArmorSlotType.head,
      ArmorSlotType.chest,
      ArmorSlotType.arms,
      ArmorSlotType.waist,
      ArmorSlotType.legs,
    ];

    final hasAny = slotOrder.any((slot) =>
        _filterArmor(allPieces, slot, _query, filters).isNotEmpty);

    if (!hasAny && (_query.isNotEmpty || !filters.isDefault)) {
      return _EmptySearch(query: _query, l10n: l10n, tokens: tokens);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        for (final slot in slotOrder)
          ..._buildArmorGroup(context, allPieces, slot, filters, l10n, tokens),
      ],
    );
  }

  List<ArmorPiece> _filterArmor(
    List<ArmorPiece> all,
    ArmorSlotType slot,
    String query,
    EquipmentFilters filters,
  ) {
    var list = all.where((p) => p.slotType == slot).toList();
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((p) => p.name.toLowerCase().contains(q)).toList();
    }
    if (filters.rarityMin > 1) {
      list = list.where((p) => p.rarity >= filters.rarityMin).toList();
    }
    _sortArmor(list, filters.sortBy);
    return list;
  }

  void _sortArmor(List<ArmorPiece> list, EquipSortBy sortBy) {
    switch (sortBy) {
      case EquipSortBy.name:
        list.sort((a, b) => a.name.compareTo(b.name));
      case EquipSortBy.defense:
        list.sort((a, b) => b.baseDefense.compareTo(a.baseDefense));
      case EquipSortBy.rarity:
        list.sort((a, b) => b.rarity.compareTo(a.rarity));
      default:
        list.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  List<Widget> _buildArmorGroup(
    BuildContext context,
    List<ArmorPiece> allPieces,
    ArmorSlotType slot,
    EquipmentFilters filters,
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    final filtered = _filterArmor(allPieces, slot, _query, filters);
    if (filtered.isEmpty) return [];

    final groupLabel = switch (slot) {
      ArmorSlotType.head  => l10n.armorSlotHead,
      ArmorSlotType.chest => l10n.armorSlotChest,
      ArmorSlotType.arms  => l10n.armorSlotArms,
      ArmorSlotType.waist => l10n.armorSlotWaist,
      ArmorSlotType.legs  => l10n.armorSlotLegs,
    };

    return [
      SectionLabel(text: groupLabel),
      AppCard(
        padding: 0,
        child: Column(
          children: filtered.asMap().entries.map((e) {
            final idx = e.key;
            final piece = e.value;
            return EquipmentRow(
              item: ArmorEquipItem(piece),
              isLast: idx == filtered.length - 1,
              onTap: () => _openDetail(context, ArmorEquipItem(piece)),
            );
          }).toList(),
        ),
      ),
      const SizedBox(height: 20),
    ];
  }

  // ---------------------------------------------------------------------------
  // Charm list
  // ---------------------------------------------------------------------------

  Widget _buildCharmList(
    BuildContext context,
    List<Talisman> talismans,
    EquipmentFilters filters,
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    var list = talismans.toList();
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((t) => t.name.toLowerCase().contains(q)).toList();
    }
    if (filters.sortBy == EquipSortBy.newest) {
      // Keep DB order (already newest-first from DAO)
    } else {
      list.sort((a, b) => a.name.compareTo(b.name));
    }

    if (list.isEmpty) {
      return _EmptySearch(query: _query, l10n: l10n, tokens: tokens);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        AppCard(
          padding: 0,
          child: Column(
            children: list.asMap().entries.map((e) {
              final idx = e.key;
              final t = e.value;
              return EquipmentRow(
                item: CharmEquipItem(t),
                isLast: idx == list.length - 1,
                onTap: () => _openDetail(context, CharmEquipItem(t)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _openDetail(BuildContext context, EquipItem item) {
    showAppSheet(context: context, child: EquipmentDetailSheet(item: item));
  }
}

// ---------------------------------------------------------------------------
// Shared list wrapper
// ---------------------------------------------------------------------------

class _EmptySearch extends StatelessWidget {
  const _EmptySearch({
    required this.query,
    required this.l10n,
    required this.tokens,
  });
  final String query;
  final AppLocalizations l10n;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          query.isEmpty
              ? l10n.buildNoSkills  // reuse "no items" message
              : l10n.searchNoResults(query),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: tokens.label2),
        ),
      ),
    );
  }
}
