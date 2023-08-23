import '../../design_system_flutter.dart';
import 'package:flutter/material.dart';

const double _kCircleBorderWidth = 1.0;
const double _kSelectedWidth = 8.0;
const double _kUnselectedWidth = 6.0;
const Size _kBoundingBox = Size(8.0, 8.0);

class PaginationCircle extends StatelessWidget {
  const PaginationCircle({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).pagination!;
    final resolvedDrawingColor = isSelected
        ? style.selectedColor ?? SBBColors.red
        : style.borderColor ?? SBBColors.metal;
    return SizedBox.fromSize(
      size: _kBoundingBox,
      child: Center(
        child: CustomPaint(
          painter: _PaginationCirclePainter(
            isFilled: isSelected,
            drawingColor: resolvedDrawingColor,
          ),
          size: Size.square(
            isSelected ? _kSelectedWidth : _kUnselectedWidth,
          ),
        ),
      ),
    );
  }
}

class _PaginationCirclePainter extends CustomPainter {
  _PaginationCirclePainter({
    required this.isFilled,
    required this.drawingColor,
  }) {
    _paint = Paint()
      ..color = drawingColor
      ..strokeWidth = _kCircleBorderWidth
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke;
  }
  final bool isFilled;
  final Color drawingColor;
  late Paint _paint;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(_PaginationCirclePainter oldPainter) {
    return oldPainter.isFilled != isFilled ||
        oldPainter.drawingColor != drawingColor;
  }
}
