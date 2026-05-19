import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database.dart';
import '../../../core/database/tables/enums.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/calc/skills_repository.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/deco_slots_row.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/section_label.dart';
import '../../build/build_notifier.dart';
import '../jewels/jewels_repository.dart';

// ---------------------------------------------------------------------------
// Helper: skills keyed by ID for fast lookup (sync Provider, reacts to stream)
// ---------------------------------------------------------------------------

final _skillsMapProvider = Provider<Map<int, Skill>>((ref) {
  final skills = ref.watch(allSkillsProvider).asData?.value ?? [];
  return {for (final s in skills) s.id: s};
});

// ---------------------------------------------------------------------------
// Sheet widget
// ---------------------------------------------------------------------------

/// Bottom sheet for selecting a decoration for a specific slot.
class JewelPickerSheet extends ConsumerStatefulWidget {
  const JewelPickerSheet({
    super.key,
    required this.slotSource,
    required this.slotIndex,
    required this.slotLevel,
  });

  final JewelSlotSource slotSource;
  final int slotIndex;
  final int slotLevel;

  @override
  ConsumerState<JewelPickerSheet> createState() => _JewelPickerSheetState();
}

class _JewelPickerSheetState extends ConsumerState<JewelPickerSheet> {
  final _ctrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;

    final jewelsAsync = ref.watch(allJewelsProvider);
    final jewelSkills = ref.watch(allJewelSkillsProvider).asData?.value ?? [];
    final skillsMap = ref.watch(_skillsMapProvider);

    final currentJewelId = ref
        .watch(buildNotifierProvider)
        .asData
        ?.value
        ?.jewelIdForSlot(widget.slotSource, widget.slotIndex);

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.jewelPickerTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: tokens.label,
                        ),
                      ),
                      Text(
                        l10n.jewelPickerSlotLevel(widget.slotLevel),
                        style: TextStyle(fontSize: 13, color: tokens.label2),
                      ),
                    ],
                  ),
                ),
                if (currentJewelId != null)
                  TextButton(
                    onPressed: () {
                      ref.read(buildNotifierProvider.notifier).clearJewel(
                            widget.slotSource,
                            widget.slotIndex,
                          );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      l10n.slotPickerClear,
                      style: const TextStyle(color: AppColors.negativeRed),
                    ),
                  ),
              ],
            ),
          ),

          AppSearchField(
            controller: _ctrl,
            placeholder: l10n.searchJewels,
            onChanged: (q) => setState(() => _query = q),
          ),

          const SizedBox(height: 16),

          jewelsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const SizedBox.shrink(),
            data: (allJewels) {
              final query = _query.toLowerCase();

              bool matchesQuery(Jewel j) {
                if (query.isEmpty) return true;
                if (j.name.toLowerCase().contains(query)) return true;
                for (final js in jewelSkills.where((s) => s.jewelId == j.id)) {
                  final skill = skillsMap[js.skillId];
                  if (skill != null && skill.name.toLowerCase().contains(query)) {
                    return true;
                  }
                }
                return false;
              }

              final isWeaponSlot = widget.slotSource == JewelSlotSource.weapon;
              bool matchesSource(Jewel j) =>
                  isWeaponSlot ? j.allowedOn == 'weapon' : j.allowedOn == 'armor';

              final available = allJewels
                  .where((j) => j.slotSize <= widget.slotLevel && matchesSource(j) && matchesQuery(j))
                  .toList();
              final tooLarge = _query.isNotEmpty
                  ? allJewels
                      .where((j) => j.slotSize > widget.slotLevel && matchesSource(j) && matchesQuery(j))
                      .toList()
                  : <Jewel>[];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (available.isNotEmpty) ...[
                    SectionLabel(text: l10n.jewelPickerAvailable),
                    AppCard(
                      padding: 0,
                      child: Column(
                        children: available.asMap().entries.map((e) {
                          final jewel = e.value;
                          final isSelected = jewel.id == currentJewelId;
                          final skills = jewelSkills
                              .where((js) => js.jewelId == jewel.id)
                              .map((js) => skillsMap[js.skillId])
                              .whereType<Skill>()
                              .toList();
                          return _JewelRow(
                            jewel: jewel,
                            skills: skills,
                            isSelected: isSelected,
                            isLast: e.key == available.length - 1,
                            dimmed: false,
                            brightness: brightness,
                            onTap: () {
                              ref.read(buildNotifierProvider.notifier).setJewel(
                                    widget.slotSource,
                                    widget.slotIndex,
                                    jewel.id,
                                  );
                              Navigator.of(context).pop();
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (tooLarge.isNotEmpty) ...[
                    SectionLabel(text: l10n.jewelPickerTooLarge),
                    AppCard(
                      padding: 0,
                      child: Column(
                        children: tooLarge.asMap().entries.map((e) {
                          final jewel = e.value;
                          final skills = jewelSkills
                              .where((js) => js.jewelId == jewel.id)
                              .map((js) => skillsMap[js.skillId])
                              .whereType<Skill>()
                              .toList();
                          return _JewelRow(
                            jewel: jewel,
                            skills: skills,
                            isSelected: false,
                            isLast: e.key == tooLarge.length - 1,
                            dimmed: true,
                            brightness: brightness,
                            onTap: null,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                  if (available.isEmpty && tooLarge.isEmpty && _query.isNotEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          l10n.searchNoResults(_query),
                          style: TextStyle(fontSize: 14, color: tokens.label2),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Row widget
// ---------------------------------------------------------------------------

class _JewelRow extends StatelessWidget {
  const _JewelRow({
    required this.jewel,
    required this.skills,
    required this.isSelected,
    required this.isLast,
    required this.dimmed,
    required this.brightness,
    required this.onTap,
  });

  final Jewel jewel;
  final List<Skill> skills;
  final bool isSelected;
  final bool isLast;
  final bool dimmed;
  final Brightness brightness;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Opacity(
        opacity: dimmed ? 0.4 : 1.0,
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
              DecoSlot(level: jewel.slotSize, size: 20, filled: isSelected),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jewel.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        color: tokens.label,
                      ),
                    ),
                    if (skills.isNotEmpty)
                      Text(
                        skills.map((s) => s.name).join(', '),
                        style: TextStyle(fontSize: 13, color: tokens.label2),
                      ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_rounded, size: 18, color: tokens.accent),
            ],
          ),
        ),
      ),
    );
  }
}
