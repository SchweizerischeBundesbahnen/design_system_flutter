import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_shape.dart';

/// Positions and paints an [SBBPopover]'s content relative to its trigger.
class SBBPopoverLayout extends SingleChildRenderObjectWidget {
  const SBBPopoverLayout({
    super.key,
    required this.preferredDirection,
    required this.triggerGlobalPosition,
    required this.triggerSize,
    required this.notch,
    super.child,
  });

  final SBBPopoverDirection preferredDirection;
  final Offset triggerGlobalPosition;
  final Size triggerSize;
  final SBBPopoverNotch notch;

  @override
  RenderSBBPopover createRenderObject(BuildContext context) => RenderSBBPopover(
    preferredDirection: preferredDirection,
    triggerGlobalPosition: triggerGlobalPosition,
    triggerSize: triggerSize,
    notch: notch,
  );

  @override
  void updateRenderObject(BuildContext context, RenderSBBPopover renderObject) {
    renderObject
      ..preferredDirection = preferredDirection
      ..triggerGlobalPosition = triggerGlobalPosition
      ..triggerSize = triggerSize
      ..notch = notch;
  }
}

class RenderSBBPopover extends RenderShiftedBox {
  RenderSBBPopover({
    required SBBPopoverDirection preferredDirection,
    required Offset triggerGlobalPosition,
    required Size triggerSize,
    required SBBPopoverNotch notch,
    RenderBox? child,
  }) : _preferredDirection = preferredDirection,
       _triggerGlobalPosition = triggerGlobalPosition,
       _triggerSize = triggerSize,
       _notch = notch,
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

  Offset _triggerGlobalPosition;

  set triggerGlobalPosition(Offset value) {
    if (_triggerGlobalPosition == value) return;
    _triggerGlobalPosition = value;
    markNeedsLayout();
  }

  Size _triggerSize;

  set triggerSize(Size value) {
    if (_triggerSize == value) return;
    _triggerSize = value;
    markNeedsLayout();
  }

  SBBPopoverNotch _notch;

  set notch(SBBPopoverNotch value) {
    if (_notch == value) return;
    _notch = value;
    markNeedsLayout();
  }

  /// The direction resolved during the most recent layout pass (after
  /// collision-driven flipping). Exposed for tests/diagnostics.
  SBBPopoverDirection get resolvedDirection => _direction;
  SBBPopoverDirection _direction = SBBPopoverDirection.bottom;

  /// The visible popover's rect, in this render object's own local
  /// coordinate space. Exposed for tests/diagnostics.
  Rect get popoverRect => _popoverRect;
  Rect _popoverRect = Rect.zero;

  @override
  void performLayout() {
    size = constraints.biggest;

    final RenderBox? child = this.child;
    if (child == null) {
      _popoverRect = Rect.zero;
      return;
    }

    final childConstraints = BoxConstraints(
      maxWidth: constraints.maxWidth,
      maxHeight: constraints.maxHeight - _reservedNotchHeight,
    );
    child.layout(childConstraints, parentUsesSize: true);

    final overallSize = Size(child.size.width, child.size.height + _reservedNotchHeight);

    // Horizontal positioning
    // Shift to avoid colliding with view port edges
    double finalX = _triggerGlobalPosition.dx + (_triggerSize.width / 2) - (overallSize.width / 2);
    finalX = clampDouble(finalX, 0, constraints.maxWidth - overallSize.width);

    // Vertical positioning
    // Flip vertically on collision
    SBBPopoverDirection finalDirection = _preferredDirection;
    if (_preferredDirection == .bottom) {
      if (_triggerGlobalPosition.dy + _triggerSize.height + overallSize.height > constraints.maxHeight) {
        finalDirection = .top;
      }
    } else if (_preferredDirection == .top) {
      if (_triggerGlobalPosition.dy - overallSize.height < 0) {
        finalDirection = .bottom;
      }
    }

    final double finalY = finalDirection == .bottom
        ? _triggerSize.height + _triggerGlobalPosition.dy
        : -overallSize.height + _triggerGlobalPosition.dy;

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
  }

  double get _reservedNotchHeight {
    final double reservedNotchHeight = switch (_notch) {
      SBBPopoverNotchNone() => 0,
      SBBPopoverNotchSingle() => _notchHeight,
      SBBPopoverNotchBoth() => _notchHeight * 2,
    };
    return reservedNotchHeight;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final rect = _popoverRect.shift(offset);
    final path = SBBPopoverShapeBorder(
      direction: _direction,
      notch: _notch,
      notchOffset: _notchOffset,
    ).getOuterPath(rect);
    context.canvas.drawPath(path, Paint()..color = SBBColors.milk);
    super.paint(context, offset);
  }

  // How far the notch needs to shift horizontally, in the popover box's own
  // coordinate space, to keep pointing at the trigger's center once the box
  // has been shifted sideways to avoid a screen-edge collision (see
  // clampDouble(finalX, ...) above). Only SBBPopoverNotchSingle with
  // alignWithTarget enabled tracks the trigger this way — SBBPopoverNotchBoth
  // is always a static, non-tracking shape.
  double get _notchOffset {
    final notch = _notch;
    if (notch is! SBBPopoverNotchSingle || !notch.alignWithTarget) return 0;
    final double triggerCenterX = _triggerGlobalPosition.dx + (_triggerSize.width / 2);
    return triggerCenterX - _popoverRect.center.dx;
  }

  @override
  bool hitTestSelf(Offset position) => _popoverRect.contains(position);

  // RenderBox.hitTest()'s default implementation gates on
  // `size.contains(position)` before ever calling hitTestChildren/hitTestSelf.
  // This render object's own `size` starts at local (0,0) and only extends
  // downward/rightward (Flutter's convention: a RenderBox's own reported
  // size is always assumed non-negative). For `top` direction, the visible
  // content sits at a *negative* local y if the trigger is close enough to
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
