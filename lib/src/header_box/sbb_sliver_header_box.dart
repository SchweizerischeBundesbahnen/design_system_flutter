import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/header_box/header_box_content.dart';
import 'package:sbb_design_system_mobile/src/header_box/header_box_foreground.dart';
import 'package:sbb_design_system_mobile/src/header_box/header_box_inset.dart';

import '../../sbb_design_system_mobile.dart';
import 'sliver/sliver_pinned_floating_widget.dart';

enum SBBHeaderBoxFlapMode { static, resizable, hideable }

const defaultSnapStyle = AnimationStyle(
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
class SBBSliverHeaderBox extends StatelessWidget {
  /// The default [SBBSliverHeaderBox].
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
  const SBBSliverHeaderBox({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.flap,
    this.isLoading = false,
    this.margin,
    this.padding,
    this.style,
    this.semanticsLabel,
    this.flapMode = .static,
    this.snapStyle = defaultSnapStyle,
    this.snapMode = .scroll,
    this.resizing = true,
    this.floating = true,
    this.body,
    this.top,
  });

  /// {@macro sbb_design_system.header_box.leading}
  final Widget? leading;

  /// {@macro sbb_design_system.header_box.leadingIconData}
  final IconData? leadingIconData;

  /// {@macro sbb_design_system.header_box.title}
  final Widget? title;

  /// {@macro sbb_design_system.header_box.titleText}
  final String? titleText;

  /// {@macro sbb_design_system.header_box.subtitle}
  final Widget? subtitle;

  /// {@macro sbb_design_system.header_box.subtitleText}
  final String? subtitleText;

  /// {@macro sbb_design_system.header_box.trailing}
  final Widget? trailing;

  /// {@macro sbb_design_system.header_box.flap}
  final Widget? flap;

  /// {@macro sbb_design_system.header_box.isLoading}
  final bool isLoading;

  /// {@macro sbb_design_system.header_box.margin}
  final EdgeInsetsGeometry? margin;

  /// {@macro sbb_design_system.header_box.padding}
  final EdgeInsetsGeometry? padding;

  /// {@macro sbb_design_system.header_box.style}
  final SBBHeaderBoxStyle? style;

  /// {@macro sbb_design_system.header_box.semanticsLabel}
  final String? semanticsLabel;

  final bool floating;
  final bool resizing;

  /// A widget that appears above the header box and will participate in the resize motion if [resizing] is enabled.
  ///
  /// This may typically be a [SBBSegmentedButtonFilled].
  final Widget? top;

  /// {@macro sbb_design_system.header_box.body}
  ///
  /// You can use [SBBContractible] to make this part disappear on scroll.
  final Widget? body;

  /// Controls the way the headerbox snaps, i.e. if it scrolls the content or expands / contracts independently.
  /// Defaults to [FloatingHeaderSnapMode.scroll].
  final FloatingHeaderSnapMode snapMode;

  /// Controls the speed and curve the headerbox uses when snapping to its contracted or expanded state.
  /// Defaults to [defaultSnapStyle].
  final AnimationStyle? snapStyle;

  final SBBHeaderBoxFlapMode flapMode;

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

  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return (Theme.of(context).sbbHeaderBoxTheme?.style ?? SBBHeaderBoxStyle())
        .merge(style)
        .copyWith(margin: margin, padding: padding);
  }

  Widget _resolveContent(BuildContext context) {
    return DefaultHeaderBoxContent(
      leading: leading,
      leadingIconData: leadingIconData,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      style: _resolveStyle(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _BaseHeaderBox(
      flap: flap,
      content: _resolveContent(context),
      body: body,
      isLoading: isLoading,
      semanticsLabel: semanticsLabel,
      top: top,
      snapStyle: snapStyle,
      style: _resolveStyle(context),
      floating: floating,
      resizing: resizing,
      snapMode: snapMode,
      flapMode: flapMode,
    );
  }
}

class SBBSliverHeaderBoxLarge extends SBBSliverHeaderBox {
  const SBBSliverHeaderBoxLarge({
    super.key,
    super.leading,
    super.leadingIconData,
    super.title,
    super.titleText,
    super.subtitle,
    super.subtitleText,
    super.trailing,
    super.flap,
    super.isLoading = false,
    super.margin,
    super.padding,
    super.style,
    super.semanticsLabel,
    super.flapMode = .static,
    super.snapStyle = defaultSnapStyle,
    super.snapMode = .scroll,
    super.resizing = true,
    super.floating = true,
    super.top,
  });

  @override
  SBBHeaderBoxStyle _resolveStyle(BuildContext context) {
    return (Theme.of(context).sbbHeaderBoxTheme?.largeStyle ?? SBBHeaderBoxStyle())
        .merge(style)
        .copyWith(margin: margin, padding: padding);
  }

  @override
  Widget _resolveContent(BuildContext context) {
    return LargeHeaderBoxContent(
      leading: leading,
      leadingIconData: leadingIconData,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      style: _resolveStyle(context),
    );
  }
}

class _BaseHeaderBox extends StatefulWidget {
  const _BaseHeaderBox({
    this.top,
    this.content,
    this.body,
    this.flap,
    required this.isLoading,
    required this.style,
    this.semanticsLabel,
    required this.floating,
    required this.resizing,
    required this.snapMode,
    this.snapStyle,
    required this.flapMode,
  });

  final Widget? top;
  final Widget? content;
  final Widget? body;
  final Widget? flap;

  final bool isLoading;

  final SBBHeaderBoxStyle style;

  final String? semanticsLabel;

  final bool floating;
  final bool resizing;

  final FloatingHeaderSnapMode snapMode;
  final AnimationStyle? snapStyle;
  final SBBHeaderBoxFlapMode flapMode;

  @override
  State<_BaseHeaderBox> createState() => _BaseHeaderBoxState();
}

class _BaseHeaderBoxState extends State<_BaseHeaderBox> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final children = [
      if (widget.top != null) _Top(child: widget.top!),
      HeaderBoxAppBarInset(
        style: widget.style,
        child: HeaderBoxForeground(
          style: widget.style,
          semanticsLabel: widget.semanticsLabel,
          flap: widget.flap,
          isLoading: widget.isLoading,
          flapMode: widget.flapMode,
          child: SBBCascadeColumn(
            children: [
              ?widget.content,
              if (widget.body != null) widget.body!,
            ],
          ),
        ),
      ),
    ];

    return SliverPinnedFloatingWidget(
      vsync: this,
      animationStyle: widget.snapStyle ?? defaultSnapStyle,
      snapMode: widget.snapMode,
      resizing: widget.resizing,
      floating: widget.floating,
      child: _SnapTrigger(
        child: children.singleOrNull ?? SBBCascadeColumn(children: children),
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
class _Top extends StatelessWidget {
  const _Top({
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
