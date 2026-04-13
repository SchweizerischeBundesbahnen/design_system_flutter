import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/header_box/sbb_header_box_content.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';
import 'sliver_pinned_floating_widget.dart';

part 'sbb_sliver_floating_header_box.header_box.dart';

part 'sbb_sliver_floating_header_box.spacer.dart';

final defaultSnapStyle = const AnimationStyle(
  duration: Durations.short2,
  curve: Curves.linear,
  reverseDuration: Durations.short2,
  reverseCurve: Curves.linear,
);

/// A floating, expanding, and contracting version of the SBB Sliver Header-Box.
///
/// This widget behaves the same as [SBBSliverHeaderBox] but allows you to include contracting children.
/// To achieve this effect, the widget transitions between the minimum and maximum intrinsic heights.
///
/// A minimal example would be:
///
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SBBSliverFloatingHeaderBox(
///       title: 'Title',
///       secondaryLabel: 'Subtitle',
///       collapsibleChild: Text('Collapsible'),
///     ),
///     // ...
///     const SBBSliverFloatingHeaderBoxSpacer(),
///   ]
/// )
/// ```
///
/// See also:
///
///  * [SBBCascadeColumn] and [SBBContractible], for ways to build contracting items.
///  * [SBBSliverFloatingHeaderBoxSpacer], for a widget that should always come last in the list of slivers.
///
/// ## Limitations & Considerations
///
/// This widget makes heavy use of intrinsics. This means two things:
///
/// - It is relatively expensive, see [IntrinsicHeight].
/// - You cannot use [LayoutBuilder].
///
class SBBSliverFloatingHeaderBox extends StatefulWidget {
  /// The default [SBBSliverFloatingHeaderBox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBTertiaryButtonSmall] with a label and an icon.
  ///
  /// Use the [margin] to adjust space around the header box - the default is horizontal margin of 8px.
  ///
  /// Additionally, you can set [contractibleChild] for some content that will be obscured (and reappears) as the
  /// user scrolls the containing viewport. You can also temporarily disable this behavior by setting [resizing]
  /// to `false`.
  ///
  /// By default, this header will *float*, i.e. it will expand immediately as the user scrolls in the opposite
  /// direction. You can disable this behavior by setting [floating] to `false`. In this case, the headerbox will only
  /// expand when scrolling back to the top.
  ///
  /// You can also use [preceding] to set a widget above the headerbox that will go along with the scroll behavior of
  /// the headerbox.
  ///
  /// For a complete customization of the header box, see the [SBBSliverFloatingHeaderBox.custom] constructor.
  SBBSliverFloatingHeaderBox({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderBoxFlap? flap,
    SBBHeaderBoxFlapMode flapMode = .static,
    EdgeInsets margin = const .symmetric(horizontal: SBBSpacing.xSmall),
    String? semanticsLabel,
    Widget? preceding,
    Widget? contractibleChild,
    bool floating = true,
    bool resizing = true,
    AnimationStyle? snapStyle,
  }) : this.custom(
         key: key,
         flap: flap,
         flapMode: flapMode,
         margin: margin,
         preceding: preceding,
         semanticsLabel: semanticsLabel,
         snapStyle: snapStyle,
         resizing: resizing,
         floating: floating,
         children: [
           DefaultHeaderBoxContent(
             titleText: title,
             leadingIconData: leadingIcon,
             subtitleText: secondaryLabel,
             trailing: trailingWidget,
           ),
           if (contractibleChild != null)
             _CollapsibleContent(
               child: contractibleChild,
             ),
         ],
       );

  /// The large [SBBSliverFloatingHeaderBox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBIconButtonLarge].
  ///
  /// Use the [margin] to adjust space around the header box - the default is horizontal margin of 8px.
  ///
  /// Additionally, you can set [collapsibleChild] for some content that will be obscured (and reappears) as the
  /// user scrolls the containing viewport. You can also temporarily disable this behavior by setting [resizing]
  /// to `false`.
  ///
  /// By default, this header will *float*, i.e. it will expand immediately as the user scrolls in the opposite
  /// direction. You can disable this behavior by setting [floating] to `false`. In this case, the headerbox will only
  /// expand when scrolling back to the top.
  ///
  /// You can also use [preceding] to set a widget above the headerbox that will go along with the scroll behavior of
  /// the headerbox.
  ///
  /// For a complete customization of the header box, see the [SBBSliverFloatingHeaderBox.custom] constructor.
  SBBSliverFloatingHeaderBox.large({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderBoxFlap? flap,
    SBBHeaderBoxFlapMode flapMode = .static,
    EdgeInsets margin = const .symmetric(horizontal: SBBSpacing.xSmall),
    String? semanticsLabel,
    Widget? preceding,
    Widget? collapsibleChild,
    bool floating = true,
    bool resizing = true,
    AnimationStyle? snapStyle,
  }) : this.custom(
         key: key,
         flap: flap,
         flapMode: flapMode,
         margin: margin,
         preceding: preceding,
         semanticsLabel: semanticsLabel,
         snapStyle: snapStyle,
         resizing: resizing,
         floating: floating,
         children: [
           LargeHeaderBoxContent(
             titleText: title,
             leadingIconData: leadingIcon,
             subtitleText: secondaryLabel,
             trailing: trailingWidget,
           ),
           if (collapsibleChild != null) SBBContractible(child: SizedBox(height: SBBSpacing.medium)),
           if (collapsibleChild != null) _CollapsibleContent(child: collapsibleChild),
         ],
       );

  /// Allows complete customization of the [SBBSliverFloatingHeaderBox].
  ///
  /// Note that the [children] can -- and should -- make use of [SBBContractible] to customize the way they collapse.
  /// You will normally have one or more static widgets, followed by one or more contractible widgets like so:
  ///
  /// ```dart
  /// CustomScrollView(
  ///   slivers: [
  ///     SBBSliverFloatingHeaderBox.custom(
  ///       children: [
  ///         _StaticHeader(),
  ///         SBBContractible(
  ///           child: ...
  ///         ),
  ///       ],
  ///     ),
  ///     const SBBSliverFloatingHeaderBoxSpacer(),
  ///   ]
  /// )
  /// ```
  ///
  /// See also:
  ///
  ///  * [SBBContractible], which shrinkable children should be wrapped in.
  ///  * [SBBContractionListener], which allows you to get updates on the expansion rate.
  SBBSliverFloatingHeaderBox.custom({
    super.key,
    EdgeInsets margin = const .symmetric(horizontal: SBBSpacing.xSmall),
    EdgeInsets padding = const .all(SBBSpacing.medium),
    SBBHeaderBoxFlap? flap,
    SBBHeaderBoxFlapMode flapMode = .static,
    String? semanticsLabel,
    this.resizing = true,
    this.floating = true,
    this.snapStyle,
    this.snapMode = .scroll,
    Widget? preceding,
    required List<Widget> children,
  }) : child = preceding != null
           ? SBBCascadeColumn(
               children: [
                 _Preceding(child: preceding),
                 _HeaderBox(
                   margin: margin,
                   padding: padding,
                   flap: flap,
                   flapMode: flapMode,
                   semanticsLabel: semanticsLabel,
                   child: SBBCascadeColumn(children: children),
                 ),
               ],
             )
           : _HeaderBox(
               margin: margin,
               padding: padding,
               flap: flap,
               flapMode: flapMode,
               semanticsLabel: semanticsLabel,
               child: SBBCascadeColumn(children: children),
             );

  final Widget child;

  /// Controls the speed and curve the headerbox uses when snapping to its contracted or expanded state.
  /// Defaults to [defaultSnapStyle].
  final AnimationStyle? snapStyle;

  /// Controls the way the headerbox snaps, i.e. if it scrolls the content or expands / contracts independently.
  /// Defaults to [FloatingHeaderSnapMode.scroll].
  final FloatingHeaderSnapMode snapMode;
  final bool resizing;
  final bool floating;

  @override
  State<SBBSliverFloatingHeaderBox> createState() => _SBBSliverFloatingHeaderBoxState();

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

class _SBBSliverFloatingHeaderBoxState extends State<SBBSliverFloatingHeaderBox> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverPinnedFloatingWidget(
      vsync: this,
      animationStyle: widget.snapStyle ?? defaultSnapStyle,
      snapMode: widget.snapMode,
      resizing: widget.resizing,
      floating: widget.floating,
      child: _SnapTrigger(
        child: widget.child,
      ),
    );
  }
}

class _CollapsibleContent extends StatelessWidget {
  const _CollapsibleContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // This is a bit unwieldy, but it does two things:
    //
    // 1. Move contents down by the default padding, so that the box will clip them "naturally" by its edge.
    // 2. Allow users to provide their own SBBContractible for custom effects while still preserving said padding.
    return SBBContractible.custom(
      child: SBBCascadeColumn(
        children: [
          SizedBox(height: SBBSpacing.medium),
          child,
        ],
      ),
    );
  }
}

class _SnapTrigger extends StatefulWidget {
  const _SnapTrigger({
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
    // Scrolling events are kind of broken on web
    if (kIsWeb) return;

    assert(position != null);
    final RenderSliverPinnedFloatingWidget? renderer = context
        .findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();

    renderer?.onScrollingUpdate(position!);
  }

  Future<void> onSnapRequested(bool expand) async {
    final RenderSliverPinnedFloatingWidget? renderer = context
        .findAncestorRenderObjectOfType<RenderSliverPinnedFloatingWidget>();

    await renderer?.snap(expand ? .forward : .reverse);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Widget that can be displayed above the headerbox and that will scroll along.
class _Preceding extends StatelessWidget {
  const _Preceding({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;
    return SBBContractible(
      behavior: .displace,
      child: Container(
        color: appBarTheme.backgroundColor,
        child: child,
      ),
    );
  }
}
