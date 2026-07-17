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
// ## No CompositedTransformFollower/Target — absolute positioning throughout
// SBBAnchoredOverlayBuilder no longer wraps the trigger/overlay content in
// CompositedTransformTarget/CompositedTransformFollower. That mechanism was
// removed after discovering it doesn't reliably work in the first place:
// RenderFollowerLayer.getCurrentTransform() returns `layer?.getLastTransform()
// ?? Matrix4.identity()` — i.e. it silently falls back to a no-op transform
// unless a real FollowerLayer has already been through actual engine
// compositing, which isn't reliable (observed: never happens in the widget
// test environment, even after pumpAndSettle + runAsync). Rather than depend
// on that, positioning is now fully absolute: RenderSBBPopover's own local
// (0,0) is just the overlay's origin (~screen (0,0)), and every coordinate
// (x, boxY, _popoverRect) is computed directly from `triggerGlobalPosition`,
// with no paint-time transform involved anywhere.
//
// ## Own size vs. child position
// RenderSBBPopover's own size is still `constraints.biggest` — the full
// available space — NOT the popover's visible size, even without the
// follower. This is because the flip/shift decision depends on the child's
// *measured* size, which is only known after layout — a plain `Positioned`
// widget can't express "lay out my child, then decide where to place it
// based on the result." A custom RenderObject can, but only if its own box
// is large enough to place the visible content anywhere within it (above or
// below the trigger, shifted left or right) — hence the full-space box, with
// the actual visible content positioned via child offset within it.
//
// hitTestSelf is overridden to match the popover's visible rect (not the
// full box), so taps on the decorative chrome (padding/notch area, outside
// the content child's own bounds) still count as "hit the popover" and
// don't fall through to the barrier behind it — mirroring Material's
// implicit opaque-hit-test behavior in the old implementation. Without this,
// tapping the chrome (not the content) would incorrectly dismiss the
// popover via the barrier GestureDetector in the Stack behind it.
//
// hitTest() is overridden to bypass RenderBox's default `size.contains
// (position)` gate: for `top` direction, content can sit outside this
// render object's own [0,0]-anchored box in local terms if the trigger is
// near the top of the screen (boxY = triggerGlobalPosition.dy -
// overallSize.height can still go negative there) — see the Known Issues
// entry in tasks/plan.md for the original diagnosis of this class of bug.
//
// ## Full replacement, not a partial keep
// This replaces CustomSingleChildLayout, SBBPopoverLayoutDelegate,
// SBBLayoutResult, and the ValueNotifier/ValueListenableBuilder plumbing in
// SBBPopover entirely (deleted in Task 5). SBBPopoverShapeBorder is retired
// as a ShapeBorder/Material `shape`, but its existing `getOuterPath` is
// reused as-is (called directly, not through Material) — no need to extract
// a separate helper, since ShapeBorder.getOuterPath is already just a plain
// callable method that happens to also satisfy the ShapeBorder interface.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_shape.dart';

/// Positions and paints an [SBBPopover2]'s content relative to its trigger.
///
/// Replaces `CustomSingleChildLayout` + `SBBPopoverLayoutDelegate`. See the
/// file-level contract above for why this render object's own size spans
/// the full available space rather than just the popover's visible size.
class SBBPopoverLayout extends SingleChildRenderObjectWidget {
  const SBBPopoverLayout({
    super.key,
    required this.preferredDirection,
    required this.triggerGlobalPosition,
    required this.triggerSize,
    super.child,
  });

  final SBBPopoverDirection preferredDirection;
  final Offset triggerGlobalPosition;
  final Size triggerSize;

  @override
  RenderSBBPopover createRenderObject(BuildContext context) => RenderSBBPopover(
    preferredDirection: preferredDirection,
    triggerGlobalPosition: triggerGlobalPosition,
    triggerSize: triggerSize,
  );

  @override
  void updateRenderObject(BuildContext context, RenderSBBPopover renderObject) {
    renderObject
      ..preferredDirection = preferredDirection
      ..triggerGlobalPosition = triggerGlobalPosition
      ..triggerSize = triggerSize;
  }
}

class RenderSBBPopover extends RenderShiftedBox {
  RenderSBBPopover({
    required SBBPopoverDirection preferredDirection,
    required Offset triggerGlobalPosition,
    required Size triggerSize,
    RenderBox? child,
  }) : _preferredDirection = preferredDirection,
       _triggerGlobalPosition = triggerGlobalPosition,
       _triggerSize = triggerSize,
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

    // Bounded by this render object's own incoming constraints (effectively
    // the screen/overlay size) instead of an explicit screenSize param.
    // safeAreaInsets is dropped for now (treated as zero) — see tasks/plan.md
    // for the "reimplement cleanly later" note on both.
    final childConstraints = BoxConstraints(
      maxWidth: constraints.maxWidth,
      maxHeight: constraints.maxHeight - _notchHeight,
    );
    child.layout(childConstraints, parentUsesSize: true);

    final overallSize = Size(child.size.width, child.size.height + _notchHeight);

    // Flip-on-collision, ported verbatim from
    // SBBPopoverLayoutDelegate.getPositionForChild.
    SBBPopoverDirection finalDirection = _preferredDirection;
    if (_preferredDirection == SBBPopoverDirection.bottom) {
      if (_triggerGlobalPosition.dy + _triggerSize.height + overallSize.height > constraints.maxHeight) {
        finalDirection = SBBPopoverDirection.top;
      }
    } else if (_preferredDirection == SBBPopoverDirection.top) {
      if (_triggerGlobalPosition.dy - overallSize.height < 0) {
        finalDirection = SBBPopoverDirection.bottom;
      }
    }

    // Horizontal centering + edge-shift, in absolute (screen) coordinates:
    // this render object's own local (0,0) is the overlay's origin (no
    // CompositedTransformFollower involved anymore), so every coordinate
    // here must be absolute, same as boxY below.
    double x = _triggerGlobalPosition.dx + (_triggerSize.width / 2) - (overallSize.width / 2);
    x = clampDouble(x, 0, constraints.maxWidth - overallSize.width);

    final double boxY = finalDirection == SBBPopoverDirection.bottom
        ? _triggerSize.height + _triggerGlobalPosition.dy
        : -overallSize.height + _triggerGlobalPosition.dy;

    _popoverRect = Rect.fromLTWH(x, boxY, overallSize.width, overallSize.height);

    final childParentData = child.parentData! as BoxParentData;
    childParentData.offset = Offset(
      x,
      boxY + (finalDirection == SBBPopoverDirection.bottom ? _notchHeight : 0),
    );

    if (_direction != finalDirection) {
      _direction = finalDirection;
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final rect = _popoverRect.shift(offset);
    final path = SBBPopoverShapeBorder(direction: _direction).getOuterPath(rect);
    context.canvas.drawPath(path, Paint()..color = SBBColors.milk);
    super.paint(context, offset);
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
