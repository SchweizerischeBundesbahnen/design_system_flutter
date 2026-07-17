// Design contract for RenderSBBPopover — Phase 2 (see tasks/plan.md).
// Decision recorded 2026-07-17, signed off by human: full custom paint, no
// elevation/shadow needed, content wrapped in Material(transparency) only
// for ink splashes.
//
// ## Why this exists
// SBBPopoverLayoutDelegate resolves `direction` (flip on collision) during
// layout, but Material(shape: SBBPopoverShapeBorder) needed `direction` at
// build time — one frame behind, since Flutter disallows a synchronous
// rebuild mid-layout. That gap was the one-frame notch-flash bug. A custom
// RenderObject closes it because its own paint() runs after its own
// performLayout() in the same frame, with no widget rebuild involved.
//
// ## Own size vs. child position (corrected from the original Task 2 draft)
// RenderSBBPopover's own size is `constraints.biggest` — the full space the
// Stack gives it — NOT the popover's visible size. This mirrors exactly why
// the old CustomSingleChildLayout worked this way: CompositedTransformFollower's
// `offset` is a fixed value set once by SBBAnchoredOverlayBuilder and cannot
// dynamically shift up/down based on a collision only known deep inside
// SBBPopover's own subtree. The only way to get dynamic above/below
// flipping under a paint-time-only transform is to anchor a full-space box
// at the trigger's position (via the follower) and position the actual
// visible content freely *within* that space via child offset — which is
// what this render object does, replacing CustomSingleChildLayout +
// SBBPopoverLayoutDelegate's role one-for-one.
//
// hitTestSelf is overridden to match the popover's visible rect (not the
// full box), so taps on the decorative chrome (padding/notch area, outside
// the content child's own bounds) still count as "hit the popover" and
// don't fall through to the barrier behind it — mirroring Material's
// implicit opaque-hit-test behavior in the old implementation. Without this,
// tapping the chrome (not the content) would incorrectly dismiss the
// popover via the barrier GestureDetector in the Stack behind it.
//
// ## Full replacement, not a partial keep
// This replaces CustomSingleChildLayout, SBBPopoverLayoutDelegate,
// SBBLayoutResult, and the ValueNotifier/ValueListenableBuilder plumbing in
// SBBPopover entirely (deleted in Task 5). SBBPopoverShapeBorder is retired
// as a ShapeBorder/Material `shape` — its path-building math will be
// extracted and reused in Task 4 (paint() currently draws a plain rounded
// rect as an interim placeholder).

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Positions and paints an [SBBPopover]'s content relative to its trigger.
///
/// Replaces `CustomSingleChildLayout` + `SBBPopoverLayoutDelegate`. See the
/// file-level contract above for why this render object's own size spans
/// the full available space rather than just the popover's visible size.
class SBBPopoverLayout extends SingleChildRenderObjectWidget {
  const SBBPopoverLayout({
    super.key,
    required this.preferredDirection,
    required this.safeAreaInsets,
    required this.triggerGlobalPosition,
    required this.triggerSize,
    required this.screenSize,
    super.child,
  });

  final SBBPopoverDirection preferredDirection;
  final EdgeInsets safeAreaInsets;
  final Offset triggerGlobalPosition;
  final Size triggerSize;
  final Size screenSize;

  @override
  RenderSBBPopover createRenderObject(BuildContext context) => RenderSBBPopover(
    preferredDirection: preferredDirection,
    safeAreaInsets: safeAreaInsets,
    triggerGlobalPosition: triggerGlobalPosition,
    triggerSize: triggerSize,
    screenSize: screenSize,
  );

  @override
  void updateRenderObject(BuildContext context, RenderSBBPopover renderObject) {
    renderObject
      ..preferredDirection = preferredDirection
      ..safeAreaInsets = safeAreaInsets
      ..triggerGlobalPosition = triggerGlobalPosition
      ..triggerSize = triggerSize
      ..screenSize = screenSize;
  }
}

class RenderSBBPopover extends RenderShiftedBox {
  RenderSBBPopover({
    required SBBPopoverDirection preferredDirection,
    required EdgeInsets safeAreaInsets,
    required Offset triggerGlobalPosition,
    required Size triggerSize,
    required Size screenSize,
    RenderBox? child,
  }) : _preferredDirection = preferredDirection,
       _safeAreaInsets = safeAreaInsets,
       _triggerGlobalPosition = triggerGlobalPosition,
       _triggerSize = triggerSize,
       _screenSize = screenSize,
       super(child);

  // Fixed notch gap reserved on the vertical axis, matching
  // SBBPopoverShapeBorder's notchSize.height. Task 4 will source this from
  // the shared path-building helper instead of duplicating it here.
  static const double _notchHeight = 12.0;
  static const double _cornerRadius = 16.0;

  SBBPopoverDirection _preferredDirection;
  set preferredDirection(SBBPopoverDirection value) {
    if (_preferredDirection == value) return;
    _preferredDirection = value;
    markNeedsLayout();
  }

  EdgeInsets _safeAreaInsets;
  set safeAreaInsets(EdgeInsets value) {
    if (_safeAreaInsets == value) return;
    _safeAreaInsets = value;
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

  Size _screenSize;
  set screenSize(Size value) {
    if (_screenSize == value) return;
    _screenSize = value;
    markNeedsLayout();
  }

  /// The direction resolved during the most recent layout pass (after
  /// collision-driven flipping). Exposed for tests/diagnostics.
  SBBPopoverDirection get resolvedDirection => _direction;
  SBBPopoverDirection _direction = SBBPopoverDirection.bottom;

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
      maxWidth: _screenSize.width - _safeAreaInsets.horizontal,
      maxHeight: _screenSize.height - _safeAreaInsets.vertical - _notchHeight,
    );
    child.layout(childConstraints, parentUsesSize: true);

    final overallSize = Size(child.size.width, child.size.height + _notchHeight);

    // Flip-on-collision, ported verbatim from
    // SBBPopoverLayoutDelegate.getPositionForChild.
    SBBPopoverDirection finalDirection = _preferredDirection;
    if (_preferredDirection == SBBPopoverDirection.bottom) {
      if (_triggerGlobalPosition.dy + _triggerSize.height + overallSize.height >
          _screenSize.height - _safeAreaInsets.bottom) {
        finalDirection = SBBPopoverDirection.top;
      }
    } else if (_preferredDirection == SBBPopoverDirection.top) {
      if (_triggerGlobalPosition.dy - overallSize.height < _safeAreaInsets.top) {
        finalDirection = SBBPopoverDirection.bottom;
      }
    }

    // Horizontal centering + edge-shift, ported verbatim.
    double idealX = (_triggerSize.width / 2) - (overallSize.width / 2);
    final double globalIdealX = _triggerGlobalPosition.dx + idealX;
    if (globalIdealX < _safeAreaInsets.left) {
      idealX += (_safeAreaInsets.left - globalIdealX);
    } else if (globalIdealX + overallSize.width > _screenSize.width - _safeAreaInsets.right) {
      idealX -= (globalIdealX + overallSize.width) - (_screenSize.width - _safeAreaInsets.right);
    }

    final double boxY = finalDirection == SBBPopoverDirection.bottom
        ? _triggerSize.height
        : -overallSize.height;

    _popoverRect = Rect.fromLTWH(idealX, boxY, overallSize.width, overallSize.height);

    final childParentData = child.parentData! as BoxParentData;
    childParentData.offset = Offset(
      idealX,
      boxY + (finalDirection == SBBPopoverDirection.bottom ? _notchHeight : 0),
    );

    if (_direction != finalDirection) {
      _direction = finalDirection;
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Interim background: plain rounded rect, no notch. Task 4 replaces this
    // with the full notch path ported from SBBPopoverShapeBorder.
    final paint = Paint()..color = SBBColors.milk;
    final rect = _popoverRect.shift(offset);
    context.canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(_cornerRadius)), paint);
    super.paint(context, offset);
  }

  @override
  bool hitTestSelf(Offset position) => _popoverRect.contains(position);
}
