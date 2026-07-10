import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SBBPopoverShapeBorder extends ShapeBorder {
  const SBBPopoverShapeBorder({
    required this.direction,
    this.notchOffset = 0.0,
  });

  final SBBPopoverDirection direction;

  // Allows the notch to slide along the edge when the popover collides with screen bounds
  final double notchOffset;

  @override
  EdgeInsetsGeometry get dimensions {
    const notchSize = Size(36, 12);
    return EdgeInsets.only(
      top: direction == SBBPopoverDirection.bottom ? notchSize.height : 0,
      bottom: direction == SBBPopoverDirection.top ? notchSize.height : 0,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const notchSize = Size(36, 12);
    const radius = 8.0;

    // 1. Deflate the rect to leave room for the notch and build the main body
    final contentRect = dimensions.resolve(textDirection).deflateRect(rect);
    final rectPath = Path()..addRRect(RRect.fromRectAndRadius(contentRect, const Radius.circular(radius)));

    // 2. Build the notch in a normalized local coordinate space pointing UP
    final notchPath = _buildNotchPath(direction, contentRect, notchSize);

    // 3. Union the two paths together to create a single clean boundary for shadows
    return Path.combine(PathOperation.union, rectPath, notchPath);
  }

  Path _buildNotchPath(SBBPopoverDirection direction, Rect contentRect, Size notchSize) {
    final w = notchSize.width;
    final h = notchSize.height;

    final localNotch = Path();

    // Start slightly below the bounding box (h + 1) to ensure the base slightly bleeds
    // into the main rect. This prevents 1-pixel floating-point rendering gaps during union.
    localNotch.moveTo(0, h + 1);
    localNotch.lineTo(0, h);

    // Normalized Bézier curves mathematically extracted from the design spec
    localNotch.cubicTo(w * 0.1154, h, w * 0.2308, h * 0.84, w * 0.3077, h * 0.56);
    localNotch.cubicTo(w * 0.3077, h * 0.56, w * 0.4231, h * 0.1467, w * 0.4231, h * 0.1467);
    localNotch.cubicTo(w * 0.4615, 0, w * 0.5385, 0, w * 0.5769, h * 0.1467);
    localNotch.cubicTo(w * 0.5769, h * 0.1467, w * 0.6923, h * 0.56, w * 0.6923, h * 0.56);
    localNotch.cubicTo(w * 0.7692, h * 0.84, w * 0.8846, h, w, h);

    localNotch.lineTo(w, h + 1);
    localNotch.close();

    // Calculate transformation to place the notch on the correct edge
    final matrix = Matrix4.identity();
    double angle = 0;
    Offset target = Offset.zero;

    switch (direction) {
      case SBBPopoverDirection.bottom: // Popover is below, notch on TOP pointing UP
        target = Offset(contentRect.center.dx + notchOffset, contentRect.top);
        angle = 0;
        break;
      case SBBPopoverDirection.top: // Popover is above, notch on BOTTOM pointing DOWN
        target = Offset(contentRect.center.dx + notchOffset, contentRect.bottom);
        angle = math.pi; // 180 degrees
        break;
    }

    // Apply the transformation operations
    matrix.translate(target.dx, target.dy);
    matrix.rotateZ(angle);
    matrix.translate(-w / 2, -h); // Center the local notch over its base before rotation

    return localNotch.transform(matrix.storage);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this; // Assuming no scale mutation needed right now
}
