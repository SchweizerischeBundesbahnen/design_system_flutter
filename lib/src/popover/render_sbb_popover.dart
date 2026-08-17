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

  final SBBPopoverPlacement placement;

  final Offset targetPosition;

  final Size targetSize;

  final bool showNotch;

  final bool alignNotchToTarget;

  final Color color;

  final BoxConstraints popoverConstraints;

  final Animation<double>? scaleAnimation;

  final double sideOffset;

  final double alignmentOffset;

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

  SBBPopoverEdge _resolvedEdge = SBBPopoverEdge.bottom;

  Rect _popoverRect = Rect.zero;

  // The popover's painted outline in local coordinates. Built once per layout
  // pass (getOuterPath's Path.combine unions are not cheap) and used by
  // hitTestSelf().
  Path _shapePath = Path();

  // The shape border resolved during the most recent layout pass — the
  // resolved edge and notch offset that feed it only exist post-layout,
  // which is why the surface can't simply be a ShapeDecoration on the child
  // in the widget layer.
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
  // axis. The algorithm is written once; only the transposition into
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

    final bool vertical = _placement.mainAxis == .vertical;

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
    final double maxAvailableSpaceOnMainAxis = math.max(0, math.max(spaceAfter, spaceBefore));
    final double maxAvailableSpaceOnCrossAxis = math.max(0, viewportCrossMax - viewportCrossMin);
    final BoxConstraints available = BoxConstraints(
      maxWidth: vertical ? maxAvailableSpaceOnCrossAxis : maxAvailableSpaceOnMainAxis,
      maxHeight: vertical ? maxAvailableSpaceOnMainAxis : maxAvailableSpaceOnCrossAxis,
    );

    // constrain child always with hypothetical notch
    final BoxConstraints childConstraints = _popoverConstraints
        .enforce(available)
        .deflate(_shapeFor(_placement.edge, _showNotch).dimensions);
    child.layout(childConstraints, parentUsesSize: true);
    final double childCrossAxisExtent = vertical ? child.size.width : child.size.height;

    // but drop notch entirely if cannot fit because cross side too small
    // ensures child never overflows
    final bool effectiveShowNotch = _showNotch && childCrossAxisExtent >= SBBPopoverShapeBorder.minExtentForNotch;
    final double childMainAxisExtent =
        (vertical ? child.size.height : child.size.width) +
        _shapeFor(_placement.edge, effectiveShowNotch).dimensions.along(_placement.mainAxis);

    // Cross-axis position (the shift)
    // The ideal position comes from the placement's alignment (start/end are
    // physical: left/top and right/bottom), nudged by alignmentOffset, then
    // shifted to avoid colliding with viewport edges.
    double childCrossPosition =
        switch (_placement.crossAxisAlignment) {
          SBBPopoverAlignment.start => targetCrossStart,
          SBBPopoverAlignment.center => (targetCrossStart + targetCrossEnd - childCrossAxisExtent) / 2,
          SBBPopoverAlignment.end => targetCrossEnd - childCrossAxisExtent,
        } +
        _alignmentOffset;
    childCrossPosition = clampDouble(
      childCrossPosition,
      viewportCrossMin,
      math.max(viewportCrossMin, viewportCrossMax - childCrossAxisExtent),
    );

    // Main-axis position (the flip)
    // Keep the preferred edge as long as the child fits there; flip only when it doesn't.
    // Because the child was constrained to the larger side's space above,
    // the child is guaranteed to fit after a flip.
    final bool preferAfter = _placement.edge == SBBPopoverEdge.bottom || _placement.edge == SBBPopoverEdge.right;
    final double preferredSpace = preferAfter ? spaceAfter : spaceBefore;
    final double oppositeSpace = preferAfter ? spaceBefore : spaceAfter;
    SBBPopoverEdge finalEdge = _placement.edge;
    if (childMainAxisExtent > preferredSpace && oppositeSpace > preferredSpace) {
      finalEdge = finalEdge.opposite;
    }

    // sideOffset always pushes the box further away from the target
    final bool finalAfter = finalEdge == SBBPopoverEdge.bottom || finalEdge == SBBPopoverEdge.right;
    double mainPos = finalAfter ? targetMainEnd + _sideOffset : targetMainStart - _sideOffset - childMainAxisExtent;
    mainPos = clampDouble(mainPos, viewportMainMin, math.max(viewportMainMin, viewportMainMax - childMainAxisExtent));

    _popoverRect = vertical
        ? Rect.fromLTWH(childCrossPosition, mainPos, childCrossAxisExtent, childMainAxisExtent)
        : Rect.fromLTWH(mainPos, childCrossPosition, childMainAxisExtent, childCrossAxisExtent);

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

    // Scale around the center of the popover's target-facing edge, so the popover
    // grows out of / shrinks into its anchor point.
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
  // own coordinate space, to keep pointing at the target. Only once the
  // center of the popover sits beside the target on the cross axis, the notch will track the target.
  double get _notchOffset {
    if (!_showNotch || !_alignNotchToTarget) return 0;

    final bool vertical = _placement.mainAxis == .vertical;
    final double targetCrossStart = vertical ? _targetPosition.dx : _targetPosition.dy;
    final double targetCrossEnd = targetCrossStart + (vertical ? _targetSize.width : _targetSize.height);
    final double popoverCrossStart = vertical ? _popoverRect.left : _popoverRect.top;
    final double popoverCrossEnd = vertical ? _popoverRect.right : _popoverRect.bottom;
    final double popoverCrossCenter = (popoverCrossStart + popoverCrossEnd) / 2.0;
    final bool shouldShiftNotch = popoverCrossCenter > targetCrossEnd || popoverCrossCenter < targetCrossStart;
    if (!shouldShiftNotch) return 0;

    final double targetCrossCenter = (targetCrossStart + targetCrossEnd) / 2;
    return targetCrossCenter - popoverCrossCenter;
  }

  @override
  bool hitTestSelf(Offset position) => _popoverRect.contains(position) && _shapePath.contains(position);

  // RenderBox.hitTest()'s default implementation gates on
  // `size.contains(position)` before ever calling hitTestChildren/hitTestSelf.
  // This render object's own `size` starts at local (0,0) and only extends
  // downward/rightward. For `top` placement, the visible
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
