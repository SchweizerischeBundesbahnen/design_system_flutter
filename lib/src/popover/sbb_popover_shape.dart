import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SBBPopoverShapeBorder extends ShapeBorder {
  const SBBPopoverShapeBorder({
    required this.placementEdge,
    required this.showNotch,
    this.notchOffset = 0.0,
  });

  static const Size notchSize = Size(36, 12);

  // Corner radius of the rounded content body, from the design spec.
  static const double _cornerRadius = 16.0;

  /// The minimum extent a popover box needs for the notch bump.
  ///
  /// Below this, a notch cannot be built without deforming
  /// into the corner curves, so no notch is drawn at all.
  static double get minExtentForNotch => notchSize.width + 2 * _cornerRadius;

  /// The resolved edge of the target the popover sits on. The notch is drawn
  /// on the opposite — target-facing — edge of the popover box.
  final SBBPopoverEdge placementEdge;

  /// Whether the notch bump is part of the shape at all.
  final bool showNotch;

  // Desired shift along popover's cross-axis to keep the notch pointing
  // at the target's center when the box itself has been shifted to avoid
  // a viewport-edge collision.

  // Clamped in getOuterPath so the notch can never slide into the rounded
  // corners.
  final double notchOffset;

  // The popover-box edge that gets the notch bump: the edge facing the
  // target, i.e. the opposite of the edge the popover is placed on.
  SBBPopoverEdge? get _notchEdge => showNotch ? placementEdge.opposite : null;

  @override
  EdgeInsets get dimensions => switch (_notchEdge) {
    null => EdgeInsets.zero,
    SBBPopoverEdge.top => EdgeInsets.only(top: notchSize.height),
    SBBPopoverEdge.bottom => EdgeInsets.only(bottom: notchSize.height),
    SBBPopoverEdge.left => EdgeInsets.only(left: notchSize.height),
    SBBPopoverEdge.right => EdgeInsets.only(right: notchSize.height),
  };

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRRect(RRect.fromRectAndRadius(dimensions.deflateRect(rect), const .circular(_cornerRadius)));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // deflate the rect to leave room for the notch
    final contentRect = dimensions.deflateRect(rect);
    final path = Path()..addRRect(RRect.fromRectAndRadius(contentRect, const .circular(_cornerRadius)));

    final notchEdge = _notchEdge;
    if (notchEdge == null) return path;

    // Keep the notch clear of the rounded corners on either side. Floored at
    // 0 so a content rect smaller than the notch + corners doesn't invert
    // the clamp range.
    final edgeExtent = notchEdge.mainAxis == .vertical ? contentRect.width : contentRect.height;
    final maxOffset = math.max(0.0, (edgeExtent / 2) - _cornerRadius - (notchSize.width / 2));
    final clampedNotchOffset = notchOffset.clamp(-maxOffset, maxOffset);

    // union in the notch bump on the target-facing edge
    return Path.combine(
      PathOperation.union,
      path,
      _buildNotchPath(notchEdge, contentRect, clampedNotchOffset),
    );
  }

  Path _buildNotchPath(SBBPopoverEdge edge, Rect contentRect, double notchOffset) {
    final w = notchSize.width;
    final h = notchSize.height;

    final localNotch = Path();

    // Start slightly below the bounding box (h + 1) to ensure the base slightly bleeds
    // into the main rect. This prevents 1-pixel floating-point rendering gaps during union.
    localNotch.moveTo(0, h + 1);
    localNotch.lineTo(0, h);

    // extracted from the design spec
    localNotch.cubicTo(w * 0.1154, h, w * 0.2308, h * 0.84, w * 0.3077, h * 0.56);
    localNotch.cubicTo(w * 0.3077, h * 0.56, w * 0.4231, h * 0.1467, w * 0.4231, h * 0.1467);
    localNotch.cubicTo(w * 0.4615, 0, w * 0.5385, 0, w * 0.5769, h * 0.1467);
    localNotch.cubicTo(w * 0.5769, h * 0.1467, w * 0.6923, h * 0.56, w * 0.6923, h * 0.56);
    localNotch.cubicTo(w * 0.7692, h * 0.84, w * 0.8846, h, w, h);

    localNotch.lineTo(w, h + 1);
    localNotch.close();

    final (Offset target, double angle) = switch (edge) {
      SBBPopoverEdge.top => (Offset(contentRect.center.dx + notchOffset, contentRect.top), 0.0),
      SBBPopoverEdge.bottom => (Offset(contentRect.center.dx + notchOffset, contentRect.bottom), math.pi),
      SBBPopoverEdge.left => (Offset(contentRect.left, contentRect.center.dy + notchOffset), -math.pi / 2),
      SBBPopoverEdge.right => (Offset(contentRect.right, contentRect.center.dy + notchOffset), math.pi / 2),
    };

    final matrix = Matrix4.identity();
    matrix.translateByDouble(target.dx, target.dy, 0, 1);
    matrix.rotateZ(angle);
    matrix.translateByDouble(-w / 2, -h, 0, 1); // Center the local notch over its base before rotation

    return localNotch.transform(matrix.storage);
  }

  // Intentionally empty: this shape has no stroked border — it only defines
  // geometry. The surface fill happens through ShapeDecoration (which uses
  // getOuterPath), not through the border painting itself.
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  // Intentionally identity: the geometry is fixed by design-spec constants.
  @override
  ShapeBorder scale(double t) => this;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SBBPopoverShapeBorder &&
          placementEdge == other.placementEdge &&
          showNotch == other.showNotch &&
          notchOffset == other.notchOffset);

  @override
  int get hashCode => Object.hash(placementEdge, showNotch, notchOffset);
}
