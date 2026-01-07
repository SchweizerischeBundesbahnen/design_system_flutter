import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef _Sizes = ({double titleY, BoxConstraints textConstraints, Size tileSize});
typedef _PositionChild = void Function(RenderBox child, Offset offset);

enum _SBBListItemSlot { leading, title, subtitle, trailing }

class SBBListItemV5 extends StatelessWidget {
  const SBBListItemV5({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.leadingIconData,
    this.titleText,
    this.subtitleText,
    this.trailingIconData,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    this.statesController,
  });

  final Widget? leading;

  final Widget? title;

  final Widget? subtitle;

  final Widget? trailing;

  final IconData? leadingIconData;

  final String? titleText;

  final String? subtitleText;

  final IconData? trailingIconData;

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  final bool enabled;

  final EdgeInsetsGeometry padding;

  final MaterialStatesController? statesController;

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedPadding = padding.resolve(textDirection);

    // Build actual widgets from convenience parameters
    Widget? leadingWidget = leading;
    if (leadingWidget == null && leadingIconData != null) {
      leadingWidget = Icon(leadingIconData);
    }

    Widget? titleWidget = title;
    if (titleWidget == null && titleText != null) {
      titleWidget = Text(titleText!);
    }

    Widget? subtitleWidget = subtitle;
    if (subtitleWidget == null && subtitleText != null) {
      subtitleWidget = Text(subtitleText!);
    }

    Widget? trailingWidget = trailing;
    if (trailingWidget == null && trailingIconData != null) {
      trailingWidget = Icon(trailingIconData);
    }

    return InkWell(
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      statesController: statesController,
      child: Padding(
        padding: resolvedPadding,
        child: _SBBListItemV5(
          leading: leadingWidget,
          title: titleWidget ?? const SizedBox(),
          subtitle: subtitleWidget,
          trailing: trailingWidget,
        ),
      ),
    );
  }
}

class _SBBListItemV5 extends SlottedMultiChildRenderObjectWidget<_SBBListItemSlot, RenderBox> {
  const _SBBListItemV5({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  @override
  Iterable<_SBBListItemSlot> get slots => _SBBListItemSlot.values;

  @override
  Widget? childForSlot(_SBBListItemSlot slot) {
    return switch (slot) {
      _SBBListItemSlot.leading => leading,
      _SBBListItemSlot.title => title,
      _SBBListItemSlot.subtitle => subtitle,
      _SBBListItemSlot.trailing => trailing,
    };
  }

  @override
  _RenderSBBListItemV5 createRenderObject(BuildContext context) {
    return _RenderSBBListItemV5();
  }
}

class _RenderSBBListItemV5 extends RenderBox with SlottedContainerRenderObjectMixin<_SBBListItemSlot, RenderBox> {
  _RenderSBBListItemV5();

  static const double _trailingHorizontalGapWidth = 16.0;

  static const double _leadingHorizontalGapWidth = 8.0;

  static const double _subtitleVerticalGapHeight = 4.0;

  RenderBox? get leading => childForSlot(_SBBListItemSlot.leading);

  RenderBox get title => childForSlot(_SBBListItemSlot.title)!;

  RenderBox? get subtitle => childForSlot(_SBBListItemSlot.subtitle);

  RenderBox? get trailing => childForSlot(_SBBListItemSlot.trailing);

  @override
  Iterable<RenderBox> get children {
    final RenderBox? title = childForSlot(_SBBListItemSlot.title);
    return <RenderBox>[?leading, ?title, ?subtitle, ?trailing];
  }

  @override
  bool get sizedByParent => false;

  static double _minWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double leadingWidth = leading == null ? 0.0 : _minWidth(leading, height) + _leadingHorizontalGapWidth;
    final double titleWidth = _minWidth(title, height);
    final double subtitleWidth = _minWidth(subtitle, height);
    final double trailingWidth = trailing == null ? 0.0 : _minWidth(trailing, height) + _trailingHorizontalGapWidth;
    return leadingWidth + math.max(titleWidth, subtitleWidth) + trailingWidth;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading == null ? 0.0 : _maxWidth(leading, height) + _leadingHorizontalGapWidth;
    final double titleWidth = _maxWidth(title, height);
    final double subtitleWidth = _maxWidth(subtitle, height);
    final double trailingWidth = trailing == null ? 0.0 : _maxWidth(trailing, height) + _trailingHorizontalGapWidth;
    return leadingWidth + math.max(titleWidth, subtitleWidth) + trailingWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double subtitleHeight = subtitle == null
        ? 0.0
        : subtitle!.getMinIntrinsicHeight(width) + _subtitleVerticalGapHeight;
    return title.getMinIntrinsicHeight(width) + subtitleHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    final BoxParentData parentData = title.parentData! as BoxParentData;
    final BaselineOffset offset = BaselineOffset(title.getDistanceToActualBaseline(baseline)) + parentData.offset.dy;
    return offset.offset;
  }

  static void _positionBox(RenderBox box, Offset offset) {
    final BoxParentData parentData = box.parentData! as BoxParentData;
    parentData.offset = offset;
  }

  _Sizes _computeSizes(
    ChildLayouter getSize,
    BoxConstraints constraints, {
    _PositionChild? positionChild,
  }) {
    final BoxConstraints looseConstraints = constraints.loosen();
    final double tileWidth = looseConstraints.maxWidth;

    final RenderBox? leading = this.leading;
    final RenderBox? subtitle = this.subtitle;
    final RenderBox? trailing = this.trailing;

    // Layout trailing first to know available width
    final Size? trailingSize = trailing == null ? null : getSize(trailing, looseConstraints);
    final double trailingWidth = trailingSize != null ? trailingSize.width + _trailingHorizontalGapWidth : 0.0;

    // Layout leading
    final Size? leadingSize = leading == null ? null : getSize(leading, looseConstraints);
    final double leadingWidth = leadingSize != null ? leadingSize.width + _leadingHorizontalGapWidth : 0.0;

    // Calculate available width for title and subtitle
    final double availableWidth = tileWidth - leadingWidth - trailingWidth;
    final BoxConstraints textConstraints = looseConstraints.tighten(width: availableWidth);

    // Layout title and subtitle
    final Size titleSize = getSize(title, textConstraints);
    final Size? subtitleSize = subtitle == null ? null : getSize(subtitle, textConstraints);

    // Calculate positions
    // Title is always at y=0 (top aligned after padding)
    final double titleY = 0.0;

    // Determine subtitle Y position based on what's taller: leading or title
    final double leadingHeight = leadingSize?.height ?? 0.0;
    final double baseHeight = math.max(leadingHeight, titleSize.height);
    final double subtitleY = baseHeight + _subtitleVerticalGapHeight;

    // Calculate total tile height
    final double tileHeight = subtitleSize != null ? subtitleY + subtitleSize.height : baseHeight;

    if (positionChild != null) {
      // Position title (always left aligned after leading)
      positionChild(
        title,
        Offset(leadingWidth, titleY),
      );

      // Position subtitle (always left aligned after leading)
      if (subtitle != null) {
        positionChild(
          subtitle,
          Offset(0, subtitleY),
        );
      }

      // Position leading (left aligned at top)
      if (leading != null && leadingSize != null) {
        positionChild(
          leading,
          Offset(0.0, 0.0),
        );
      }

      // Position trailing (right aligned, vertically centered)
      if (trailing != null && trailingSize != null) {
        final double trailingY = (tileHeight - trailingSize.height) / 2.0;
        positionChild(
          trailing,
          Offset(
            tileWidth - trailingSize.width,
            trailingY,
          ),
        );
      }
    }

    return (
      titleY: titleY,
      textConstraints: textConstraints,
      tileSize: Size(tileWidth, tileHeight),
    );
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.constrain(
      _computeSizes(
        ChildLayoutHelper.dryLayoutChild,
        constraints,
      ).tileSize,
    );
  }

  @override
  void performLayout() {
    final Size tileSize = _computeSizes(
      ChildLayoutHelper.layoutChild,
      constraints,
      positionChild: _positionBox,
    ).tileSize;

    size = constraints.constrain(tileSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        final BoxParentData parentData = child.parentData! as BoxParentData;
        context.paintChild(child, parentData.offset + offset);
      }
    }

    doPaint(leading);
    doPaint(title);
    doPaint(subtitle);
    doPaint(trailing);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final BoxParentData parentData = child.parentData! as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - parentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }
}
