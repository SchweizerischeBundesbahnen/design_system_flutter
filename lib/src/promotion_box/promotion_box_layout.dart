import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Slots for [PromotionBoxLayout].
enum PromotionBoxSlot { badge, content }

/// A [SlottedMultiChildRenderObjectWidget] that positions the [badge] centered
/// at the top edge of the [content] widget.
///
/// The badge is rendered on top of the content. The overall height of the
/// layout is: `content.height + badge.height / 2`, and the width is the
/// maximum of both children.
class PromotionBoxLayout extends SlottedMultiChildRenderObjectWidget<PromotionBoxSlot, RenderBox> {
  const PromotionBoxLayout({
    required this.badge,
    required this.content,
    super.key,
  });

  final Widget badge;
  final Widget content;

  @override
  Iterable<PromotionBoxSlot> get slots => PromotionBoxSlot.values;

  @override
  Widget? childForSlot(PromotionBoxSlot slot) => switch (slot) {
    PromotionBoxSlot.badge => badge,
    PromotionBoxSlot.content => content,
  };

  @override
  RenderPromotionBoxLayout createRenderObject(BuildContext context) => RenderPromotionBoxLayout();
}

class RenderPromotionBoxLayout extends RenderBox with SlottedContainerRenderObjectMixin<PromotionBoxSlot, RenderBox> {
  RenderBox? get _badge => childForSlot(PromotionBoxSlot.badge);

  RenderBox? get _content => childForSlot(PromotionBoxSlot.content);

  @override
  void performLayout() {
    final badge = _badge;
    final content = _content;

    // Layout badge with loose constraints so it takes its natural size.
    final badgeSize = badge != null ? (badge..layout(constraints.loosen(), parentUsesSize: true)).size : Size.zero;

    final halfBadgeHeight = badgeSize.height / 2.0;

    // Content gets the full width; its top is offset by halfBadgeHeight.
    final contentConstraints = constraints.copyWith(
      minHeight: (constraints.minHeight - halfBadgeHeight).clamp(0.0, double.infinity),
      maxHeight: constraints.maxHeight == double.infinity
          ? double.infinity
          : (constraints.maxHeight - halfBadgeHeight).clamp(0.0, double.infinity),
    );

    final contentSize = content != null ? (content..layout(contentConstraints, parentUsesSize: true)).size : Size.zero;

    final totalWidth = constraints.constrainWidth(math.max(badgeSize.width, contentSize.width));
    final totalHeight = constraints.constrainHeight(halfBadgeHeight + contentSize.height);

    size = Size(totalWidth, totalHeight);

    // Position content below half the badge height.
    if (content != null) {
      (content.parentData as BoxParentData).offset = Offset(0, halfBadgeHeight);
    }

    // Center the badge horizontally at the very top.
    if (badge != null) {
      (badge.parentData as BoxParentData).offset = Offset(
        (totalWidth - badgeSize.width) / 2.0,
        0,
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Paint content first (behind the badge).
    final content = _content;
    if (content != null) {
      final contentOffset = (content.parentData as BoxParentData).offset;
      context.paintChild(content, offset + contentOffset);
    }

    final badge = _badge;
    if (badge != null) {
      final badgeOffset = (badge.parentData as BoxParentData).offset;
      context.paintChild(badge, offset + badgeOffset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // Hit-test badge first (it's on top visually).
    for (final slot in [PromotionBoxSlot.badge, PromotionBoxSlot.content]) {
      final child = childForSlot(slot);
      if (child == null) continue;
      final childOffset = (child.parentData as BoxParentData).offset;
      final isHit = result.addWithPaintOffset(
        offset: childOffset,
        position: position,
        hitTest: (result, transformed) => child.hitTest(result, position: transformed),
      );
      if (isHit) return true;
    }
    return false;
  }
}
