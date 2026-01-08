import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../sbb_design_system_mobile.dart';
import 'divider_painter.dart';

typedef _Sizes = ({double titleY, BoxConstraints textConstraints, Size tileSize});
typedef _PositionChild = void Function(RenderBox child, Offset offset);

enum _SBBListItemSlot { leading, title, subtitle, trailing }

/// TODO: add isLoading state
/// TODO: make widgetStatesController internal only
/// TODO: add styling and themeData
/// TODO: add DefaultTextStyle & DefaultIconThemeData
/// TODO: add focusNode & autofocus
/// TODO: add documentation
/// TODO: overhaul all convenience ListItems (Radio, Checkbox, Switch)

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
    this.isLoading = false,
    this.links,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    this.statesController,
    this.trailingHorizontalGapWidth = 16.0,
    this.leadingHorizontalGapWidth = 8.0,
    this.subtitleVerticalGapHeight = 4.0,
  }) : assert(title != null || titleText != null, 'Either title or titleText must be provided'),
       assert(title == null || titleText == null, 'Only one of title or titleText can be set'),
       assert(subtitle == null || subtitleText == null, 'Only one of subtitle or subtitleText can be set'),
       assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set'),
       assert(trailing == null || trailingIconData == null, 'Only one of trailing or trailingIconData can be set');

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

  final bool isLoading;

  final EdgeInsetsGeometry padding;

  final Iterable<Widget>? links;

  final MaterialStatesController? statesController;

  final double trailingHorizontalGapWidth;

  final double leadingHorizontalGapWidth;

  final double subtitleVerticalGapHeight;

  /// Add a one pixel border in between each tile. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used, which defaults to
  /// [SBBBaseStyle.dividerColor].
  static Iterable<Widget> divideListItems({
    BuildContext? context,
    required Iterable<Widget> items,
    Color? color,
  }) {
    assert(color != null || context != null);
    items = items.toList();

    if (items.isEmpty || items.length == 1) {
      return items;
    }

    final resolvedColor = color ?? Theme.of(context!).dividerTheme.color ?? SBBColors.graphite;

    Widget wrapListItem(Widget link) {
      return CustomPaint(
        painter: SBBDividerPainter(
          paintAtTop: false,
          color: resolvedColor,
          indent: 0.0,
        ),
        child: link,
      );
    }

    return <Widget>[...items.take(items.length - 1).map(wrapListItem), items.last];
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

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

    Widget child = InkWell(
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
          trailingHorizontalGapWidth: trailingHorizontalGapWidth,
          leadingHorizontalGapWidth: leadingHorizontalGapWidth,
          subtitleVerticalGapHeight: subtitleVerticalGapHeight,
        ),
      ),
    );

    if (isLoading) {
      child = Stack(
        alignment: Alignment.bottomCenter,
        children: [
          child,
          BottomLoadingIndicator(),
        ],
      );
    }

    if (links?.isNotEmpty ?? false) {
      child = Column(
        children: [
          child,
          ..._divideLinks(context: context, links: links!),
        ],
      );
    }

    return child;
  }

  Iterable<Widget> _divideLinks({
    BuildContext? context,
    required Iterable<Widget> links,
    Color? color,
    double indent = 16.0,
  }) {
    assert(color != null || context != null);
    links = links.toList();

    if (links.isEmpty) return links;

    final resolvedColor = color ?? Theme.of(context!).dividerTheme.color ?? SBBColors.graphite;

    Widget wrapLink(Widget link) {
      return CustomPaint(
        painter: SBBDividerPainter(
          paintAtTop: true,
          color: resolvedColor,
          indent: indent,
        ),
        child: link,
      );
    }

    return links.map(wrapLink);
  }
}

class _SBBListItemV5 extends SlottedMultiChildRenderObjectWidget<_SBBListItemSlot, RenderBox> {
  const _SBBListItemV5({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.trailingHorizontalGapWidth,
    required this.leadingHorizontalGapWidth,
    required this.subtitleVerticalGapHeight,
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final double trailingHorizontalGapWidth;
  final double leadingHorizontalGapWidth;
  final double subtitleVerticalGapHeight;

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
    return _RenderSBBListItemV5(
      trailingHorizontalGapWidth: trailingHorizontalGapWidth,
      leadingHorizontalGapWidth: leadingHorizontalGapWidth,
      subtitleVerticalGapHeight: subtitleVerticalGapHeight,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSBBListItemV5 renderObject) {
    renderObject
      ..trailingHorizontalGapWidth = trailingHorizontalGapWidth
      ..leadingHorizontalGapWidth = leadingHorizontalGapWidth
      ..subtitleVerticalGapHeight = subtitleVerticalGapHeight;
  }
}

class _RenderSBBListItemV5 extends RenderBox with SlottedContainerRenderObjectMixin<_SBBListItemSlot, RenderBox> {
  _RenderSBBListItemV5({
    required double trailingHorizontalGapWidth,
    required double leadingHorizontalGapWidth,
    required double subtitleVerticalGapHeight,
  }) : _trailingHorizontalGapWidth = trailingHorizontalGapWidth,
       _leadingHorizontalGapWidth = leadingHorizontalGapWidth,
       _subtitleVerticalGapHeight = subtitleVerticalGapHeight;

  double _trailingHorizontalGapWidth;
  double _leadingHorizontalGapWidth;
  double _subtitleVerticalGapHeight;

  double get trailingHorizontalGapWidth => _trailingHorizontalGapWidth;

  set trailingHorizontalGapWidth(double value) {
    if (_trailingHorizontalGapWidth == value) {
      return;
    }
    _trailingHorizontalGapWidth = value;
    markNeedsLayout();
  }

  double get leadingHorizontalGapWidth => _leadingHorizontalGapWidth;

  set leadingHorizontalGapWidth(double value) {
    if (_leadingHorizontalGapWidth == value) {
      return;
    }
    _leadingHorizontalGapWidth = value;
    markNeedsLayout();
  }

  double get subtitleVerticalGapHeight => _subtitleVerticalGapHeight;

  set subtitleVerticalGapHeight(double value) {
    if (_subtitleVerticalGapHeight == value) {
      return;
    }
    _subtitleVerticalGapHeight = value;
    markNeedsLayout();
  }

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

    final Size? trailingSize = trailing == null ? null : getSize(trailing, looseConstraints);
    final double trailingWidth = trailingSize != null ? trailingSize.width + _trailingHorizontalGapWidth : 0.0;

    final Size? leadingSize = leading == null ? null : getSize(leading, looseConstraints);
    final double leadingWidth = leadingSize != null ? leadingSize.width + _leadingHorizontalGapWidth : 0.0;

    _makeOverflowAssertion(tileWidth, leadingSize, trailingSize);

    // Calculate available width for title and subtitle
    final double availableTitleWidth = tileWidth - leadingWidth - trailingWidth;
    final BoxConstraints titleConstraints = looseConstraints.tighten(width: availableTitleWidth);

    final double availableSubTitleWidth = tileWidth - trailingWidth;
    final BoxConstraints subTitleConstraints = looseConstraints.tighten(width: availableSubTitleWidth);

    // Layout title and subtitle
    final Size titleSize = getSize(title, titleConstraints);
    final Size? subtitleSize = subtitle == null ? null : getSize(subtitle, subTitleConstraints);

    // Calculate positions
    // Title is always at y=0
    final double titleY = 0.0;

    // Determine subtitle Y position based on what's taller: leading or title
    final double leadingHeight = leadingSize?.height ?? 0.0;
    final double subtitleOffsetHeight = math.max(leadingHeight, titleSize.height);
    final double subtitleY = subtitleOffsetHeight + _subtitleVerticalGapHeight;

    // Calculate total tile height
    final double tileHeight = subtitleSize != null ? subtitleY + subtitleSize.height : subtitleOffsetHeight;

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
        positionChild(leading, Offset.zero);
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
      textConstraints: titleConstraints,
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

  void _makeOverflowAssertion(double tileWidth, Size? leadingSize, Size? trailingSize) {
    assert(() {
      if (tileWidth == 0.0) {
        return true;
      }

      String? overflowedWidget;
      if (tileWidth == leadingSize?.width) {
        overflowedWidget = 'Leading';
      } else if (tileWidth == trailingSize?.width) {
        overflowedWidget = 'Trailing';
      }

      if (overflowedWidget == null) {
        return true;
      }

      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
          '$overflowedWidget widget consumes the entire tile width (including ListTile.contentPadding).',
        ),
        ErrorDescription(
          'Either resize the tile width so that the ${overflowedWidget.toLowerCase()} widget plus any content padding '
          'do not exceed the tile width, or use a sized widget, or consider replacing '
          'ListTile with a custom widget.',
        ),
        ErrorHint(
          'See also: https://api.flutter.dev/flutter/material/ListTile-class.html#material.ListTile.4',
        ),
      ]);
    }());
  }
}

class _IndentedDividerPainter extends CustomPainter {
  const _IndentedDividerPainter({
    required this.color,
    required this.indent,
  });

  final Color color;
  final double indent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    canvas.drawLine(
      Offset(indent, 0),
      Offset(size.width, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(_IndentedDividerPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.indent != indent;
  }
}
