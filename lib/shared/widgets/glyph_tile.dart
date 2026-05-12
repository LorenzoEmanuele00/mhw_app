import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'slot_glyph.dart';

/// A tinted rounded-square badge containing the slot glyph for an equipment kind.
/// Used as the icon thumbnail in lists and detail sheets.
class GlyphTile extends StatelessWidget {
  const GlyphTile({
    super.key,
    required this.kind,
    this.size = 44,
    this.borderRadius = 11,
    this.color,
  });

  final String kind;
  final double size;
  final double borderRadius;

  /// Override accent color. Defaults to [AppTokens.accent].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = color ?? tokens.accent;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: isDark ? 0.14 : 0.10),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: accent.withValues(alpha: isDark ? 0.19 : 0.15),
          width: 0.5,
        ),
      ),
      child: Center(
        child: SlotGlyph(
          kind: kind,
          size: size * 0.5,
          color: accent,
        ),
      ),
    );
  }
}
