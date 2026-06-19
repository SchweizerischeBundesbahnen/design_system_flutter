import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

/// The default badge content for a SBB Promotion Box.
///
/// Use this widget in conjunction with the [SBBPromotionBox].
///
/// Provide either [label] for custom content or [labelText] for text-only content with
/// standard styling. These parameters are mutually exclusive.
///
/// The badge features a pill-shaped design with a halo effect on the upper half,
/// designed to be positioned centered at the top edge of the promotion box.
///
/// ## Sample code
///
/// ```dart
/// SBBPromotionBox(
///   badge: SBBPromotionBoxBadge(
///     labelText: 'NEW',
///   ),
///   titleText: 'Special Offer',
/// )
/// ```
///
/// ## Customization
///
/// Use [style] to customize appearance of the badge:
///
/// ```dart
/// SBBPromotionBoxBadge(
///   labelText: 'PREMIUM',
///   style: SBBPromotionBoxBadgeStyle(
///     foregroundColor: Colors.white,
///     backgroundColor: Colors.blue,
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBPromotionBox], for a way to use this widget.
///  * [SBBPromotionBoxBadgeStyle], for customizing the appearance.
///  * [Design Guidelines](https://digital.sbb.ch/en/design-system/mobile/components/promotion-box/)
class SBBPromotionBoxBadge extends StatelessWidget {
  const SBBPromotionBoxBadge({
    this.labelText,
    this.label,
    this.style,
    super.key,
  }) : assert(labelText != null || label != null, 'One of labelText or label must be non null!'),
       assert(labelText == null || label == null, 'Cannot set both labelText and label!');

  /// Text string to display as the badge's label using the standard design.
  ///
  /// The text is clamped to a single line with ellipsis overflow.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed as the badge's label.
  ///
  /// For simple text labels, use [labelText] instead.
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// Customizes this badge's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBPromotionBoxThemeData.badgeStyle] of the theme found in [context].
  final SBBPromotionBoxBadgeStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbPromotionBoxTheme.badgeStyle!;
    final effectiveStyle = themeStyle.merge(style);

    final resolvedTextStyle = effectiveStyle.textStyle!.copyWith(color: effectiveStyle.foregroundColor);
    final resolvedLabel = addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.foregroundColor,
      textStyle: resolvedTextStyle,
      child: label ?? Text(labelText!, maxLines: 1),
    );

    return _PromotionBoxBadgeRenderObjectWidget(
      color: effectiveStyle.haloColor!,
      spread: SBBPromotionBoxBadgeStyle.haloSpreadRadius,
      child: Container(
        padding: effectiveStyle.padding!,
        decoration: ShapeDecoration(
          shape: StadiumBorder(side: BorderSide(color: effectiveStyle.borderColor!)),
          color: effectiveStyle.backgroundColor,
        ),
        child: resolvedLabel,
      ),
    );
  }
}

/// A [SingleChildRenderObjectWidget] that expands its layout size by [spread]
/// on all sides to account for the halo painted around the child, and paints
/// the halo behind the child ONLY ON THE UPPER HALF.
class _PromotionBoxBadgeRenderObjectWidget extends SingleChildRenderObjectWidget {
  const _PromotionBoxBadgeRenderObjectWidget({
    required this.color,
    required this.spread,
    super.child,
  });

  final Color color;
  final double spread;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderPromotionBoxBadge(color: color, spread: spread);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _RenderPromotionBoxBadge)
      ..color = color
      ..spread = spread;
  }
}

class _RenderPromotionBoxBadge extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  _RenderPromotionBoxBadge({required Color color, required double spread}) : _color = color, _spread = spread;

  Color _color;

  Color get color => _color;

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  double _spread;

  double get spread => _spread;

  set spread(double value) {
    if (_spread == value) return;
    _spread = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = BoxParentData();
    }
  }

  @override
  void performLayout() {
    final child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }

    // Let the child lay itself out without the halo inflation.
    final innerConstraints = constraints.deflate(EdgeInsets.all(_spread));
    child.layout(innerConstraints, parentUsesSize: true);

    // Offset the child so it sits centered inside inflated box.
    final childParentData = child.parentData! as BoxParentData;
    childParentData.offset = Offset(_spread, _spread);

    size = constraints.constrain(
      Size(
        child.size.width + _spread * 2,
        child.size.height + _spread * 2,
      ),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) return;

    final childParentData = child.parentData! as BoxParentData;
    // The child's rect in local coordinates.
    final childRect = childParentData.offset & child.size;

    // The halo is the child rect inflated by spread on all sides.
    final haloRect = childRect.inflate(_spread);
    final haloRRect = RRect.fromRectAndRadius(haloRect, Radius.circular(haloRect.shortestSide / 2.0));

    final canvas = context.canvas;
    canvas.save();
    // Clip to the upper half of the halo rect so the halo only shows above the badge center line.
    canvas.clipRect(Rect.fromPoints(haloRect.topLeft, haloRect.centerRight).shift(offset));
    canvas.drawRRect(
      haloRRect.shift(offset),
      Paint()
        ..color = _color
        ..style = PaintingStyle.fill,
    );
    canvas.restore();

    // Paint the child on top.
    context.paintChild(child, offset + childParentData.offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = this.child;
    if (child == null) return false;
    final childParentData = child.parentData! as BoxParentData;
    return result.addWithPaintOffset(
      offset: childParentData.offset,
      position: position,
      hitTest: (result, transformed) => child.hitTest(result, position: transformed),
    );
  }
}
