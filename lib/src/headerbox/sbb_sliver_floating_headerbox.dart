import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/headerbox/sbb_headerbox_content.dart';

import '../../sbb_design_system_mobile.dart';
import 'sliver_pinned_floating_widget.dart';

// AnimationStyle was not `const` until recently.
final defaultAnimationStyle = AnimationStyle(
  duration: Durations.short2,
  curve: Curves.linear,
  reverseDuration: Durations.short2,
  reverseCurve: Curves.linear,
);

/// A floating, expanding, and contracting version of the SBB Sliver Headerbox.
///
/// This widget behaves the same as [SBBSliverHeaderbox] but allows you to include contracting children.
/// To achieve this effect, the widget looks at the minimum and maximum intrinsic heights and transitions between them.
///
/// The easiest way to get started is like so:
///
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SBBSliverFloatingHeaderbox(
///       title: 'Title',
///       secondaryLabel: 'Subtitle',
///       collapsibleChild: Text('Collapsible'),
///     )
///   ]
/// )
/// ```
///
/// See [SBBStackedColumn] and [SBBStackedItem] for ways to build contracting items.
class SBBSliverFloatingHeaderbox extends StatefulWidget {
  /// The default [SBBSliverFloatingHeaderbox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBTertiaryButtonSmall] with a label and an icon.
  ///
  /// Use the [margin] to adjust space around the Headerbox - the default is horizontal margin of 8px.
  ///
  /// Additionally, you can set [collapsibleChild] for some content that will be obscured (and reappears) as the
  /// user scrolls the containing viewport. You can also temporarily disable this behavior by setting [floating]
  /// to `false`.
  ///
  /// You can also use [preceding] to set a widget above the headerbox that will go along with the scroll behavior of
  /// the headerbox.
  ///
  /// For a complete customization of the Headerbox, see the [SBBSliverFloatingHeaderbox.custom_old] constructor.
  SBBSliverFloatingHeaderbox({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    Widget? preceding,
    Widget? collapsibleChild,
    bool floating = true,
    AnimationStyle? snapStyle,
  }) : this.custom(
         key: key,
         flap: flap,
         margin: margin,
         preceding: preceding,
         semanticsLabel: semanticsLabel,
         snapStyle: snapStyle,
         children: [
           DefaultHeaderBoxContent(
             title: title,
             leadingIcon: leadingIcon,
             secondaryLabel: secondaryLabel,
             trailingWidget: trailingWidget,
           ),
           if (collapsibleChild != null)
             SBBStackedItem.aligned(
               child: Padding(
                 padding: const EdgeInsets.only(top: sbbDefaultSpacing),
                 child: collapsibleChild,
               ),
             ),
         ],
       );

  /// The large [SBBSliverFloatingHeaderbox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBIconButtonLarge].
  ///
  /// Use the [margin] to adjust space around the Headerbox - the default is horizontal margin of 8px.
  ///
  /// Additionally, you can set [collapsibleChild] for some content that will be obscured (and reappears) as the
  /// user scrolls the containing viewport. You can also temporarily disable this behavior by setting [floating]
  /// to `false`.
  ///
  /// You can also use [preceding] to set a widget above the headerbox that will go along with the scroll behavior of
  /// the headerbox.
  ///
  /// For a complete customization of the Headerbox, see the [SBBSliverFloatingHeaderbox.custom] constructor.
  SBBSliverFloatingHeaderbox.large({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    Widget? preceding,
    Widget? collapsibleChild,
    bool floating = true,
    AnimationStyle? snapStyle,
  }) : this.custom(
         key: key,
         flap: flap,
         margin: margin,
         preceding: preceding,
         semanticsLabel: semanticsLabel,
         snapStyle: snapStyle,
         children: [
           LargeHeaderBoxContent(
             title: title,
             leadingIcon: leadingIcon,
             secondaryLabel: secondaryLabel,
             trailingWidget: trailingWidget,
           ),
           if (collapsibleChild != null)
             SBBStackedItem.aligned(
               child: Padding(
                 padding: const EdgeInsets.only(top: sbbDefaultSpacing),
                 child: collapsibleChild,
               ),
             ),
         ],
       );

  /// Allows complete customization of the [SBBSliverHeaderbox].
  ///
  /// Note that the [children] can -- and should -- make use of [SBBStackedItem] to customize the way they collapse.
  /// You will normally have one or more static widgets, followed by one or more stacked item widgets like so:
  ///
  /// ```dart
  /// CustomScrollView(
  ///   slivers: [
  ///     SBBSliverFloatingHeaderbox.custom(
  ///       _StaticHeader(),
  ///       SBBStackedItem.aligned(
  ///         alignment: Alignment.bottomLeft,
  ///         child: ...
  ///       ).
  ///     )
  ///   ]
  /// )
  /// ```
  SBBSliverFloatingHeaderbox.custom({
    super.key,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    EdgeInsets padding = const EdgeInsets.all(sbbDefaultSpacing),
    SBBHeaderboxFlap? flap,
    String? semanticsLabel,
    this.floating = true,
    this.snapStyle,
    Widget? preceding,
    required List<Widget> children,
  }) : child =
           preceding != null
               ? SBBStackedColumn(
                 children: [
                   _Preceding(child: preceding),
                   SBBHeaderbox.custom(
                     margin: margin,
                     padding: padding,
                     flap: flap,
                     semanticsLabel: semanticsLabel,
                     child: SBBStackedColumn(children: children),
                   ),
                 ],
               )
               : SBBHeaderbox.custom(
                 margin: margin,
                 padding: padding,
                 flap: flap,
                 semanticsLabel: semanticsLabel,
                 child: SBBStackedColumn(children: children),
               );

  final Widget child;
  final AnimationStyle? snapStyle;
  final bool floating;

  @override
  State<SBBSliverFloatingHeaderbox> createState() => _SBBSliverFloatingHeaderboxState();

  /// Allows you to expand the header box.
  /// [context] is expected to be a descendant of the header box.
  static Future<void> expand(BuildContext context) async {
    await context.findAncestorStateOfType<_SnapTriggerState>()?.onSnapRequested(true);
  }

  /// Allows you to contract the header box.
  /// [context] is expected to be a descendant of the header box.
  static Future<void> contract(BuildContext context) async {
    await context.findAncestorStateOfType<_SnapTriggerState>()?.onSnapRequested(false);
  }
}

class _SBBSliverFloatingHeaderboxState extends State<SBBSliverFloatingHeaderbox> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverPinnedFloatingWidget(
      vsync: this,
      animationStyle: widget.snapStyle ?? defaultAnimationStyle,
      snapMode: FloatingHeaderSnapMode.scroll,
      floating: widget.floating,
      child: _SnapTrigger(
        child: widget.child,
      ),
    );
  }
}

class _SnapTrigger extends StatefulWidget {
  const _SnapTrigger({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  _SnapTriggerState createState() => _SnapTriggerState();
}

class _SnapTriggerState extends State<_SnapTrigger> {
  ScrollPosition? position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (position != null) {
      position!.isScrollingNotifier.removeListener(isScrollingListener);
    }
    position = Scrollable.maybeOf(context)?.position;
    if (position != null) {
      position!.isScrollingNotifier.addListener(isScrollingListener);
    }
  }

  @override
  void dispose() {
    if (position != null) {
      position!.isScrollingNotifier.removeListener(isScrollingListener);
    }
    super.dispose();
  }

  // Called when the sliver starts or ends scrolling.
  void isScrollingListener() {
    assert(position != null);
    final RenderSliverPinnedFloatingWidget? renderer =
        context.findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();

    renderer?.isScrollingUpdate(position!);
  }

  Future<void> onSnapRequested(bool expand) async {
    final RenderSliverPinnedFloatingWidget? renderer =
        context.findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();

    await renderer?.snap(expand ? ScrollDirection.forward : ScrollDirection.reverse);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Widget that can be displayed above the headerbox and that will scroll along.
class _Preceding extends StatelessWidget {
  const _Preceding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return SBBStackedItem.aligned(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: style.headerBackgroundColor,
        child: child,
      ),
    );
  }
}


/// This spacer should be placed at the very bottom of a scroll view that has
/// a [SBBSliverFloatingHeaderbox].
///
/// It will make sure that the scroll view has enough space to expand and contract
/// the headerbox.
class SBBSliverFloatingHeaderboxSpacer extends LeafRenderObjectWidget {
  const SBBSliverFloatingHeaderboxSpacer({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSBBSliverFloatingHeaderboxSpacer();
  }
}

class _RenderSBBSliverFloatingHeaderboxSpacer extends RenderSliver {
  @override
  void performLayout() {
    final firstSibling = _header();
    final scrollExtent = firstSibling?.extent ?? 0.0;

    var size = 0.0;
    if (constraints.precedingScrollExtent > constraints.viewportMainAxisExtent &&
        constraints.precedingScrollExtent < constraints.viewportMainAxisExtent + scrollExtent) {
      size = (constraints.viewportMainAxisExtent + scrollExtent) - constraints.precedingScrollExtent;
    }

    geometry = SliverGeometry(
      scrollExtent: size,
    );
  }

  RenderSliverPinnedFloatingWidget? _header() {
    var parentData = this.parentData as ContainerParentDataMixin<RenderSliver>;

    while (parentData.previousSibling != null) {
      final renderObject = parentData.previousSibling!;
      parentData = renderObject.parentData as ContainerParentDataMixin<RenderSliver>;

      if (renderObject is RenderSliverPinnedFloatingWidget) {
        return renderObject;
      }
    }

    return null;
  }
}
