import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_shape.dart';

/// Positions and paints an [SBBPopover]'s content relative to its target.
class SBBPopoverLayout extends SingleChildRenderObjectWidget {
  const SBBPopoverLayout({
    super.key,
    required this.placement,
    required this.targetPosition,
    required this.targetSize,
    required this.showNotch,
    required this.alignNotchToTarget,
    required this.color,
    this.popoverConstraints = const BoxConstraints(),
    this.sideOffset = 0.0,
    this.alignmentOffset = 0.0,
    this.viewportMargin = EdgeInsets.zero,
    this.scaleAnimation,
    super.child,
  });

  /// The preferred placement of the popover relative to the target. The edge
  /// is a preference — a viewport collision can flip it to the opposite side.
  final SBBPopoverPlacement placement;

  /// The target's top-left corner in the enclosing [Overlay]'s coordinate
  /// space — which is also this layout's own space, since the popover layout
  /// fills the overlay. NOT a global position: under a nested overlay or a
  /// transformed ancestor the two differ.
  final Offset targetPosition;

  final Size targetSize;

  /// Whether the decorative notch is drawn on the target-facing edge.
  final bool showNotch;

  /// Whether the notch shifts along its edge to keep pointing at the
  /// target's center when the box is shifted by a viewport collision; when
  /// false it stays centered on the box. Only relevant while [showNotch].
  final bool alignNotchToTarget;

  /// The fill color of the popover surface.
  final Color color;

  /// Additional constraints on the popover box itself (e.g. a maxWidth cap),
  /// intersected with the space the viewport actually offers.
  final BoxConstraints popoverConstraints;

  /// Scales the popover box around the center of its target-facing edge.
  ///
  /// Applied at paint time inside the render object rather than with a
  /// [ScaleTransition] above it, because this render object fills the whole
  /// overlay — a widget-level transition would pivot around the screen, not
  /// the popover. The resolved popover rect (and thus the correct pivot)
  /// only exists after layout, in here.
  final Animation<double>? scaleAnimation;

  /// Main-axis gap between the target and the popover box.
  ///
  /// A positive value always pushes the box further away from the target,
  /// so it's automatically inverted when a viewport collision flips the
  /// resolved edge.
  final double sideOffset;

  /// Cross-axis nudge along the aligned edge, applied on top of the
  /// placement's alignment before viewport clamping (so it's kept, not
  /// dropped, when a shift happens). Positive values move toward the cross
  /// axis's end: to the right for top/bottom placements, downward for
  /// left/right ones.
  final double alignmentOffset;

  /// Minimum empty space to keep between the popover box and the enclosing
  /// viewport's edges. The layout treats the viewport shrunk by this margin
  /// as the usable area for clamping and per-side space budgets. Safe-area
  /// and keyboard insets are expected to already be composed in by the
  /// widget layer.
  final EdgeInsets viewportMargin;

  @override
  RenderSBBPopover createRenderObject(BuildContext context) => RenderSBBPopover(
    placement: placement,
    targetPosition: targetPosition,
    targetSize: targetSize,
    showNotch: showNotch,
    alignNotchToTarget: alignNotchToTarget,
    color: color,
    popoverConstraints: popoverConstraints,
    sideOffset: sideOffset,
    alignmentOffset: alignmentOffset,
    viewportMargin: viewportMargin,
    scaleAnimation: scaleAnimation,
  );

  @override
  void updateRenderObject(BuildContext context, RenderSBBPopover renderObject) {
    renderObject
      ..placement = placement
      ..targetPosition = targetPosition
      ..targetSize = targetSize
      ..showNotch = showNotch
      ..alignNotchToTarget = alignNotchToTarget
      ..color = color
      ..popoverConstraints = popoverConstraints
      ..sideOffset = sideOffset
      ..alignmentOffset = alignmentOffset
      ..viewportMargin = viewportMargin
      ..scaleAnimation = scaleAnimation;
  }
}

class RenderSBBPopover extends RenderShiftedBox {
  RenderSBBPopover({
    required SBBPopoverPlacement placement,
    required Offset targetPosition,
    required Size targetSize,
    required bool showNotch,
    required bool alignNotchToTarget,
    required Color color,
    required BoxConstraints popoverConstraints,
    required double sideOffset,
    required double alignmentOffset,
    required EdgeInsets viewportMargin,
    Animation<double>? scaleAnimation,
    RenderBox? child,
  }) : _placement = placement,
       _targetPosition = targetPosition,
       _targetSize = targetSize,
       _showNotch = showNotch,
       _alignNotchToTarget = alignNotchToTarget,
       _color = color,
       _popoverConstraints = popoverConstraints,
       _sideOffset = sideOffset,
       _alignmentOffset = alignmentOffset,
       _viewportMargin = viewportMargin,
       _scaleAnimation = scaleAnimation,
       super(child);

  SBBPopoverPlacement _placement;

  set placement(SBBPopoverPlacement value) {
    if (_placement == value) return;
    _placement = value;
    markNeedsLayout();
  }

  Offset _targetPosition;

  set targetPosition(Offset value) {
    if (_targetPosition == value) return;
    _targetPosition = value;
    markNeedsLayout();
  }

  Size _targetSize;

  set targetSize(Size value) {
    if (_targetSize == value) return;
    _targetSize = value;
    markNeedsLayout();
  }

  bool _showNotch;

  set showNotch(bool value) {
    if (_showNotch == value) return;
    _showNotch = value;
    markNeedsLayout();
  }

  bool _alignNotchToTarget;

  set alignNotchToTarget(bool value) {
    if (_alignNotchToTarget == value) return;
    _alignNotchToTarget = value;
    markNeedsLayout();
  }

  Color _color;

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    _invalidateDecoration();
    markNeedsPaint();
  }

  BoxConstraints _popoverConstraints;

  set popoverConstraints(BoxConstraints value) {
    if (_popoverConstraints == value) return;
    _popoverConstraints = value;
    markNeedsLayout();
  }

  double _sideOffset;

  set sideOffset(double value) {
    if (_sideOffset == value) return;
    _sideOffset = value;
    markNeedsLayout();
  }

  double _alignmentOffset;

  set alignmentOffset(double value) {
    if (_alignmentOffset == value) return;
    _alignmentOffset = value;
    markNeedsLayout();
  }

  EdgeInsets _viewportMargin;

  set viewportMargin(EdgeInsets value) {
    if (_viewportMargin == value) return;
    _viewportMargin = value;
    markNeedsLayout();
  }

  Animation<double>? _scaleAnimation;

  set scaleAnimation(Animation<double>? value) {
    if (_scaleAnimation == value) return;
    if (attached) _scaleAnimation?.removeListener(markNeedsPaint);
    _scaleAnimation = value;
    if (attached) _scaleAnimation?.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  /// The placement resolved during the most recent layout pass (after
  /// collision-driven edge flipping). Exposed for tests/diagnostics.
  SBBPopoverPlacement get resolvedPlacement => SBBPopoverPlacement(_resolvedEdge, _placement.crossAxisAlignment);
  SBBPopoverEdge _resolvedEdge = SBBPopoverEdge.bottom;

  /// The visible popover's rect, in this render object's own local
  /// coordinate space. Exposed for tests/diagnostics.
  Rect get popoverRect => _popoverRect;
  Rect _popoverRect = Rect.zero;

  // The popover's painted outline in local coordinates. Built once per layout
  // pass (getOuterPath's Path.combine unions are not cheap) and used by
  // hitTestSelf(). The background painter caches its own copy of the same
  // path internally.
  Path _shapePath = Path();

  // The shape border resolved during the most recent layout pass — the
  // resolved edge and notch offset that feed it only exist post-layout,
  // which is why the surface can't simply be a ShapeDecoration on the child
  // in the widget layer. Decoration and painter are derived lazily in paint
  // and invalidated whenever the border, color or shadows change.
  SBBPopoverShapeBorder? _shapeBorder;
  ShapeDecoration? _decoration;
  BoxPainter? _backgroundPainter;

  void _invalidateDecoration() {
    _decoration = null;
    _backgroundPainter?.dispose();
    _backgroundPainter = null;
  }

  // This render object always fills the incoming constraints (it covers the
  // whole overlay); its size never depends on the child.
  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.biggest;

  // The preferred size for any given cross extent is unbounded.
  @override
  double computeMinIntrinsicWidth(double height) => 0.0;

  @override
  double computeMaxIntrinsicWidth(double height) => 0.0;

  @override
  double computeMinIntrinsicHeight(double width) => 0.0;

  @override
  double computeMaxIntrinsicHeight(double width) => 0.0;

  // The whole layout runs in main/cross coordinates keyed off the placement
  // axis (main = the axis the popover is pushed away from the target on,
  // where flipping happens; cross = the axis alignment and edge clamping
  // happen on). The algorithm is written once; only the transposition into
  // and out of x/y depends on the axis.
  @override
  void performLayout() {
    size = constraints.biggest;

    final RenderBox? child = this.child;
    if (child == null) {
      _popoverRect = Rect.zero;
      _shapePath = Path();
      _shapeBorder = null;
      _invalidateDecoration();
      return;
    }

    final bool vertical = _placement.mainAxis == Axis.vertical;

    // Usable viewport, inside the margin (the popover must never sit flush
    // against an edge; safe-area/keyboard insets arrive already composed
    // into the margin).
    final double viewportMainMin = vertical ? _viewportMargin.top : _viewportMargin.left;
    final double viewportMainMax = vertical
        ? constraints.maxHeight - _viewportMargin.bottom
        : constraints.maxWidth - _viewportMargin.right;
    final double viewportCrossMin = vertical ? _viewportMargin.left : _viewportMargin.top;
    final double viewportCrossMax = vertical
        ? constraints.maxWidth - _viewportMargin.right
        : constraints.maxHeight - _viewportMargin.bottom;

    final double targetMainStart = vertical ? _targetPosition.dy : _targetPosition.dx;
    final double targetMainEnd = targetMainStart + (vertical ? _targetSize.height : _targetSize.width);
    final double targetCrossStart = vertical ? _targetPosition.dx : _targetPosition.dy;
    final double targetCrossEnd = targetCrossStart + (vertical ? _targetSize.width : _targetSize.height);

    // Main-axis space available on either side of the target. sideOffset is
    // part of the occupied extent on whichever side gets resolved (a
    // positive value pushes the box further from the target), so it shrinks
    // both budgets up front — a large offset can force a flip just like an
    // oversized child can.
    final double spaceAfter = viewportMainMax - targetMainEnd - _sideOffset; // below / right of the target
    final double spaceBefore = targetMainStart - viewportMainMin - _sideOffset; // above / left of the target

    // Constrain the child to the larger of the two sides instead of the full
    // overlay extent, so oversized (e.g. scrollable) content sizes to the
    // most space it can possibly get on either side of the target rather
    // than overflowing the screen — intersected with the configured box
    // constraints (the maxWidth cap), and shrunk by the strip the notch
    // reserves. The reserve is queried with the *preferred* edge; a flip
    // stays on the same axis, so the reserved extent is identical either
    // way.
    final double mainAvail = math.max(0, math.max(spaceAfter, spaceBefore));
    final double crossAvail = math.max(0, viewportCrossMax - viewportCrossMin);
    final BoxConstraints available = BoxConstraints(
      maxWidth: vertical ? crossAvail : mainAvail,
      maxHeight: vertical ? mainAvail : crossAvail,
    );
    final BoxConstraints childConstraints = _popoverConstraints
        .enforce(available)
        .deflate(_shapeFor(_placement.edge, _showNotch).dimensions);
    child.layout(childConstraints, parentUsesSize: true);

    // A box too small to host the notch bump between its rounded corners
    // would deform the silhouette — drop the notch entirely instead. Decided
    // only after child layout because the box extent isn't known before; the
    // child was therefore constrained with the configured notch's reserved
    // strip, which is merely conservative (up to 12px less), never too
    // large.
    final double boxCross = vertical ? child.size.width : child.size.height;
    final bool effectiveShowNotch = _showNotch && boxCross >= SBBPopoverShapeBorder.minExtentForNotch;

    final double boxMain =
        (vertical ? child.size.height : child.size.width) +
        _shapeFor(_placement.edge, effectiveShowNotch).dimensions.along(_placement.mainAxis);

    // Cross-axis position
    // The ideal position comes from the placement's alignment (start/end are
    // physical: left/top and right/bottom), nudged by alignmentOffset, then
    // shifted to avoid colliding with viewport edges — the offset is baked
    // into the ideal position before clamping, so it's kept (not dropped)
    // when a shift happens, it's just clamped along with everything else.
    double crossPos =
        switch (_placement.crossAxisAlignment) {
          SBBPopoverAlignment.start => targetCrossStart,
          SBBPopoverAlignment.center => (targetCrossStart + targetCrossEnd - boxCross) / 2,
          SBBPopoverAlignment.end => targetCrossEnd - boxCross,
        } +
        _alignmentOffset;
    crossPos = clampDouble(crossPos, viewportCrossMin, math.max(viewportCrossMin, viewportCrossMax - boxCross));

    // Main-axis position
    // Keep the preferred edge as long as the box fits there; flip only when
    // it doesn't AND the opposite side is actually bigger — flipping onto a
    // smaller side can't help. Because the child was constrained to the
    // larger side's space above, the box is guaranteed to fit after a flip.
    final bool preferAfter = _placement.edge == SBBPopoverEdge.bottom || _placement.edge == SBBPopoverEdge.right;
    final double preferredSpace = preferAfter ? spaceAfter : spaceBefore;
    final double oppositeSpace = preferAfter ? spaceBefore : spaceAfter;
    SBBPopoverEdge finalEdge = _placement.edge;
    if (boxMain > preferredSpace && oppositeSpace > preferredSpace) {
      finalEdge = finalEdge.opposite;
    }

    // sideOffset always pushes the box further away from the target, on
    // whichever side it ends up — the branch is keyed on finalEdge (not the
    // preferred one), so the direction it pushes in automatically inverts
    // relative to what was authored whenever a collision flips the edge.
    final bool finalAfter = finalEdge == SBBPopoverEdge.bottom || finalEdge == SBBPopoverEdge.right;
    double mainPos = finalAfter ? targetMainEnd + _sideOffset : targetMainStart - _sideOffset - boxMain;
    // Safety net for the degenerate cases a flip can't solve (target partly
    // off-screen, or a box bigger than either side): keep the box inside the
    // margin-shrunk overlay, mirroring the cross-axis clamp above. The box
    // may then overlap the target, but it never draws off-screen.
    mainPos = clampDouble(mainPos, viewportMainMin, math.max(viewportMainMin, viewportMainMax - boxMain));

    _popoverRect = vertical
        ? Rect.fromLTWH(crossPos, mainPos, boxCross, boxMain)
        : Rect.fromLTWH(mainPos, crossPos, boxMain, boxCross);

    final shapeBorder = SBBPopoverShapeBorder(
      placementEdge: finalEdge,
      showNotch: effectiveShowNotch,
      notchOffset: _notchOffset,
    );

    // The child sits inside whatever strip the shape reserves for the notch —
    // the shape's dimensions are the single source of truth for its size.
    final childParentData = child.parentData! as BoxParentData;
    childParentData.offset = _popoverRect.topLeft + Offset(shapeBorder.dimensions.left, shapeBorder.dimensions.top);

    if (_resolvedEdge != finalEdge) {
      _resolvedEdge = finalEdge;
      markNeedsPaint();
    }

    if (shapeBorder != _shapeBorder) {
      _shapeBorder = shapeBorder;
      _invalidateDecoration();
    }
    _shapePath = shapeBorder.getOuterPath(_popoverRect);
  }

  SBBPopoverShapeBorder _shapeFor(SBBPopoverEdge edge, bool showNotch) =>
      SBBPopoverShapeBorder(placementEdge: edge, showNotch: showNotch);

  final LayerHandle<TransformLayer> _transformLayer = LayerHandle<TransformLayer>();

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scaleAnimation?.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _scaleAnimation?.removeListener(markNeedsPaint);
    // Mirror RenderDecoratedBox: a disposed painter no longer forwards its
    // onChanged notifications, so repaint with a fresh one on reattach.
    _backgroundPainter?.dispose();
    _backgroundPainter = null;
    super.detach();
    markNeedsPaint();
  }

  @override
  void dispose() {
    _backgroundPainter?.dispose();
    _backgroundPainter = null;
    _transformLayer.layer = null;
    super.dispose();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final double scale = _scaleAnimation?.value ?? 1.0;
    if (scale == 1.0) {
      _transformLayer.layer = null;
      _paintPopover(context, offset);
      return;
    }

    // Scale around the center of the popover's target-facing edge (in this
    // render object's local space — pushTransform maps it to the canvas via
    // [offset]), so the popover grows out of / shrinks into its anchor point
    // instead of the top center of the full-overlay-sized box this render
    // object reports as its own size.
    final Offset pivot = switch (_resolvedEdge) {
      SBBPopoverEdge.bottom => _popoverRect.topCenter,
      SBBPopoverEdge.top => _popoverRect.bottomCenter,
      SBBPopoverEdge.right => _popoverRect.centerLeft,
      SBBPopoverEdge.left => _popoverRect.centerRight,
    };
    final Matrix4 transform = Matrix4.identity()
      ..translateByDouble(pivot.dx, pivot.dy, 0, 1)
      ..scaleByDouble(scale, scale, 1, 1)
      ..translateByDouble(-pivot.dx, -pivot.dy, 0, 1);
    _transformLayer.layer = context.pushTransform(
      needsCompositing,
      offset,
      transform,
      _paintPopover,
      oldLayer: _transformLayer.layer,
    );
  }

  void _paintPopover(PaintingContext context, Offset offset) {
    final SBBPopoverShapeBorder? shapeBorder = _shapeBorder;
    if (shapeBorder != null) {
      _decoration ??= ShapeDecoration(color: _color, shape: shapeBorder);
      _backgroundPainter ??= _decoration!.createBoxPainter(markNeedsPaint);
      _backgroundPainter!.paint(
        context.canvas,
        offset + _popoverRect.topLeft,
        ImageConfiguration(size: _popoverRect.size),
      );
    }
    super.paint(context, offset);
  }

  // How far the notch needs to shift along its edge, in the popover box's
  // own coordinate space, to keep pointing at the target's center once the
  // box has been shifted to avoid a viewport-edge collision (see
  // clampDouble(crossPos, ...) above). Only a notch with alignNotchToTarget
  // enabled tracks the target this way.
  double get _notchOffset {
    if (!_showNotch || !_alignNotchToTarget) return 0;
    final bool vertical = _placement.mainAxis == Axis.vertical;
    final double targetCrossCenter = vertical
        ? _targetPosition.dx + (_targetSize.width / 2)
        : _targetPosition.dy + (_targetSize.height / 2);
    final double boxCrossCenter = vertical ? _popoverRect.center.dx : _popoverRect.center.dy;
    return targetCrossCenter - boxCrossCenter;
  }

  // Test against the painted shape, not _popoverRect: the rect includes the
  // reserved notch strip — a transparent band of which only the notch bump
  // is painted — plus the corner pixels outside the rounded corners. Taps
  // there should fall through to the dismiss barrier instead of being
  // swallowed. The rect check is just a cheap pre-filter before the more
  // expensive path containment test.
  //
  // Known limitation, deliberate: while the open/close scale animation is
  // running, hit testing still uses the final (unscaled) geometry — the
  // scale transform is paint-only. The window is 300ms and the mismatch
  // shrinks to zero as the animation settles.
  @override
  bool hitTestSelf(Offset position) => _popoverRect.contains(position) && _shapePath.contains(position);

  // RenderBox.hitTest()'s default implementation gates on
  // `size.contains(position)` before ever calling hitTestChildren/hitTestSelf.
  // This render object's own `size` starts at local (0,0) and only extends
  // downward/rightward (Flutter's convention: a RenderBox's own reported
  // size is always assumed non-negative). For `top` placement, the visible
  // content sits at a *negative* local y if the target is close enough to
  // the top of the screen, outside that [0,0]-size box, so the default gate
  // would reject every tap on it before hitTestChildren/hitTestSelf ever
  // run. Bypass the gate here, mirroring RenderFollowerLayer's own
  // hitTest() override for the identical problem (a child positioned
  // outside this render object's nominal box via an offset it doesn't
  // fully control). hitTestChildren and hitTestSelf still correctly bound
  // the hit region themselves, so this doesn't over-match taps outside the
  // popover.
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
