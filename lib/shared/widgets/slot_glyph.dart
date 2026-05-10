import 'package:flutter/material.dart';

/// SVG-derived glyphs for each equipment slot kind.
/// The paths are ported from the prototype's SVG viewBox 0 0 24 24.
class SlotGlyph extends StatelessWidget {
  const SlotGlyph({
    super.key,
    required this.kind,
    this.size = 22,
    required this.color,
  });

  final String kind; // 'weapon' | 'head' | 'chest' | 'arms' | 'waist' | 'legs' | 'charm'
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SlotGlyphPainter(kind: kind, color: color),
    );
  }
}

class _SlotGlyphPainter extends CustomPainter {
  const _SlotGlyphPainter({required this.kind, required this.color});

  final String kind;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Scale from the 24×24 SVG viewBox to the actual widget size.
    final sx = size.width / 24.0;
    final sy = size.height / 24.0;

    canvas.save();
    canvas.scale(sx, sy);
    canvas.drawPath(_buildPath(), paint);
    canvas.restore();
  }

  Path _buildPath() {
    final p = Path();
    switch (kind) {
      case 'weapon':
        p.moveTo(3, 17);
        p.lineTo(13, 3);
        p.lineTo(17, 7);
        p.lineTo(7, 21);
        p.close();
      case 'head':
        p.moveTo(5, 14);
        p.cubicTo(5, 8, 8, 4, 12, 4);
        p.cubicTo(16, 4, 19, 8, 19, 14);
        p.lineTo(19, 17);
        p.lineTo(5, 17);
        p.close();
      case 'chest':
        p.moveTo(5, 6);
        p.lineTo(9, 4);
        p.lineTo(12, 7);
        p.lineTo(15, 4);
        p.lineTo(19, 6);
        p.lineTo(19, 18);
        p.lineTo(5, 18);
        p.close();
      case 'arms':
        p.moveTo(5, 6);
        p.lineTo(19, 6);
        p.lineTo(19, 14);
        p.lineTo(17, 18);
        p.lineTo(7, 18);
        p.lineTo(5, 14);
        p.close();
      case 'waist':
        // Rectangle
        p.moveTo(4, 9);
        p.lineTo(20, 9);
        p.lineTo(20, 15);
        p.lineTo(4, 15);
        p.close();
        // Belt lines
        p.moveTo(11, 9);
        p.lineTo(11, 15);
        p.moveTo(13, 9);
        p.lineTo(13, 15);
      case 'legs':
        p.moveTo(7, 4);
        p.lineTo(17, 4);
        p.lineTo(19, 20);
        p.lineTo(14, 20);
        p.lineTo(12, 12);
        p.lineTo(10, 20);
        p.lineTo(5, 20);
        p.close();
      default: // charm / fallback — diamond
        p.moveTo(12, 3);
        p.lineTo(20, 12);
        p.lineTo(12, 21);
        p.lineTo(4, 12);
        p.close();
    }
    return p;
  }

  @override
  bool shouldRepaint(_SlotGlyphPainter old) =>
      old.kind != kind || old.color != color;
}
