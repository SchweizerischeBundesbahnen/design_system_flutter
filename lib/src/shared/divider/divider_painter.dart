import 'package:flutter/rendering.dart';

/// Paints a divider that can be indented and optionally at the top of the underlying child.
class DividerPainter extends CustomPainter {
  const DividerPainter({
    required this.color,
    required this.indent,
    required this.paintAtTop,
    this.height = 1.0,
  });

  final Color color;
  final double indent;
  final double height;
  final bool paintAtTop;

  @override
  void paint(Canvas canvas, Size size) {
    final y = paintAtTop ? 0.0 : size.height;
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    canvas.drawLine(Offset(indent, y), Offset(size.width, y), paint);
  }

  @override
  bool shouldRepaint(DividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.indent != indent ||
        oldDelegate.height != height ||
        oldDelegate.paintAtTop != paintAtTop;
  }
}
