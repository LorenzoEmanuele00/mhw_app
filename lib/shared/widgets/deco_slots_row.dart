import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A single decoration slot indicator.
/// level 1 → circle, level 2 → rotated square, level 3 → diamond.
class DecoSlot extends StatelessWidget {
  const DecoSlot({
    super.key,
    required this.level,
    this.filled = false,
    this.color,
    this.size = 14,
  });

  final int level;
  final bool filled;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final emptyColor = isDark
        ? const Color(0x52767680)
        : const Color(0x38787880);
    final c = filled ? (color ?? tokens.accent) : emptyColor;

    if (level == 1) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: c, width: 1.4),
        ),
      );
    }
    if (level == 2) {
      return Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: size * 0.85,
          height: size * 0.85,
          decoration: BoxDecoration(
            border: Border.all(color: c, width: 1.4),
          ),
        ),
      );
    }
    // level 3 — diamond
    return CustomPaint(
      size: Size(size, size),
      painter: _DiamondPainter(color: c),
    );
  }
}

class _DiamondPainter extends CustomPainter {
  const _DiamondPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final path = Path()
      ..moveTo(cx, 0)
      ..lineTo(size.width, cy)
      ..lineTo(cx, size.height)
      ..lineTo(0, cy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DiamondPainter old) => old.color != color;
}

/// A horizontal row of [DecoSlot] badges for a list of slot levels.
/// Shows a dash when the list is empty.
class DecoSlotsRow extends StatelessWidget {
  const DecoSlotsRow({
    super.key,
    required this.slots,
    this.size = 14,
    this.color,
  });

  final List<int> slots;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return Text(
        '—',
        style: TextStyle(
          fontSize: 13,
          color: AppTokens.of(context).label3,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: slots
          .map((lv) => DecoSlot(level: lv, size: size, color: color))
          .toList(),
    );
  }
}
