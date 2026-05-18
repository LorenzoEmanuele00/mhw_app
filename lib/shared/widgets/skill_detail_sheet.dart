import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/calc/skills_repository.dart';
import '../../shared/theme/app_theme.dart';

class SkillDetailSheet extends ConsumerWidget {
  const SkillDetailSheet({
    super.key,
    required this.skill,
    required this.currentLevel,
  });

  final Skill skill;
  final int currentLevel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AppTokens.of(context);
    final brightness = Theme.of(context).brightness;
    final color = AppColors.skillCategory(skill.type2, brightness);
    final levelsAsync = ref.watch(skillLevelsProvider(skill.id));
    final isItalian = Localizations.localeOf(context).languageCode == 'it';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name with colored dot
          Row(
            spacing: 10,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              Expanded(
                child: Text(
                  skill.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: tokens.label,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),

          // General description
          () {
            final desc = isItalian
                ? (skill.descriptionIt?.isNotEmpty == true
                      ? skill.descriptionIt
                      : skill.description)
                : skill.description;
            if (desc == null || desc.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 14,
                    color: tokens.label2,
                    height: 1.45,
                  ),
                ),
              ],
            );
          }(),

          const SizedBox(height: 24),

          // Section header
          Text(
            l10n.skillDetailLevels.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: tokens.label2,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),

          // Levels list
          levelsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text(l10n.initError(e)),
            data: (levels) => Column(
              children: [
                for (int i = 0; i < levels.length; i++) ...[
                  _LevelRow(
                    skillLevel: levels[i],
                    isActive: levels[i].level == currentLevel,
                    color: color,
                    isItalian: isItalian,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  const _LevelRow({
    required this.skillLevel,
    required this.isActive,
    required this.color,
    required this.isItalian,
  });

  final SkillLevel skillLevel;
  final bool isActive;
  final Color color;
  final bool isItalian;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isActive
            ? color.withValues(alpha: isDark ? 0.14 : 0.09)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // Level badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: isActive ? color : tokens.fill,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Lv ${skillLevel.level}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isActive ? Colors.white : tokens.label2,
                letterSpacing: 0.1,
              ),
            ),
          ),

          // Description
          Expanded(
            child: Text(
              () {
                if (isItalian && skillLevel.descriptionIt?.isNotEmpty == true) {
                  return skillLevel.descriptionIt!;
                }
                return (skillLevel.description?.isNotEmpty == true)
                    ? skillLevel.description!
                    : '—';
              }(),
              style: TextStyle(
                fontSize: 14,
                color: isActive ? tokens.label : tokens.label2,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
