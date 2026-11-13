import 'package:flutter/rendering.dart';

/// Paints a divider that can be indented and optionally at the top of the underlying child.
class const DividerPainter({
  required final Color color,
  required final double indent,
  required final bool paintAtTop,
  final double height = 1.0,
}) extends CustomPainter {
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
