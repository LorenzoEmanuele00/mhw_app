import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../core/database/tables/enums.dart';

/// Segmented sharpness bar — 7 colour segments (red → orange → yellow → green
/// → blue → white → purple). [value] is a 0.0–1.0 fraction of the total bar
/// filled, matching the weapon's sharpness_max position in the sequence.
class SharpnessGauge extends StatelessWidget {
  const SharpnessGauge({super.key, required this.sharpnessMax});

  final SharpnessLevel sharpnessMax;

  static const _segments = [
    (level: SharpnessLevel.red,    fraction: 0.05),
    (level: SharpnessLevel.orange, fraction: 0.10),
    (level: SharpnessLevel.yellow, fraction: 0.10),
    (level: SharpnessLevel.green,  fraction: 0.20),
    (level: SharpnessLevel.blue,   fraction: 0.20),
    (level: SharpnessLevel.white,  fraction: 0.20),
    (level: SharpnessLevel.purple, fraction: 0.15),
  ];

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);

    // Compute the fill level: fraction up to and including sharpnessMax.
    double fillLevel = 0;
    for (final seg in _segments) {
      fillLevel += seg.fraction;
      if (seg.level == sharpnessMax) break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 10,
        child: Row(
          children: _segments.map((seg) {
            final segStart = _startOf(seg.level);
            final filledFraction =
                ((fillLevel - segStart) / seg.fraction).clamp(0.0, 1.0);
            final baseColor = AppColors.sharpness(seg.level);

            return Expanded(
              flex: (seg.fraction * 1000).round(),
              child: Stack(
                children: [
                  Container(
                    color: tokens.barTrack,
                  ),
                  FractionallySizedBox(
                    widthFactor: filledFraction,
                    alignment: Alignment.centerLeft,
                    child: Container(color: baseColor),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  static double _startOf(SharpnessLevel level) {
    double s = 0;
    for (final seg in _segments) {
      if (seg.level == level) return s;
      s += seg.fraction;
    }
    return s;
  }
}
