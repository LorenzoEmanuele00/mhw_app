import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/app_card.dart';
import '../models/equip_item.dart';
import 'equipment_row.dart';

/// Bottom sheet that lets the user pick one item from a pre-filtered list.
/// [itemsStream] should be a stream of already-mapped [EquipItem]s so this
/// widget stays generic. The stream keeps emitting, so the list updates if
/// the DB changes while the sheet is open.
class SlotPickerSheet extends StatefulWidget {
  const SlotPickerSheet({
    super.key,
    required this.title,
    required this.itemsStream,
    required this.onSelected,
    this.onClear,
    this.currentId,
  });

  final String title;
  final Stream<List<EquipItem>> itemsStream;
  final void Function(EquipItem) onSelected;
  final VoidCallback? onClear;
  final int? currentId;

  @override
  State<SlotPickerSheet> createState() => _SlotPickerSheetState();
}

class _SlotPickerSheetState extends State<SlotPickerSheet> {
  final _ctrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  List<EquipItem> _filtered(List<EquipItem> items) {
    if (_query.isEmpty) return items;
    final q = _query.toLowerCase();
    return items.where((i) => i.name.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                      color: tokens.label,
                    ),
                  ),
                ),
                if (widget.onClear != null)
                  TextButton(
                    onPressed: () {
                      widget.onClear!();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      l10n.slotPickerClear,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.negativeRed,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          AppSearchField(
            controller: _ctrl,
            placeholder: widget.title,
            onChanged: (q) => setState(() => _query = q),
          ),

          const SizedBox(height: 16),

          StreamBuilder<List<EquipItem>>(
            stream: widget.itemsStream,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting && !snap.hasData) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snap.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      snap.error.toString(),
                      style: TextStyle(color: tokens.label2),
                    ),
                  ),
                );
              }
              final allItems = snap.data ?? [];
              final filtered = _filtered(allItems);
              if (filtered.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      _query.isEmpty ? '' : l10n.searchNoResults(_query),
                      style: TextStyle(fontSize: 14, color: tokens.label2),
                    ),
                  ),
                );
              }
              return AppCard(
                padding: 0,
                child: Column(
                  children: filtered.asMap().entries.map((e) {
                    final idx = e.key;
                    final item = e.value;
                    final isSelected = _idOf(item) == widget.currentId;
                    return EquipmentRow(
                      item: item,
                      isLast: idx == filtered.length - 1,
                      isEquipped: isSelected,
                      onTap: () {
                        widget.onSelected(item);
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  int? _idOf(EquipItem item) => switch (item) {
        WeaponEquipItem(:final weapon) => weapon.id,
        ArmorEquipItem(:final piece) => piece.id,
        CharmEquipItem(:final talisman) => talisman.id,
      };
}
