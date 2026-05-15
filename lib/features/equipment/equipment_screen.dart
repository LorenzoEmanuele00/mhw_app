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
import 'talismans/talismans_repository.dart';
import 'weapons/weapons_repository.dart';
import 'models/equip_item.dart';
import 'widgets/equipment_detail_sheet.dart';
import 'widgets/equipment_row.dart';

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

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(equipmentCategoryProvider);

    // Reset search when the category is changed from outside (e.g. from Build tab)
    ref.listen<EquipmentCategory>(equipmentCategoryProvider, (prev, next) {
      if (prev != next) setState(() { _query = ''; _searchCtrl.clear(); });
    });

    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final weapons = ref.watch(allWeaponsProvider);
    final armor = ref.watch(allArmorProvider);
    final charms = ref.watch(allTalismansProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LargeTitleBar(
            title: l10n.navEquipment,
            trailing: HeaderAction(
              label: l10n.filterButton,
              onTap: () {}, // Phase 6
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
              EquipmentCategory.weapons => _buildWeaponsList(context, weapons.asData?.value ?? [], l10n, tokens),
              EquipmentCategory.armor   => _buildArmorList(context, armor.asData?.value ?? [], l10n, tokens),
              EquipmentCategory.charm   => _buildCharmList(context, charms.asData?.value ?? [], l10n, tokens),
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
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    const typeOrder = WeaponType.values;

    final hasAny = typeOrder.any((type) => weapons.any(
          (w) =>
              w.weaponType == type &&
              (_query.isEmpty ||
                  w.name.toLowerCase().contains(_query.toLowerCase())),
        ));

    if (!hasAny && _query.isNotEmpty) {
      return _EmptySearch(query: _query, l10n: l10n, tokens: tokens);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        for (final type in typeOrder)
          ..._buildWeaponGroup(context, weapons, type, l10n, tokens),
      ],
    );
  }

  List<Widget> _buildWeaponGroup(
    BuildContext context,
    List<Weapon> allWeapons,
    WeaponType type,
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    final filtered = allWeapons
        .where((w) =>
            w.weaponType == type &&
            (_query.isEmpty ||
                w.name.toLowerCase().contains(_query.toLowerCase())))
        .toList();

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

    final hasAny = slotOrder.any((slot) {
      final pieces = allPieces
          .where((p) =>
              p.slotType == slot &&
              (_query.isEmpty || p.name.toLowerCase().contains(_query.toLowerCase())))
          .toList();
      return pieces.isNotEmpty;
    });

    if (!hasAny && _query.isNotEmpty) {
      return _EmptySearch(query: _query, l10n: l10n, tokens: tokens);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        for (final slot in slotOrder) ..._buildArmorGroup(context, allPieces, slot, l10n, tokens),
      ],
    );
  }

  List<Widget> _buildArmorGroup(
    BuildContext context,
    List<ArmorPiece> allPieces,
    ArmorSlotType slot,
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    final filtered = allPieces
        .where((p) =>
            p.slotType == slot &&
            (_query.isEmpty || p.name.toLowerCase().contains(_query.toLowerCase())))
        .toList();

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
    AppLocalizations l10n,
    AppTokens tokens,
  ) {
    final filtered = _filterItems(talismans, (t) => t.name);
    return _ItemList(
      isEmpty: filtered.isEmpty,
      query: _query,
      l10n: l10n,
      tokens: tokens,
      builder: (context) => AppCard(
        padding: 0,
        child: Column(
          children: filtered.asMap().entries.map((e) {
            final idx = e.key;
            final t = e.value;
            return EquipmentRow(
              item: CharmEquipItem(t),
              isLast: idx == filtered.length - 1,
              onTap: () => _openDetail(context, CharmEquipItem(t)),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _openDetail(BuildContext context, EquipItem item) {
    showAppSheet(context: context, child: EquipmentDetailSheet(item: item));
  }

  List<T> _filterItems<T>(List<T> items, String Function(T) nameOf) {
    if (_query.isEmpty) return items;
    final q = _query.toLowerCase();
    return items.where((i) => nameOf(i).toLowerCase().contains(q)).toList();
  }
}

// ---------------------------------------------------------------------------
// Shared list wrapper
// ---------------------------------------------------------------------------

class _ItemList extends StatelessWidget {
  const _ItemList({
    required this.isEmpty,
    required this.query,
    required this.l10n,
    required this.tokens,
    required this.builder,
  });

  final bool isEmpty;
  final String query;
  final AppLocalizations l10n;
  final AppTokens tokens;
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    if (isEmpty && query.isNotEmpty) {
      return _EmptySearch(query: query, l10n: l10n, tokens: tokens);
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [builder(context)],
    );
  }
}

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
          l10n.searchNoResults(query),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: tokens.label2),
        ),
      ),
    );
  }
}
