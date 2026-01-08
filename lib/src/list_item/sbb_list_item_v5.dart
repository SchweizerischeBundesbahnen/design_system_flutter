import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/shared/bottom_loading_indicator.dart';

import '../../sbb_design_system_mobile.dart';
import 'divider_painter.dart';

typedef _Sizes = ({double titleY, BoxConstraints textConstraints, Size tileSize});
typedef _PositionChild = void Function(RenderBox child, Offset offset);

enum _SBBListItemSlot { leading, title, subtitle, trailing }

/// TODO: add semantics
/// TODO: add documentation
/// TODO: overhaul all convenience ListItems (Radio, Checkbox, Switch)

class SBBListItemV5 extends StatefulWidget {
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
    this.padding,
    this.trailingHorizontalGapWidth,
    this.leadingHorizontalGapWidth,
    this.subtitleVerticalGapHeight,
    this.style,
    this.focusNode,
    this.autofocus = false,
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

  /// maxLines 1 with Ellipsis overflow
  final String? titleText;

  final String? subtitleText;

  final IconData? trailingIconData;

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  final bool enabled;

  final bool isLoading;

  final FocusNode? focusNode;

  final bool autofocus;

  final Iterable<Widget>? links;

  final EdgeInsetsGeometry? padding;

  final double? trailingHorizontalGapWidth;

  final double? leadingHorizontalGapWidth;

  final double? subtitleVerticalGapHeight;

  /// Customizes this list item appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBListItemThemeData.style] of the theme found in [context].
  final SBBListItemV5Style? style;

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
  State<SBBListItemV5> createState() => _SBBListItemV5State();
}

class _SBBListItemV5State extends State<SBBListItemV5> {
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();
  }

  @override
  void didUpdateWidget(SBBListItemV5 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _updateStatesController();
    }
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, !widget.enabled);
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final themeData = Theme.of(context).sbbListItemTheme;
    final effectiveStyle = (themeData?.style ?? SBBListItemV5Style()).merge(widget.style);
    final states = _statesController.value;

    final effectivePadding =
        widget.padding ?? themeData?.padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0);
    final effectiveTrailingGapWidth =
        widget.trailingHorizontalGapWidth ?? themeData?.trailingHorizontalGapWidth ?? 16.0;
    final effectiveLeadingGapWidth = widget.leadingHorizontalGapWidth ?? themeData?.leadingHorizontalGapWidth ?? 8.0;
    final effectiveSubtitleGapHeight = widget.subtitleVerticalGapHeight ?? themeData?.subtitleVerticalGapHeight ?? 4.0;
    final effectiveOverlayColor = effectiveStyle.overlayColor;

    final resolvedTitleTextStyle = effectiveStyle.titleTextStyle?.resolve(states) ?? SBBTextStyles.mediumLight;
    final resolvedSubtitleTextStyle = effectiveStyle.subtitleTextStyle?.resolve(states) ?? SBBTextStyles.smallLight;
    final resolvedTitleForegroundColor = effectiveStyle.titleForegroundColor?.resolve(states);
    final resolvedSubtitleForegroundColor = effectiveStyle.subtitleForegroundColor?.resolve(states);
    final resolvedLeadingForegroundColor = effectiveStyle.leadingForegroundColor?.resolve(states);
    final resolvedTrailingForegroundColor = effectiveStyle.trailingForegroundColor?.resolve(states);
    final resolvedBackgroundColor = effectiveStyle.backgroundColor?.resolve(states);

    // Build actual widgets from convenience parameters
    Widget? leadingWidget = widget.leading;
    if (leadingWidget == null && widget.leadingIconData != null) {
      leadingWidget = Icon(widget.leadingIconData);
    }

    Widget? titleWidget = widget.title;
    if (titleWidget == null && widget.titleText != null) {
      titleWidget = Text(widget.titleText!, maxLines: 1, overflow: TextOverflow.ellipsis);
    }

    Widget? subtitleWidget = widget.subtitle;
    if (subtitleWidget == null && widget.subtitleText != null) {
      subtitleWidget = Text(widget.subtitleText!);
    }

    Widget? trailingWidget = widget.trailing;
    if (trailingWidget == null && widget.trailingIconData != null) {
      trailingWidget = Icon(widget.trailingIconData);
    }

    // Apply theming to all widgets
    if (leadingWidget != null) {
      leadingWidget = IconTheme.merge(
        data: IconThemeData(color: resolvedLeadingForegroundColor),
        child: leadingWidget,
      );
    }

    if (titleWidget != null) {
      titleWidget = DefaultTextStyle.merge(
        style: resolvedTitleTextStyle.copyWith(color: resolvedTitleForegroundColor),
        child: titleWidget,
      );
    }

    if (subtitleWidget != null) {
      subtitleWidget = DefaultTextStyle.merge(
        style: resolvedSubtitleTextStyle.copyWith(color: resolvedSubtitleForegroundColor),
        child: subtitleWidget,
      );
    }

    if (trailingWidget != null) {
      trailingWidget = IconTheme.merge(
        data: IconThemeData(color: resolvedTrailingForegroundColor),
        child: trailingWidget,
      );
    }

    Widget child = InkWell(
      onTap: widget.enabled ? widget.onTap : null,
      onLongPress: widget.enabled ? widget.onLongPress : null,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      statesController: _statesController,
      overlayColor: effectiveOverlayColor,
      child: Semantics(
        button: widget.onTap != null || widget.onLongPress != null,
        enabled: widget.enabled,
        focused: widget.focusNode?.hasFocus,
        child: Ink(
          color: resolvedBackgroundColor,
          child: Padding(
            padding: effectivePadding,
            child: _SBBListItemV5(
              leading: leadingWidget,
              title: titleWidget ?? const SizedBox(),
              subtitle: subtitleWidget,
              trailing: trailingWidget,
              trailingHorizontalGapWidth: effectiveTrailingGapWidth,
              leadingHorizontalGapWidth: effectiveLeadingGapWidth,
              subtitleVerticalGapHeight: effectiveSubtitleGapHeight,
            ),
          ),
        ),
      ),
    );

    if (widget.isLoading) {
      child = Stack(
        alignment: Alignment.bottomCenter,
        children: [
          child,
          BottomLoadingIndicator(),
        ],
      );
    }

    if (widget.links?.isNotEmpty ?? false) {
      child = Column(
        children: [
          child,
          ..._divideLinks(context: context, links: widget.links!),
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

class SBBListItemV5Boxed extends SBBListItemV5 {
  const SBBListItemV5Boxed({
    super.key,
    super.leading,
    super.title,
    super.subtitle,
    super.trailing,
    super.leadingIconData,
    super.titleText,
    super.subtitleText,
    super.trailingIconData,
    super.onTap,
    super.onLongPress,
    super.enabled,
    super.isLoading,
    super.links,
    super.padding,
    super.trailingHorizontalGapWidth,
    super.leadingHorizontalGapWidth,
    super.subtitleVerticalGapHeight,
    super.style,
    super.focusNode,
    super.autofocus,
  });

  @override
  State<SBBListItemV5> createState() => _SBBListItemV5BoxedState();
}

class _SBBListItemV5BoxedState extends _SBBListItemV5State {
  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
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

    // Calculate center-aligned positions for title and leading
    final double leadingHeight = leadingSize?.height ?? 0.0;
    final double titleHeight = titleSize.height;

    // Find the maximum height between leading and title for center alignment
    final double maxCenterHeight = math.max(leadingHeight, titleHeight);

    // Center-align title and leading
    final double titleY = (maxCenterHeight - titleHeight) / 2.0;
    final double leadingY = (maxCenterHeight - leadingHeight) / 2.0;

    // Position subtitle below the max of leading/title bottom
    final double subtitleY = maxCenterHeight + _subtitleVerticalGapHeight;

    // Calculate total tile height
    final double tileHeight = subtitleSize != null ? subtitleY + subtitleSize.height : maxCenterHeight;

    if (positionChild != null) {
      // Position title (left aligned after leading, vertically centered with leading)
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

      // Position leading (left aligned, vertically centered with title)
      if (leading != null && leadingSize != null) {
        positionChild(leading, Offset(0, leadingY));
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
