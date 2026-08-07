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
    required this.preferredDirection,
    required this.targetPosition,
    required this.targetSize,
    required this.notch,
    this.offset = Offset.zero,
    this.scaleAnimation,
    super.child,
  });

  final SBBPopoverDirection preferredDirection;

  /// The target's top-left corner in the enclosing [Overlay]'s coordinate
  /// space — which is also this layout's own space, since the popover layout
  /// fills the overlay. NOT a global position: under a nested overlay or a
  /// transformed ancestor the two differ.
  final Offset targetPosition;

  final Size targetSize;
  final SBBPopoverNotch notch;

  /// Scales the popover box around the center of its target-facing edge.
  ///
  /// Applied at paint time inside the render object rather than with a
  /// [ScaleTransition] above it, because this render object fills the whole
  /// overlay — a widget-level transition would pivot around the screen, not
  /// the popover. The resolved popover rect (and thus the correct pivot)
  /// only exists after layout, in here.
  final Animation<double>? scaleAnimation;

  /// Absolute offset between the target and the popover box.
  ///
  /// The y component is defined relative to whichever edge ends up facing
  /// the target: a positive value always pushes the box further away from
  /// the target, so it's automatically inverted when a screen-edge
  /// collision flips the resolved direction. The x component is applied
  /// as-is and composes with any horizontal shift from edge clamping.
  final Offset offset;

  @override
  RenderSBBPopover createRenderObject(BuildContext context) => RenderSBBPopover(
    preferredDirection: preferredDirection,
    targetPosition: targetPosition,
    targetSize: targetSize,
    notch: notch,
    offset: offset,
    scaleAnimation: scaleAnimation,
  );

  @override
  void updateRenderObject(BuildContext context, RenderSBBPopover renderObject) {
    renderObject
      ..preferredDirection = preferredDirection
      ..targetPosition = targetPosition
      ..targetSize = targetSize
      ..notch = notch
      ..offset = offset
      ..scaleAnimation = scaleAnimation;
  }
}

class RenderSBBPopover extends RenderShiftedBox {
  RenderSBBPopover({
    required SBBPopoverDirection preferredDirection,
    required Offset targetPosition,
    required Size targetSize,
    required SBBPopoverNotch notch,
    required Offset offset,
    Animation<double>? scaleAnimation,
    RenderBox? child,
  }) : _preferredDirection = preferredDirection,
       _targetPosition = targetPosition,
       _targetSize = targetSize,
       _notch = notch,
       _offset = offset,
       _scaleAnimation = scaleAnimation,
       super(child);

  // Fixed notch gap reserved on the vertical axis, matching
  // SBBPopoverShapeBorder's internal notchSize.height (not exposed as a
  // public constant there, so duplicated here — the two must stay in sync
  // if the notch size ever changes).
  static const double _notchHeight = 12.0;

  SBBPopoverDirection _preferredDirection;

  set preferredDirection(SBBPopoverDirection value) {
    if (_preferredDirection == value) return;
    _preferredDirection = value;
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

  SBBPopoverNotch _notch;

  set notch(SBBPopoverNotch value) {
    if (_notch == value) return;
    _notch = value;
    markNeedsLayout();
  }

  Offset _offset;

  set offset(Offset value) {
    if (_offset == value) return;
    _offset = value;
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

  /// The direction resolved during the most recent layout pass (after
  /// collision-driven flipping). Exposed for tests/diagnostics.
  SBBPopoverDirection get resolvedDirection => _direction;
  SBBPopoverDirection _direction = SBBPopoverDirection.bottom;

  /// The visible popover's rect, in this render object's own local
  /// coordinate space. Exposed for tests/diagnostics.
  Rect get popoverRect => _popoverRect;
  Rect _popoverRect = Rect.zero;

  // The popover's painted outline in local coordinates. Built once per layout
  // pass (getOuterPath's Path.combine unions are not cheap) and shared by
  // paint() and hitTestSelf().
  Path _shapePath = Path();

  @override
  void performLayout() {
    size = constraints.biggest;

    final RenderBox? child = this.child;
    if (child == null) {
      _popoverRect = Rect.zero;
      _shapePath = Path();
      return;
    }

    // Vertical space available on either side of the target. offset.dy is
    // part of the occupied extent on whichever side gets resolved (a positive
    // value pushes the box further from the target), so it shrinks both
    // budgets up front — a large offset can force a flip just like a tall
    // child can.
    final double spaceBelow = constraints.maxHeight - (_targetPosition.dy + _targetSize.height) - _offset.dy;
    final double spaceAbove = _targetPosition.dy - _offset.dy;

    // Constrain the child to the larger of the two sides instead of the full
    // overlay height, so tall (e.g. scrollable) content sizes to the most
    // space it can possibly get on either side of the target rather than
    // overflowing the screen.
    final childConstraints = BoxConstraints(
      maxWidth: constraints.maxWidth,
      maxHeight: math.max(0, math.max(spaceBelow, spaceAbove) - _reservedNotchHeight),
    );
    child.layout(childConstraints, parentUsesSize: true);

    final overallSize = Size(child.size.width, child.size.height + _reservedNotchHeight);

    // Horizontal positioning
    // Center on the target, nudged by offset.dx, then shift to avoid
    // colliding with viewport edges — the offset is baked into the ideal
    // position before clamping, so it's kept (not dropped) when a
    // horizontal shift happens, it's just clamped along with everything else.
    double finalX = _targetPosition.dx + (_targetSize.width / 2) - (overallSize.width / 2) + _offset.dx;
    finalX = clampDouble(finalX, 0, constraints.maxWidth - overallSize.width);

    // Vertical positioning
    // Keep the preferred side as long as the box fits there; flip only when
    // it doesn't AND the opposite side is actually bigger — flipping onto a
    // smaller side can't help. Because the child was constrained to the
    // larger side's space above, the box is guaranteed to fit after a flip.
    final double preferredSpace = _preferredDirection == .bottom ? spaceBelow : spaceAbove;
    final double oppositeSpace = _preferredDirection == .bottom ? spaceAbove : spaceBelow;
    SBBPopoverDirection finalDirection = _preferredDirection;
    if (overallSize.height > preferredSpace && oppositeSpace > preferredSpace) {
      finalDirection = _preferredDirection == .bottom ? .top : .bottom;
    }

    // offset.dy always pushes the box further away from the target, on
    // whichever edge ends up facing it — so it's added in the bottom branch
    // but subtracted in the top branch. Since the branch is keyed on
    // finalDirection (not _preferredDirection), this sign automatically
    // inverts relative to what was authored whenever a collision flips it.
    double finalY = finalDirection == .bottom
        ? _targetSize.height + _targetPosition.dy + _offset.dy
        : -overallSize.height + _targetPosition.dy - _offset.dy;
    // Safety net for the degenerate cases a flip can't solve (target partly
    // off-screen, or a box taller than either side): keep the box inside the
    // overlay, mirroring the horizontal clamp above. The box may then overlap
    // the target, but it never draws off-screen.
    finalY = clampDouble(finalY, 0, math.max(0, constraints.maxHeight - overallSize.height));

    _popoverRect = Rect.fromLTWH(finalX, finalY, overallSize.width, overallSize.height);

    final double childTopInset = switch (_notch) {
      SBBPopoverNotchNone() => 0,
      SBBPopoverNotchSingle() => finalDirection == .bottom ? _notchHeight : 0,
      SBBPopoverNotchBoth() => _notchHeight,
    };

    final childParentData = child.parentData! as BoxParentData;
    childParentData.offset = Offset(finalX, finalY + childTopInset);

    if (_direction != finalDirection) {
      _direction = finalDirection;
      markNeedsPaint();
    }

    _shapePath = SBBPopoverShapeBorder(
      direction: finalDirection,
      notch: _notch,
      notchOffset: _notchOffset,
    ).getOuterPath(_popoverRect);
  }

  double get _reservedNotchHeight {
    final double reservedNotchHeight = switch (_notch) {
      SBBPopoverNotchNone() => 0,
      SBBPopoverNotchSingle() => _notchHeight,
      SBBPopoverNotchBoth() => _notchHeight * 2,
    };
    return reservedNotchHeight;
  }

  final LayerHandle<TransformLayer> _transformLayer = LayerHandle<TransformLayer>();

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scaleAnimation?.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _scaleAnimation?.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void dispose() {
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
    final Offset pivot = _direction == .bottom ? _popoverRect.topCenter : _popoverRect.bottomCenter;
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
    context.canvas.drawPath(_shapePath.shift(offset), Paint()..color = SBBColors.milk);
    super.paint(context, offset);
  }

  // How far the notch needs to shift horizontally, in the popover box's own
  // coordinate space, to keep pointing at the target's center once the box
  // has been shifted sideways to avoid a screen-edge collision (see
  // clampDouble(finalX, ...) above). Only SBBPopoverNotchSingle with
  // alignWithTarget enabled tracks the target this way — SBBPopoverNotchBoth
  // is always a static, non-tracking shape.
  double get _notchOffset {
    final notch = _notch;
    if (notch is! SBBPopoverNotchSingle || !notch.alignWithTarget) return 0;
    final double targetCenterX = _targetPosition.dx + (_targetSize.width / 2);
    return targetCenterX - _popoverRect.center.dx;
  }

  // Test against the painted shape, not _popoverRect: the rect includes the
  // reserved notch strip — a full-width transparent band of which only the
  // notch bump is painted — plus the corner pixels outside the rounded
  // corners. Taps there should fall through to the dismiss barrier instead
  // of being swallowed. The rect check is just a cheap pre-filter before the
  // more expensive path containment test.
  @override
  bool hitTestSelf(Offset position) => _popoverRect.contains(position) && _shapePath.contains(position);

  // RenderBox.hitTest()'s default implementation gates on
  // `size.contains(position)` before ever calling hitTestChildren/hitTestSelf.
  // This render object's own `size` starts at local (0,0) and only extends
  // downward/rightward (Flutter's convention: a RenderBox's own reported
  // size is always assumed non-negative). For `top` direction, the visible
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
