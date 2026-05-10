import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Colored pill chip showing a skill name + current level / max level.
class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.name,
    required this.level,
    required this.max,
    required this.color,
  });

  final String name;
  final int level;
  final int max;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.14 : 0.09),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: -0.08,
            ),
          ),
          Text(
            '$level/$max',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

/// A compact colored dot + text row used in detail sheets.
class SkillDotRow extends StatelessWidget {
  const SkillDotRow({
    super.key,
    required this.name,
    required this.level,
    required this.description,
    required this.color,
    this.isLast = false,
  });

  final String name;
  final int level;
  final String? description;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Container(
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
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: tokens.label,
                    letterSpacing: -0.32,
                  ),
                ),
                if (description != null && description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      description!,
                      style: TextStyle(fontSize: 13, color: tokens.label2),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '+$level',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
