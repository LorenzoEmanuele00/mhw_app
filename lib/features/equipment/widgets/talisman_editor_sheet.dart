import 'dart:convert';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/calc/skills_repository.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_sheet.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/section_label.dart';
import '../../build/build_notifier.dart';
import '../talismans/talismans_repository.dart';

class TalismanEditorSheet extends ConsumerStatefulWidget {
  const TalismanEditorSheet({super.key, this.existing});

  final Talisman? existing;

  @override
  ConsumerState<TalismanEditorSheet> createState() =>
      _TalismanEditorSheetState();
}

class _TalismanEditorSheetState extends ConsumerState<TalismanEditorSheet> {
  final _nameCtrl = TextEditingController();
  Skill? _skill1;
  int _skill1Level = 1;
  Skill? _skill2;
  int _skill2Level = 1;
  // 3 slots, each 0..3 (0 = no slot)
  final _slotLevels = [0, 0, 0];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final t = widget.existing;
    if (t != null) {
      _nameCtrl.text = t.name;
      _skill1Level = t.skill1Level ?? 1;
      _skill2Level = t.skill2Level ?? 1;
      try {
        final decoded = jsonDecode(t.slots) as List;
        for (int i = 0; i < decoded.length && i < 3; i++) {
          _slotLevels[i] = (decoded[i] as int).clamp(0, 3);
        }
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadSkills();
  }

  bool _preloaded = false;
  Future<void> _preloadSkills() async {
    if (_preloaded || widget.existing == null) return;
    _preloaded = true;
    final t = widget.existing!;
    final skillsRepo = ref.read(skillsRepositoryProvider);
    final s1 =
        t.skill1Id != null ? await skillsRepo.getById(t.skill1Id!) : null;
    final s2 =
        t.skill2Id != null ? await skillsRepo.getById(t.skill2Id!) : null;
    if (mounted) setState(() { _skill1 = s1; _skill2 = s2; });
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    final repo = ref.read(talismansRepositoryProvider);
    final slots = jsonEncode(
      _slotLevels.where((l) => l > 0).toList(),
    );
    final now = DateTime.now().millisecondsSinceEpoch;
    try {
      if (widget.existing == null) {
        await repo.create(TalismansCompanion.insert(
          name: _nameCtrl.text.trim(),
          skill1Id: Value(_skill1?.id),
          skill1Level: Value(_skill1 != null ? _skill1Level : null),
          skill2Id: Value(_skill2?.id),
          skill2Level: Value(_skill2 != null ? _skill2Level : null),
          slots: Value(slots),
          createdAt: now,
        ));
      } else {
        await repo.update(TalismansCompanion(
          id: Value(widget.existing!.id),
          name: Value(_nameCtrl.text.trim()),
          skill1Id: Value(_skill1?.id),
          skill1Level: Value(_skill1 != null ? _skill1Level : null),
          skill2Id: Value(_skill2?.id),
          skill2Level: Value(_skill2 != null ? _skill2Level : null),
          slots: Value(slots),
        ));
        final buildState = ref.read(buildNotifierProvider).asData?.value;
        if (buildState?.talisman?.id == widget.existing!.id) {
          await ref.read(buildNotifierProvider.notifier).refreshActiveBuild();
        }
      }
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final t = widget.existing!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.charmDeleteTitle),
        content: Text(l10n.charmDeleteMessage(t.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.loadoutsCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.charmDeleteConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final repo = ref.read(talismansRepositoryProvider);
    // Unequip from active build if needed
    final buildState = ref.read(buildNotifierProvider).asData?.value;
    if (buildState?.talisman?.id == t.id) {
      await ref.read(buildNotifierProvider.notifier).equipCharm(null);
    }
    await repo.delete(t.id);
    if (mounted) Navigator.of(context).pop();
  }

  Future<Skill?> _pickSkill(Skill? current) async {
    return showAppSheet<Skill>(
      context: context,
      child: _SkillPickerSheet(selected: current),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final isEditing = widget.existing != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  l10n.loadoutsCancel,
                  style: TextStyle(fontSize: 17, color: tokens.label2),
                ),
              ),
              Text(
                isEditing ? l10n.charmEdit : l10n.charmNew,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: tokens.label,
                ),
              ),
              GestureDetector(
                onTap: _saving ? null : _save,
                child: _saving
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: tokens.accent),
                      )
                    : Text(
                        l10n.charmSave,
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

          AppCard(
            padding: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  hintText: l10n.charmNameHint,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: tokens.label3),
                ),
                style: TextStyle(
                  fontSize: 17,
                  color: tokens.label,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          SectionLabel(text: l10n.charmSectionSkills),
          AppCard(
            padding: 0,
            child: Column(
              children: [
                _SkillRow(
                  skill: _skill1,
                  level: _skill1Level,
                  isLast: false,
                  onPickSkill: () async {
                    final picked = await _pickSkill(_skill1);
                    if (picked != null) {
                      setState(() {
                        _skill1 = picked;
                        _skill1Level = _skill1Level.clamp(1, picked.maxLevel);
                      });
                    }
                  },
                  onClear: _skill1 == null
                      ? null
                      : () => setState(() { _skill1 = null; }),
                  onLevelChanged: (l) => setState(() => _skill1Level = l),
                  l10n: l10n,
                  tokens: tokens,
                ),
                _SkillRow(
                  skill: _skill2,
                  level: _skill2Level,
                  isLast: true,
                  onPickSkill: () async {
                    final picked = await _pickSkill(_skill2);
                    if (picked != null) {
                      setState(() {
                        _skill2 = picked;
                        _skill2Level = _skill2Level.clamp(1, picked.maxLevel);
                      });
                    }
                  },
                  onClear: _skill2 == null
                      ? null
                      : () => setState(() { _skill2 = null; }),
                  onLevelChanged: (l) => setState(() => _skill2Level = l),
                  l10n: l10n,
                  tokens: tokens,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          SectionLabel(text: l10n.charmSectionSlots),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (i) {
                return _SlotLevelPicker(
                  level: _slotLevels[i],
                  onChanged: (l) => setState(() => _slotLevels[i] = l),
                  tokens: tokens,
                );
              }),
            ),
          ),

          if (isEditing) ...[
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: _delete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  l10n.charmDelete,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skill row widget (one slot, with pick + level stepper)
// ---------------------------------------------------------------------------

class _SkillRow extends StatelessWidget {
  const _SkillRow({
    required this.skill,
    required this.level,
    required this.isLast,
    required this.onPickSkill,
    required this.onClear,
    required this.onLevelChanged,
    required this.l10n,
    required this.tokens,
  });

  final Skill? skill;
  final int level;
  final bool isLast;
  final VoidCallback onPickSkill;
  final VoidCallback? onClear;
  final ValueChanged<int> onLevelChanged;
  final AppLocalizations l10n;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: tokens.sep, width: 0.5)),
      ),
      child: Row(
        children: [
          // Skill picker button
          Expanded(
            child: GestureDetector(
              onTap: onPickSkill,
              child: Row(
                spacing: 8,
                children: [
                  if (skill != null)
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.skillCategory(skill!.type2, brightness),
                        shape: BoxShape.circle,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      skill?.name ?? l10n.charmSkillNone,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: skill != null ? tokens.label : tokens.label3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Level stepper (only if skill selected)
          if (skill != null) ...[
            _LevelStepper(
              level: level,
              maxLevel: skill!.maxLevel,
              onChanged: onLevelChanged,
              tokens: tokens,
            ),
            const SizedBox(width: 8),
            // Clear button
            GestureDetector(
              onTap: onClear,
              child: Icon(Icons.close_rounded, size: 18, color: tokens.label2),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Level stepper: [-] [N] [+]
// ---------------------------------------------------------------------------

class _LevelStepper extends StatelessWidget {
  const _LevelStepper({
    required this.level,
    required this.maxLevel,
    required this.onChanged,
    required this.tokens,
  });

  final int level;
  final int maxLevel;
  final ValueChanged<int> onChanged;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        _StepButton(
          icon: Icons.remove_rounded,
          enabled: level > 1,
          onTap: () => onChanged(level - 1),
          tokens: tokens,
        ),
        SizedBox(
          width: 28,
          child: Text(
            '$level',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: tokens.label,
            ),
          ),
        ),
        _StepButton(
          icon: Icons.add_rounded,
          enabled: level < maxLevel,
          onTap: () => onChanged(level + 1),
          tokens: tokens,
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
    required this.tokens,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: tokens.fill,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? tokens.label : tokens.label3,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Slot level picker: tap to cycle 0 → 1 → 2 → 3 → 0
// ---------------------------------------------------------------------------

class _SlotLevelPicker extends StatelessWidget {
  const _SlotLevelPicker({
    required this.level,
    required this.onChanged,
    required this.tokens,
  });

  final int level;
  final ValueChanged<int> onChanged;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged((level + 1) % 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: level > 0 ? tokens.accent.withValues(alpha: 0.12) : tokens.fill,
          border: Border.all(
            color: level > 0 ? tokens.accent : Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              level > 0 ? 'Lv $level' : '—',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: level > 0 ? tokens.accent : tokens.label3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skill picker sub-sheet
// ---------------------------------------------------------------------------

class _SkillPickerSheet extends ConsumerStatefulWidget {
  const _SkillPickerSheet({this.selected});
  final Skill? selected;

  @override
  ConsumerState<_SkillPickerSheet> createState() => _SkillPickerSheetState();
}

class _SkillPickerSheetState extends ConsumerState<_SkillPickerSheet> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;
    final allSkillsAsync = ref.watch(allSkillsProvider);

    final skills = allSkillsAsync.asData?.value ?? [];
    final filtered = _query.isEmpty
        ? skills
        : skills
            .where(
                (s) => s.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 56),
              Text(
                l10n.charmPickSkill,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: tokens.label,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SizedBox(
                  width: 56,
                  child: Text(
                    l10n.loadoutsCancel,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 17, color: tokens.label2),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: AppSearchField(
            controller: _searchCtrl,
            placeholder: l10n.charmPickSkill,
            onChanged: (q) => setState(() => _query = q),
          ),
        ),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                _query.isEmpty ? '' : l10n.searchNoResults(_query),
                style: TextStyle(color: tokens.label2),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: AppCard(
              padding: 0,
              child: Column(
                children: filtered.asMap().entries.map((e) {
                  final i = e.key;
                  final skill = e.value;
                  final isSelected = skill.id == widget.selected?.id;
                  final color = AppColors.skillCategory(skill.type2, brightness);
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).pop(skill),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
                      decoration: i < filtered.length - 1
                          ? BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: tokens.sep, width: 0.5)))
                          : null,
                      child: Row(
                        spacing: 12,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              skill.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected ? tokens.accent : tokens.label,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_rounded,
                                size: 18, color: tokens.accent),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
