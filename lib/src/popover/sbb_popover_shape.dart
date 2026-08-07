import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The edge of the popover's content rect a single notch bump attaches to.
enum _NotchEdge { top, bottom }

class SBBPopoverShapeBorder extends ShapeBorder {
  const SBBPopoverShapeBorder({
    required this.direction,
    required this.notch,
    this.notchOffset = 0.0,
  });

  /// The size of a single notch bump, from the design spec. Single source of
  /// truth for the notch geometry: [dimensions] (and through it the reserved
  /// space and child inset in RenderSBBPopover) and [getOuterPath] all derive
  /// from this value.
  static const Size notchSize = Size(36, 12);

  // Corner radius of the rounded content body, from the design spec.
  static const double _cornerRadius = 16.0;

  final SBBPopoverDirection direction;
  final SBBPopoverNotch notch;

  // Desired horizontal shift (in the popover box's own coordinate space) to
  // keep the notch pointing at the target's center when the box itself has
  // been shifted sideways to avoid a screen-edge collision. Clamped in
  // getOuterPath so the notch can never slide into the rounded corners.
  final double notchOffset;

  // The edges that should get a notch bump for the current [notch] config,
  // resolved against [direction] for SBBPopoverNotchSingle (which always
  // tracks whichever edge currently faces the target).
  List<_NotchEdge> get _notchEdges => switch (notch) {
    SBBPopoverNotchNone() => const [],
    SBBPopoverNotchSingle() => [direction == SBBPopoverDirection.bottom ? _NotchEdge.top : _NotchEdge.bottom],
    SBBPopoverNotchBoth() => const [_NotchEdge.top, _NotchEdge.bottom],
  };

  // Covariantly tightened to EdgeInsets so callers (e.g. RenderSBBPopover)
  // can read top/bottom/vertical without a resolve(textDirection) round trip
  // — the insets are direction-agnostic anyway.
  @override
  EdgeInsets get dimensions {
    final edges = _notchEdges;
    return EdgeInsets.only(
      top: edges.contains(_NotchEdge.top) ? notchSize.height : 0,
      bottom: edges.contains(_NotchEdge.bottom) ? notchSize.height : 0,
    );
  }

  // The content area: the rounded body without the notch bump(s). The bumps
  // are decoration outside the content box, so anything laid out against the
  // inner path (e.g. a clipped image/gradient fill or an ink customBorder)
  // stays clear of them.
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path()
    ..addRRect(RRect.fromRectAndRadius(dimensions.deflateRect(rect), const Radius.circular(_cornerRadius)));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // 1. Deflate the rect to leave room for the notch(es) and build the main body
    final contentRect = dimensions.deflateRect(rect);
    var path = Path()..addRRect(RRect.fromRectAndRadius(contentRect, const Radius.circular(_cornerRadius)));

    // Keep the notch clear of the rounded corners on either side. Floored at
    // 0 so a content rect narrower than the notch + corners doesn't invert
    // the clamp range.
    final maxOffset = math.max(0.0, (contentRect.width / 2) - _cornerRadius - (notchSize.width / 2));
    final clampedNotchOffset = notchOffset.clamp(-maxOffset, maxOffset);

    // 2. Union in a notch bump for each edge the current config calls for
    for (final edge in _notchEdges) {
      path = Path.combine(
        PathOperation.union,
        path,
        _buildNotchPath(edge, contentRect, clampedNotchOffset),
      );
    }

    return path;
  }

  Path _buildNotchPath(_NotchEdge edge, Rect contentRect, double notchOffset) {
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

    switch (edge) {
      case _NotchEdge.top: // Notch on TOP edge, pointing UP
        target = Offset(contentRect.center.dx + notchOffset, contentRect.top);
        angle = 0;
        break;
      case _NotchEdge.bottom: // Notch on BOTTOM edge, pointing DOWN
        target = Offset(contentRect.center.dx + notchOffset, contentRect.bottom);
        angle = math.pi; // 180 degrees
        break;
    }

    // Apply the transformation operations
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

  // Intentionally identity: the geometry is fixed by design-spec constants
  // (corner radius, notch size), so there is nothing meaningful to scale.
  // scale() only matters for ShapeBorder.lerp fallbacks, which never run for
  // this shape — the popover doesn't lerp between borders.
  @override
  ShapeBorder scale(double t) => this;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SBBPopoverShapeBorder &&
          direction == other.direction &&
          notch == other.notch &&
          notchOffset == other.notchOffset);

  @override
  int get hashCode => Object.hash(direction, notch, notchOffset);
}
