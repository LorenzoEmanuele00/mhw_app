import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A labeled horizontal progress bar with a numeric value.
/// When [signed] is true, the bar fills from centre (zero line) either left or
/// right, and negative values render in red.
class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    required this.color,
    this.signed = false,
    this.suffix = '',
  });

  final String label;
  final num value;
  final num max;
  final Color color;
  final bool signed;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isNeg = signed && value < 0;
    final pct = (value.abs() / max).clamp(0.0, 1.0).toDouble();
    final displayValue = signed && value > 0 ? '+$value' : '$value';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 6,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: tokens.label2,
                letterSpacing: -0.08,
              ),
            ),
            Text(
              '$displayValue$suffix',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isNeg ? AppColors.negativeRed : tokens.label,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                // Track
                Container(color: tokens.barTrack),
                // Fill
                if (signed)
                  _SignedFill(pct: pct, isNeg: isNeg, color: color)
                else
                  FractionallySizedBox(
                    widthFactor: pct,
                    alignment: Alignment.centerLeft,
                    child: Container(color: color),
                  ),
                // Centre divider for signed bars
                if (signed)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 1,
                      color: tokens.label3,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SignedFill extends StatelessWidget {
  const _SignedFill({
    required this.pct,
    required this.isNeg,
    required this.color,
  });
  final double pct;
  final bool isNeg;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final half = constraints.maxWidth / 2;
        final fillW = pct * half;
        return Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: isNeg ? half - fillW : half,
              width: fillW,
              child: Container(
                color: isNeg ? AppColors.negativeRed : color,
              ),
            ),
          ],
        );
      },
    );
  }
}
